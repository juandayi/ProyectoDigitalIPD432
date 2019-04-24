`timescale 1ns / 1ps
module SendUART#(parameter M = 10, N=32 )(
	input logic clkin,
    input logic reset,
    input logic save_ok,
    input logic tx_busy,
    input logic [N-1:0] dato_uart_out,
    output logic[M-1:0] dir_out_uart,
    output logic tx_start,
    output logic [7:0] tx_data
//    output  logic [6:0] LED
    );
	
	typedef enum logic [3:0] {IDLE, WAITING, SETDIR, SEND1,WAITING1, SEND2, WAITING2, SEND3, WAITING3, SEND4, WAITING4} state;
	state actual, proximo; 
	
	localparam ADDRA_MAX = 10'd1023; //Maximo addres al que llega RAM
	
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







	// logic [1:0] flag1, flag2; //flag1: Indicador contador1 flag2: Indicador contador2
     // logic [2:0] Count_byte=0; //  Contador cantidad de datos en una posicion de memoria
     // logic [4:0] Count_dir=0; // Contador de posiciones de memoria, puntos fft
	 
	 // const logic [7:0] T1 = 3; 
     // const logic [7:0] tmax = 3;
     // logic [7:0] t;
	// logic rst=0;
	// logic [1:0] inc, st;
	// integer Count=0;
	// logic [7:0] txdata;
	// logic [31:0] dato_frec;
	// assign tx_data=txdata;
				
	// always_ff @(posedge clkin)
		// if (reset) begin 
			// actual <= IDLE;
		// end
		// else begin
			// actual <= proximo;
		// end
	// always_ff @(posedge clkin)
            // if (actual != proximo) t <= 0;
               // else if (t != tmax) t <= t + 1;	
		
		
	// always_ff @(posedge clkin)
		// if (flag1==1) Count_byte <= Count_byte + 1;  // 1 INCREMENTA
		// else if(flag1==0) Count_byte<=Count_byte;    // 0 MANTIENE
		// else Count_byte<=0;                   // 2 ENCERA
	
	// always_ff @(posedge clkin)
           // if (flag2==1) Count_dir <= Count_dir + 1;  // 1 INCREMENTA
              // else if(flag2==0) Count_dir <=Count_dir;    // 0 MANTIENE
                // else Count_dir<=0;                   // 2 ENCERA
               			
	// always_comb begin
		// case (actual) 
			// IDLE: begin
                        // flag1=2;
                        // flag2=2;
                        // txdata=0;
                        // tx_start =0;
                        // dato_frec=0;
                        // dir_out_uart=0;
                        // LED=7'b0000001;
                        // if (save_ok) 
                        // proximo = SETDIR;
				        // else proximo = IDLE;
                 // end
            // SETDIR: begin
                     // flag1=2;
                     // flag2=0;
                     // txdata=0;
                     // tx_start=0;
                     // dato_frec=0;
                     // dir_out_uart=Count_dir;
                     // LED=7'b1000000;
                     // if (t>=T1-1) begin 
                     // dato_frec=dato_uart_out;
                     // proximo = SEND1;
                     // end
                     // else proximo = SETDIR;
                       
                 // end    
			// SEND1: begin
				// flag1=1;
                // flag2=0;
                // dato_frec=dato_uart_out;
               
				// txdata = dato_frec[7:0];
				// tx_start =1;
				// dir_out_uart=Count_dir;
				// LED=7'b0000001;
				// proximo=SEND2;
			// end

			// SEND2: begin
				// flag1=1;
                // flag2=0;
                // dir_out_uart=Count_dir;
                // dato_frec=dato_uart_out;
                // LED=7'b0000011;
                     // if (tx_busy) begin
                     // tx_start =0;
                     // txdata =0;
                      // proximo=SEND2;
                     // end
                        // else begin    
                        // txdata = dato_frec[15:8];
                        // tx_start =1;
                        // proximo=SEND3;
                      // end
			   // end
			 
			// SEND3: begin
                      // flag1=1;
                      // flag2=0;
                      // dir_out_uart=Count_dir;
                      // dato_frec=dato_uart_out;
                      // LED=7'b0000111;                    
                      // if (tx_busy)  begin
                             // tx_start =0;
                             // txdata =0;
                             // proximo=SEND3;
                             // end
                         // else begin  
                         // tx_start=1;
                         // txdata = dato_frec[23:16];  
                         // proximo=SEND4;
                           // end
                           // end
			// SEND4: begin
				 // flag1=1;
                 // flag2=0;
                 // dir_out_uart=Count_dir;
                 // dato_frec=dato_uart_out;
                 // LED=7'b0001111;   
             // if (tx_busy)
                 // begin
                  // tx_start =0;
                  // txdata =0;
                  // proximo=SEND4;
                  // end 
             // else begin 
                 // txdata = dato_frec[31:24];
                 // tx_start =1;   
                 // proximo=FINISH;
             // end
                 // end
			
			// FINISH: begin
				// flag1=2;
                // dir_out_uart=Count_dir;
                // tx_start =0;
                // txdata=8'b0;
                // flag2=0; 
               // if (tx_busy) begin
                  // flag2=0; 
                  // proximo=FINISH;
                 // if(Count_dir<=5'd2) begin //N
                        // flag2=1;                            
                        // proximo = SETDIR;
                        // end
                  // else begin
                        // flag2=2;
                        // LED=7'b1111111;
                        // proximo = IDLE;
                        // end
               // end
               // end                
 

			
			// default: begin
				// flag1=2;
                // flag2=2;
                // tx_start =0;
                // txdata=8'b0;
                // dir_out_uart=0;
				// proximo=IDLE;
			// end
		// endcase
    // end

		
endmodule
