`timescale 1ns / 1ps

//M�dulo encargado de proporcionar o cargar los datos al Core FFT. Siendo el master externo que le 
//proporciona las se�ales necesarias para la comunicaci�n AXI4 Stream con el Core FFT

module LoadFFT #(parameter M=10, N = 32)(
    input logic clk,
    input logic save_ok,
    input logic reset,
    input logic [N-1:0] dato_time,    // muestras en el dominio del tiempo
    input logic data_tready,
    output logic [M-1:0] dir_time,    //direccion muestras en el dominio del tiempo
    output logic data_tvalid,
    output logic [31:0] data_tdata,   //entrada del core fft
    output logic config_tvalid,       //datos de configuracion del core fft
    input logic  config_tready,       //datos de configuracion del core fft
    output logic config_tdata         //datos de configuracion del core fft
    
    );
      typedef enum logic [2:0] {IDLE, CONFIGFFT, WAITFFT, SET, SENDFFT, WAITING} state;
      state actual, proximo; 
            
            
       localparam ADDRA_MAX = 10'd1023; //Maximo address al que llega RAM
                
                
                logic rx_ok_reg = 1'd0;  // Detector cantos
                logic [M:0] dir_time_next = 5'd0;
                logic [N-1:0] data_tdata_next;
                logic data_tvalid_next, config_tvalid_next;
                logic [15:0] config_tdata_next;
                const logic [2:0] T1 = 2; 
                const logic [2:0] tmax = 2;
                logic [7:0] t;
               
                // Maquina de estados
                always_comb  begin
                    proximo = actual; // Por defecto
                    dir_time_next = dir_time;
                    data_tdata_next= data_tdata;
                    data_tvalid_next = 1'b0;
                    config_tvalid_next= 1'b0;
                    config_tdata_next=16'b0000010101010101;

                    case(actual)
                        IDLE: begin                           
                            if (save_ok) begin                            
                            proximo = SET;
                            end
                            else
                            proximo = IDLE;
                            
                             end
                             
//                        CONFIGFFT:begin
//                                config_tvalid_next=1'b1;
//                                if(config_tready) begin
//                                config_tdata_next=16'b0000010101010101;
//                                proximo= WAITFFT;
//                                LED=7'b1100000;
//                                end
//                                else
//                                proximo=CONFIGFFT;
                        
//                                end     
                        
                       SET: begin
//                             dir_time_next = dir_time;                                            
                               if (t>=T1-1) begin                                              
                                  proximo = SENDFFT;
                              end
                              else 
                                  proximo = SET;                                   
                                                     
                              end
                              
                       SENDFFT: begin
                               
                              
                               if(data_tready) begin
                                   data_tvalid_next = 1'b1;
                                   data_tdata_next=dato_time;
                                   proximo = WAITING;
                               end
                               else
                                   proximo =  SENDFFT;
                               end 
                        
                        
                          
                        WAITING: begin
                            data_tvalid_next = 1'b0;
                            if(dir_time==ADDRA_MAX)
                             begin 
                                  dir_time_next = 5'd0; 
                                  proximo = IDLE;
                                  
                             end
                            else begin                                            
                                 dir_time_next = dir_time + 5'd1;  
                                 proximo = SET; 
                                                                    
                            end                                           
                            end
                        default: proximo = IDLE;
                     endcase
                   end     
                                   
                                                           
                      
                       
                
                always_ff @(posedge clk) begin
                    if(reset) begin
                       dir_time <= 5'd0;
                       data_tvalid <= 1'b0;
                       actual <= IDLE;
                       data_tdata <= 1'd0;
                       config_tvalid <= 1'b0;
                       config_tdata <=16'b0;
                       
                    end
                    else begin
                        dir_time <= dir_time_next;
                        data_tvalid <= data_tvalid_next;
                        actual <= proximo;
                        data_tdata <= data_tdata_next;
                        config_tvalid <= config_tvalid_next;
                        config_tdata<= config_tdata_next;
                        
                        
                    end
                end        
                 always_ff @(posedge clk)
                             if (actual != proximo) t <= 0;
                                else if (t != tmax) t <= t + 1;

    
endmodule
