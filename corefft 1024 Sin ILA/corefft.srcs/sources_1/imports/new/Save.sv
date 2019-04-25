`timescale 1ns / 1ps

//Modulo encargado de recibir los datos enviados por la Uart y empaquetarlos en formato de 32
//bits (16 bits datos reales y 16 bits datos imaginarios).


//N numero de datos por muestra recibidos por la UART
module Save #(parameter M=10, N = 32)(
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
        
        
        localparam ADDRA_MAX = 10'd1023; //Maximo addres al que llega RAM
            
            
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
							in_uart_next[15:8] = rx_data; //Primer paquete
							proximo = SAVE1;
						
                        end
                        end
						
                    SAVE1: begin                                                         
                        if (rx_ready & ~rx_ok_reg) begin 
							in_uart_next[7:0] = rx_data; //Segundo paquete
							proximo = SAVE2;
                        end
                        else
							proximo = SAVE1;	
                        end
                    
                   
                                        
                    SAVE2: begin
                                            
                        if (rx_ready & ~rx_ok_reg) begin 
                            in_uart_next[31:24] = rx_data;
                            proximo = SAVE3;
                        
                        end
                        else
                            proximo = SAVE2;
                        end
                    
                     
                      
                    SAVE3: begin//                        
                        if (rx_ready & ~rx_ok_reg) begin 
							in_uart_next[23:16] = rx_data;
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
			
			
    //        logic rst=0;
//            logic [1:0] flag1, flag2; //flag1: Indicador contador1 flag2: Indicador contador2
//            logic [2:0] Count1=0; //  Contador cantidad de bytes en una posicion de memoria
//            logic [4:0] Count2=0; // Contador de posiciones de memoria, puntos fft
//            logic [7:0] temp1,temp2, temp3, temp4, rxdata;
//            logic sel;
//            logic [31:0] dato;
//            const logic [7:0] T1 = 3; 
//            const logic [7:0] tmax = 3;
//            logic [7:0] t;
//    //        logic unsigned [IW-1:0] in_uart [N - 1:0];
//           assign rxdata=rx_data;
                     
//        always_ff @(posedge clkin)
//                   if (reset) begin 
//                       actual <= IDLE;
//                   end
//                   else begin
//                       actual <= proximo;
//                   end
//        always_ff @(posedge clkin)
//                  if (actual != proximo) t <= 0;
//                else if (t != tmax) t <= t + 1;    
                           
//         always_ff @(posedge clkin)
//             if (flag1==1) Count1 <= Count1 + 1;  // 1 INCREMENTA
//             else if(flag1==0) Count1<=Count1;    // 0 MANTIENE
//             else Count1<=0;                   // 2 ENCERA
       
//        always_ff @(posedge clkin)
//                         if (flag2==1) Count2 <= Count2 + 1;  // 1 INCREMENTA
//                         else if(flag2==0) Count2<=Count2;    // 0 MANTIENE
//                         else Count2<=0;                   // 2 ENCERA
       
       
                    
//         always_comb begin
//             ENA=1'b0;
//             WEA=1'b0;
//             case (actual) 
//              IDLE: begin
//                     flag1=2;
//                     flag2=0;
//                     in_uart=32'b0;
////                     dato=32'b0; 
//                     save_finish=0;
//                     dir_in_uart=0;
//                    if (rx_ready)
//                        proximo= SAVE1;
//                    else proximo = IDLE;
//                     end
                
                               
//               SAVE1: begin
//                     flag1=1;
//                     flag2=0; 
//                     save_finish=0;
//                     in_uart[7:0]=rxdata;
////                     dato[7:0]=rxdata;
//                     LED=7'b0000001;
//                     dir_in_uart=Count2;
//                     if (rx_ready)
//                     begin
//                         proximo = SAVE2;
                         
//                     end
//                     else proximo = SAVE1;
//                     end
                
                
//                 SAVE2: begin
//                       flag1=1;
//                       flag2=0; 
//                       save_finish=0;
//                       in_uart[15:8]=rxdata;
////                       dato[15:8]=rxdata;
//                       LED=7'b0000011;
//                       dir_in_uart=Count2;
//                         if (rx_ready)
//                           begin
//                          proximo = SAVE3;
                          
//                             end
//                         else proximo = SAVE2;
//                         end
                
                
                
//                 SAVE3: begin
//                       flag1=1;
//                       flag2=0; 
//                       save_finish=0;
//                       in_uart[23:16]=rxdata;
////                       dato[23:16]=rxdata;
//                       dir_in_uart=Count2;
//                       LED=7'b0000111;
//                       if (rx_ready)
//                              begin
//                           proximo = SAVE4;
                           
//                              end
//                       else proximo = SAVE3;
//                       end
                
                
//                SAVE4: begin
//                     flag1=1;
//                     flag2=0; 
//                     save_finish=0;
//                     in_uart[31:24]=rxdata;
//                     LED=7'b0001111;
////                     dato[31:24]=rxdata;
//                     dir_in_uart=Count2;
//                     if(Count1==4)
//                     proximo = WRITE;
//                     else
//                     proximo= SAVE4;
//                     end
                     
//               WRITE: begin                    
//                flag1=2;
//                flag2=0;
//                dir_in_uart=Count2;
////                dato[31:24]=rxdata;
////                in_uart=dato;
//                ENA=1'b1;
//                WEA=1'b1;
//              if( Count2<=5'd2) begin
//                        flag2=1;
//                        save_finish=0;
//                        proximo=IDLE;
//                        end
//                else begin
//                        flag2=2;
//                        save_finish=1;
//                        proximo=IDLE;
//                        end
//                end
                
                
//                 FINISH: begin
//                  flag1=2;
                          
//                  save_finish=0; 
//                  if(Count2<N) begin
//                  LED=7'b0111111;
//                  array_in_uart[Count2]=32'b0;
//                  flag2=1;
//                  proximo = IDLE;
//                  end
//                  else begin
//                  flag2=2;
//                  save_finish=1; 
//                  LED=7'b1111111;
//                  proximo = IDLE;
//                  end
//                 end
                
                
//                 default: begin
//                     flag1=2;
//                     flag2=2; 
//                     in_uart=32'b0;
//                     dir_in_uart=0;
//                     dato=32'b0;
//                     save_finish=0;
//                     proximo=IDLE;
//                 end
//             endcase
//         end

    
     
                               
//        logic [7:0] Byte1, Byte2, Byte3, Byte4;
//        logic [M:0] count_dir=6'd0;
//        logic [2:0] count_byte=3'd0;
            
//        always_ff @(posedge clkin) begin 
//             save_finish<=1'd0;
//             if (rx_ready) begin
//                count_byte <= count_byte +3'd1;
                
//                case (count_byte)
////                    3'd0: begin count_byte <= count_byte +3'd1; LED<=7'b1000000; end
//                    3'd0: begin Byte1<=rx_data; LED<=7'b0000001; end
//                    3'd1: begin Byte2<=rx_data; LED<=7'b0000011; end
//                    3'd2: begin Byte3<=rx_data; LED<=7'b0000111; end
//                    3'd3: begin 
//                        Byte4<=rx_data; 
//                        count_byte<=0; 
//                        LED=7'b0001111;
//                                if (count_dir<6'd2) begin   //6'd31
//                                    dir_in_uart<=count_dir;
//                                    count_dir<=count_dir+6'd1;
//                                    LED<=7'b1000000;
////                                    in_uart<={Byte1,Byte2,Byte3,Byte4};
//                                  end
//                                  else begin;
//                                      dir_in_uart<=count_dir;
//                                      count_dir<=6'd0;
//                                      save_finish<=1'd1;
//                                      LED<=7'b1100000;
//                                  end   
//                            end
//                    default: begin
//                        Byte1<=0;
//                        Byte2<=0;
//                        Byte3<=0;
//                        Byte4<=0;
//                        save_finish<=1'd0;
//                        LED<=7'b0011111;
//                    end
//                endcase 
//             end 
             
             
//        end
              
//        assign in_uart={Byte4,Byte3,Byte2,Byte1};  
                    
            
            
            
		
			
			   
	
			        
			
             		
           
endmodule
