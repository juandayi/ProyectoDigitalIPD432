`timescale 1ns / 1ps
//Módulo principal del diseño donde son instanciados los demás módulos

module Main(
    input logic clkin,
    input logic uart_rx,
    output logic uart_tx
    
//	output logic [7:0] Ena
	
    );
		
	localparam N=32; //Ancho de la muestra
    localparam M=15; //2^M Cantidad de espacios de memoria

	
	

// VARIABLES FOR CLOCK 
	logic clk;
	
//VARIABLES FOR UART PORT	
     logic rx_ready;
     logic tx_busy;
     logic tx_start;
     logic [7:0] rx_data;
     logic [7:0] tx_data; 	
	 
// VARIABLES FOR SAVEUART 
   logic [M - 1:0] dir_in_uart;

    logic [N - 1:0] dato_uart_in;
    
    logic save_finish;
 // VARIABLES FOR SENDUART  
   logic [N - 1:0] dato_uart_out;
   logic [M - 1:0] dir_out_uart;
   logic WEA,ENA;


// VARIABLES FOR FFT
	
	
	logic [N - 1:0] dato_time;
	logic [M - 1:0] dir_time;
	logic [N - 1:0] dato_frequency;
	logic [M - 1:0] dir_frequency;
	logic save_ok_frequency;
// VARIABLES FOR FFT
//   logic [31:0] m_tdata;
	
// VARIABLES FOR ReceiveFFT
	 
	
	clk_wiz_0 CLK
       (
        // Clock out ports
        .clk_out1(clk),     // output clk_out1
            
        .clk_in1(clkin));      // input clk_in1
    
   //Uart 
	uart_rx_driver #(.CLK_FREQUENCY(100_000_000),.BAUD_RATE(115200))
           RX (
               .clk(clk),
               .reset(1'b0),
               .rx(uart_rx),
               .rx_data(rx_data),
               .rx_ready(rx_ready)
           );
           
     uart_tx_driver #(.CLK_FREQUENCY(100_000_000), .BAUD_RATE(115200))
           TX (
               .clk(clk),
               .reset(1'b0),
               .tx(uart_tx),
               .tx_start(tx_start),
               .tx_data(tx_data),
               .tx_busy(tx_busy)
           );
               
	
Save SaveUART (
        .clkin(clk),
        .enable(1'b1),
        .ENA(ENA),
        .WEA(WEA),
        .reset(1'b0),
        .rx_ready(rx_ready),
        .rx_data(rx_data),
        .dir_in_uart(dir_in_uart),
        .in_uart(dato_uart_in),
        .save_finish(save_finish)
        
        ); 

        blk_mem_gen_0 datos_dominio_tiempo (
          .clka(clk),    // input wire clka
          .ena(ENA),      // input wire ena
          .wea(WEA),      // input wire [0 : 0] wea
          .addra(dir_in_uart),  // input wire [4 : 0] addra
          .dina(dato_uart_in),    // input wire [31 : 0] dina
          .clkb(clk),    // input wire clkb
          .enb(1'b1),      // input wire enb
          .addrb(dir_time),  // input wire [4 : 0] addrb
          .doutb(dato_time)  // output wire [31 : 0] doutb
        );

       FFT FFT (
        .clkin(clk),
        .save_ok(save_finish),
        .dato_in_fft(dato_time),
        .dir_in_fft(dir_time),
        .dato_out_fft(dato_frequency),
        .dir_out_fft(dir_frequency),
        .save_ok_frequency(save_ok_frequency)
        

            );
	 blk_mem_gen_0 datos_dominio_frecuencia (
                     .clka(clk),    // input wire clka
                     .ena(1'b1),      // input wire ena
                     .wea(1'b1),      // input wire [0 : 0] wea
                     .addra(dir_frequency),  // input wire [4 : 0] addra
                     .dina(dato_frequency),    // input wire [31 : 0] dina
                     .clkb(clk),    // input wire clkb
                     .enb(1'b1),      // input wire enb
                     .addrb(dir_out_uart),  // input wire [4 : 0] addrb
                     .doutb(dato_uart_out)  // output wire [31 : 0] doutb
                   );
//	ila_1 your_instance_name (
//                       .clk(clk), // input wire clk
                   
                   
//                       .probe0(dir_frequency), // input wire [4:0]  probe0  
//                       .probe1(dir_out_uart), // input wire [4:0]  probe1 
//                       .probe2(dato_frequency), // input wire [31:0]  probe2 
//                       .probe3(dato_uart_out), // input wire [31:0]  probe3
//                       .probe4(save_ok_frequency)
//                   );
	
        SendUART SendUART (
            .clkin(clk),
            .reset(1'b0),
            .save_ok(save_ok_frequency),
            .tx_busy(tx_busy),
            .dato_uart_out(dato_uart_out),
            .dir_out_uart(dir_out_uart),
            .tx_start(tx_start),
            .tx_data(tx_data)	
            
             );
	
	
	
endmodule
