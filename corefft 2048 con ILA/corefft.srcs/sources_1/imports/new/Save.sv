`timescale 1ns / 1ps
//Modulo encargado de recibir los datos enviados por la Uart y empaquetarlos en formato de 32
//bits (16 bits datos reales y 16 bits datos imaginarios).

///N numero de datos por muestra recibidos por la UART
module Save #(parameter M=11, N = 32)(
    input logic clkin,
    input logic enable,
    input logic reset,
    input logic rx_ready,
    input logic [7:0] rx_data,
    output logic WEA,
    output logic ENA,
    output logic [M - 1:0] dir_in_uart,
    output logic [N - 1:0] in_uart,
	output logic save_finish
	
    ); 
		
		typedef enum logic [3:0] {IDLE, SAVE1, SAVE2, SAVE3, WRITE} state;
        state actual, proximo; 
        
        
        localparam ADDRA_MAX = 11'd2047; //Maximo addres al que llega RAM
            
            
            logic rx_ok_reg = 1'd0;  // Detector cantos
            logic [M-1:0] dir_in_uart_next = 5'd0;
            logic [N-1:0] in_uart_next;
            logic ena_next, wea_next, save_finish_next;
           
            
             // Maquina de estados
            always_comb  begin
                proximo = actual; // Por defecto
                in_uart_next = in_uart;
                dir_in_uart_next = dir_in_uart;
                save_finish_next=1'b0;
                
                
                case(actual)
				
                    IDLE: begin							                   
                        if (rx_ready & ~rx_ok_reg) begin
							in_uart_next[15:8] = rx_data; //Primer byte
							proximo = SAVE1;
					    end
                        end
						
                    SAVE1: begin                                                         
                        if (rx_ready & ~rx_ok_reg) begin 
							in_uart_next[7:0] = rx_data; //Segundo byte
							proximo = SAVE2;
                        end
                        else
							proximo = SAVE1;	
                        end
                    
                   
                                        
                    SAVE2: begin                                            
                        if (rx_ready & ~rx_ok_reg) begin 
                            in_uart_next[31:24] = rx_data; //Tercer byte
                            proximo = SAVE3;                        
                        end
                        else
                            proximo = SAVE2;
                        end
                    
                     
                      
                    SAVE3: begin//                        
                        if (rx_ready & ~rx_ok_reg) begin 
							in_uart_next[23:16] = rx_data; //Cuarto byte
							proximo = WRITE;
                        
                        end
                        else
							proximo = SAVE3;
                        end
                            

                    WRITE: begin    

                       if (dir_in_uart == ADDRA_MAX) begin 
							dir_in_uart_next = 5'd0; 
							save_finish_next=1'b1; 
					   end//paquete listo
                       else begin
                            dir_in_uart_next = dir_in_uart + 5'd1;
                                                                       
                       end 
                     proximo = IDLE;  
                    end 
					
                    default: proximo = IDLE;
               endcase
            end
            
            assign ENA = (actual == WRITE);
            assign WEA = (actual == WRITE); 
            
            always_ff @(posedge clkin) begin
                if(reset) begin
                    dir_in_uart <= 5'd0;
                    in_uart <= 31'd0;
                    actual <= IDLE;
                    rx_ok_reg <= 1'd0;              
                    save_finish <= 1'b0;
                end
                else begin
                    dir_in_uart <= dir_in_uart_next;
                    in_uart <= in_uart_next;
                    actual <= proximo;
                    rx_ok_reg <= rx_ready;
                    save_finish <=save_finish_next;
                end
            end     
			
			
   
			
             		
           
endmodule
