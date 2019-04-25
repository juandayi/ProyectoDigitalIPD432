`timescale 1ns / 1ps

//Módulo encargado de enviar los datos por el puerto Uart y desempaquetarlos del formato de 32 bits 
//(16 bits datos reales y 16 bits datos imaginarios) para enviar de 8 bits en 8 bits debido a la limitación 
//del puerto Uart

module SendUART#(parameter M = 11, N=32 )(
	input logic clkin,
    input logic reset,
    input logic save_ok,
    input logic tx_busy,
    input logic [N-1:0] dato_uart_out,
    output logic[M-1:0] dir_out_uart,
    output logic tx_start,
    output logic [7:0] tx_data

    );
	
	typedef enum logic [3:0] {IDLE, WAITING, SETDIR, SEND1,WAITING1, SEND2, WAITING2, SEND3, WAITING3, SEND4, WAITING4} state;
	state actual, proximo; 
	
	localparam ADDRA_MAX = 11'd2047; //Maximo addres al que llega RAM
	
            logic [M-1:0] dir_out_uart_next= 5'd0;;
            logic [N-1:0] dato_uart_out_next;
            logic [N-1:0] dato_uart_out_buffer;
            logic tx_start_next;
            logic [7:0] tx_data_next;
			const logic [7:0] T1 = 3; 
            const logic [7:0] tmax = 3;
            logic [7:0] t;
			
			assign dato_uart_out_buffer= dato_uart_out;
            // Maquina de estados
            always_comb  begin
                proximo = actual; // Por defecto
                dir_out_uart_next = dir_out_uart;
                tx_start_next= tx_start;
                tx_data_next= tx_data;
                
				case(actual)
	               IDLE: begin
	                    
                        if (save_ok) begin
                        
                        proximo = WAITING;
                        
                        end
                    end
                    
                    WAITING: begin 
						if (t>=T1-1) begin                                              
							  proximo = SEND1;
						   end
					   else proximo = WAITING;                                   
													   
					   end
					   
                    SETDIR: begin
                       if (dir_out_uart == ADDRA_MAX) 
                            begin 
							 dir_out_uart_next = 5'd0; 
							 proximo = IDLE;
                       end
                       else begin
							  							  
							  dir_out_uart_next = dir_out_uart + 5'd1;     
							  proximo=SEND1;                                       
						end
						end
                    
                    SEND1: begin
//                        
						tx_data_next = dato_uart_out_buffer[7:0]; 
						//Primer byte
                        if (~tx_busy) begin
						   tx_start_next=1'b1;                       
						   proximo = WAITING1;
                        end 
                        else begin  // Espera que uart este disponible para enviar
                             tx_start_next = 1'b0;
                             proximo = SEND1; 
                        end
                        end
                        
                   WAITING1:begin
                           if (tx_busy) begin
                                tx_start_next=1'b1;                                               
                                proximo =  WAITING1;
                                                 
                            end
                            else begin
                                  tx_start_next=1'b0;
                                  proximo = SEND2;
                           end
                           end 
                      
                    SEND2: begin
                        //Segundo byte
                        tx_data_next = dato_uart_out_buffer[15:8];
                        if (~tx_busy) begin
                            tx_start_next=1'b1;
                            
                            proximo = WAITING2;
                        
                      end 
                      else begin  // Espera que uart este disponible para enviar
                            tx_start_next = 1'b0;
                            proximo = SEND2; 
                      end    
                      end
                      
                    WAITING2: begin
                     if (tx_busy) begin
                              tx_start_next=1'b1;
                                                                       
                              proximo =  WAITING2;
                                                                       
                              end
                     else begin
                              tx_start_next=1'b0;
                              proximo = SEND3;
                     end
                     end  
                      
                    SEND3: begin
                       //tercer byte
                            tx_data_next = dato_uart_out_buffer[23:16]; 
                     if (~tx_busy) begin                                            
                                                   
                             tx_start_next=1'b1;
                             proximo = WAITING3;
                     end
                     else begin  // Espera que uart este disponible para enviar
                            tx_start_next = 1'b0;
                            proximo = SEND3; 
                     end    
                     end
                                               
                    
                    
                    WAITING3: begin
                              if (tx_busy) begin
                              tx_start_next=1'b1;
                                                                                           
                               proximo =  WAITING3;
                                                                                           
                                end
                                else begin
                                    tx_start_next=1'b0;
                                    proximo = SEND4;
                                end
                                end  
					
					SEND4: begin					                                                       
                            tx_data_next = dato_uart_out_buffer[31:24]; 
                            if (~tx_busy) begin
                                tx_start_next=1'b1;                                                                   
                                proximo = WAITING4;
					   
					        end
                             else begin  // Espera que uart este disponible para enviar
                                tx_start_next = 1'b0;
                                proximo = SEND4; 
                            end    
                            end
					   
					   
				 WAITING4: begin
                            if (tx_busy) begin
                                tx_start_next=1'b1;
                                                                                             
                                 proximo =  WAITING4;
                                                                                         
                              end
                              else begin
                                 tx_start_next=1'b0;
                                 proximo = SETDIR;
                               end
                               end  	   
//                    end
                    default: proximo = IDLE;
               endcase
            end
            
            always_ff @(posedge clkin) begin
                if(reset) begin
                    dir_out_uart <= 5'd0;
                    tx_start <= 1'b0;
                    actual <= IDLE;
                    tx_data<= 8'b0;
                   
                end
                else begin
                    dir_out_uart <= dir_out_uart_next;
                    tx_start <= tx_start_next;
                    actual <= proximo;
                    tx_data <= tx_data_next;
                    
                end
            end     

			   always_ff @(posedge clkin)
					 if (actual != proximo) t <= 0;
						else if (t != tmax) t <= t + 1;





	

		
endmodule
