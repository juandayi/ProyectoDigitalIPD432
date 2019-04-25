`timescale 1ns / 1ps
//Módulo encargado de descargar los datos transformados proporcionados por Core FFT. Siendo el
//esclavo externo que le proporciona las senales necesarias para la comunicacion AXI4 Stream con el Core FFT


module UnloadFFT #(parameter M=15, N = 32)(
    input logic clk,
    input logic reset,
    input logic  m_tvalid,
    input logic [N-1:0] m_tdata,
    output logic [M-1:0] dir_frequency,
    output logic m_tready,
    output  logic [N-1:0] dato_frequency,
    output logic save_ok_frequency
//    output  logic [6:0] LED
    );
    
     typedef enum logic [2:0] {IDLE, SAVE1, SET, WAITSAVE} state;
         state actual, proximo; 
               
               
          localparam ADDRA_MAX = 15'd32767; //Maximo addres al que llega RAM
    
//     logic rx_ok_reg = 1'd0;  // Detector cantos
                   logic [M :0] dir_frequency_next = 5'd0;
                   logic [N-1:0] dato_frequency_next;
                   logic m_tready_next;
                   logic save_ok_frequency_next;
                   const logic [2:0] T1 = 2; 
                   const logic [2:0] tmax = 2;
                   logic [7:0] t;
                  
                   // Maquina de estados
                   always_comb  begin
                       proximo = actual; // Por defecto
                       dir_frequency_next = dir_frequency;
                       dato_frequency_next= dato_frequency;
                       m_tready_next = 1'b0;
                       save_ok_frequency_next = 1'b0; 
                       
                       case(actual)
                           IDLE: begin
                               
                               if (m_tvalid) begin   //recibo del core fft que hay una muestra de salida
//                               LED=7'b1000000;
                               proximo = SAVE1;
                               end
                               else
                               proximo = IDLE;
                                end
                         
                         SAVE1: begin
                         m_tready_next = 1'b1;
                         dato_frequency_next= m_tdata;
                         proximo= WAITSAVE;
                         end
                           
                           SET: begin
                                                                   
                                    
                            if(dir_frequency==ADDRA_MAX)
                            begin 
                                dir_frequency_next = 5'd0; 
                                save_ok_frequency_next = 1'b1;
                                proximo = IDLE; 
                            end
                            else begin                           
                                dir_frequency_next = dir_frequency + 5'd1;
                                m_tready_next = 1'b1;
                                dato_frequency_next= m_tdata;   
                                proximo =  WAITSAVE; 
                            end
                            end
                         
                          WAITSAVE:    begin
                              m_tready_next = 1'b0;
                                if (t>=T1-1) begin                                              
                                    proximo = SET;
                                end
                                else 
                                    proximo = WAITSAVE;   
                          end            
                          
                           default: proximo = IDLE;
                        endcase
                      end     
                                      
                                                              
                         
                          
                   
                   always_ff @(posedge clk) begin
                       if(reset) begin
                         dir_frequency <= 5'd0;
                         dato_frequency <= 32'd0;
                         m_tready <= 1'b0;
                         actual <= IDLE;
                         save_ok_frequency <=1'b0;
                          
                       end
                       else begin
                           dir_frequency <= dir_frequency_next;
                           dato_frequency <= dato_frequency_next;
                           actual <= proximo;
                           m_tready <= m_tready_next;
                           save_ok_frequency <= save_ok_frequency_next;
                           
                       end
                   end        
                always_ff @(posedge clk)
                    if (actual != proximo) t <= 0;
                    else if (t != tmax) t <= t + 1;

endmodule
