`timescale 1ns / 1ps

//Módulo donde son instanciados los módulos que permiten cargar y descargar los datos al Core FFT 

module FFT #(parameter M = 15, N = 32)(
    input logic clkin,
    input logic save_ok,
    input logic [N - 1:0] dato_in_fft,
    output logic [M - 1:0] dir_in_fft,
    output logic [N - 1:0] dato_out_fft,
    output logic [M - 1:0]  dir_out_fft,
    output logic save_ok_frequency
    
    );

//Modulo LoadFFT
logic data_tvalid;
logic data_tready;
logic [N - 1:0] data_tdata;

logic config_tvalid;
logic config_tready;
logic config_tdata;

//Modulo UnloadFFT
logic m_data_tvalid;
logic m_data_tready;
logic [N - 1:0] m_data_tdata;

//CHANNEL Configuration 
logic s_axis_config_tvalid;
logic s_axis_config_tready;
logic [15:0] s_axis_config_tdata;


xfft_0 FFTcore (
  .aclk(clkin),                                                // input wire aclk
  .s_axis_config_tdata(config_tdata),                  // input wire [15 : 0] s_axis_config_tdata
  .s_axis_config_tvalid(config_tvalid),                // input wire s_axis_config_tvalid
  .s_axis_config_tready(config_tready),                // output wire s_axis_config_tready
  .s_axis_data_tdata(data_tdata),                      // input wire [31 : 0] s_axis_data_tdata
  .s_axis_data_tvalid(data_tvalid),                    // input wire s_axis_data_tvalid
  .s_axis_data_tready(data_tready),                    // output wire s_axis_data_tready
  .s_axis_data_tlast(s_axis_data_tlast),                      // input wire s_axis_data_tlast
  .m_axis_data_tdata(m_data_tdata),                      // output wire [31 : 0] m_axis_data_tdata
  .m_axis_data_tvalid(m_data_tvalid),                    // output wire m_axis_data_tvalid
  .m_axis_data_tready(m_data_tready),                    // input wire m_axis_data_tready
  .m_axis_data_tlast(m_axis_data_tlast),                      // output wire m_axis_data_tlast
  .event_frame_started(event_frame_started),                  // output wire event_frame_started
  .event_tlast_unexpected(event_tlast_unexpected),            // output wire event_tlast_unexpected
  .event_tlast_missing(event_tlast_missing),                  // output wire event_tlast_missing
  .event_status_channel_halt(event_status_channel_halt),      // output wire event_status_channel_halt
  .event_data_in_channel_halt(event_data_in_channel_halt),    // output wire event_data_in_channel_halt
  .event_data_out_channel_halt(event_data_out_channel_halt)  // output wire event_data_out_channel_halt
);

LoadFFT LoadFFT(
    .clk(clkin),
    .save_ok(save_ok),
    .reset(1'b0),
    .dato_time(dato_in_fft),
    .data_tready(data_tready),
    .dir_time(dir_in_fft),
    .data_tvalid(data_tvalid),
    .data_tdata(data_tdata),
    .config_tdata(config_tdata),
    .config_tvalid(config_tvalid),
    .config_tready(config_tready)
    
);

UnloadFFT UnloadFFT(
    .clk(clkin),
    .reset(1'b0),
    .m_tvalid(m_data_tvalid),
    .m_tdata(m_data_tdata),
    .dir_frequency(dir_out_fft),
    .m_tready(m_data_tready),
    .dato_frequency(dato_out_fft),
    .save_ok_frequency(save_ok_frequency)

    );

//ila_0 ILA(
//                 .clk(clkin), // input wire clk
             
//                 .probe0(config_tvalid), // input wire [0:0]  probe0  
//                 .probe1(config_tready), // input wire [0:0]  probe1 
//                 .probe2(config_tdata), // input wire [15:0]  probe2 
//                 .probe3(data_tvalid), // input wire [0:0]  probe3 
//                 .probe4(data_tready), // input wire [0:0]  probe4 
//                 .probe5(data_tdata), // input wire [31:0]  probe5 
//                 .probe6(save_ok), // input wire [0:0]  probe6 
//                 .probe7(m_data_tdata), // input wire [31:0]  probe7 
//                 .probe8(m_data_tvalid), // input wire [0:0]  probe8 
//                 .probe9(m_data_tready) // input wire [0:0]  probe9
//             );
             
//always_ff @(posedge clkin) begin
//s_axis_config_tvalid<=1'b1;
//if (s_axis_config_tready==1'b1)
//s_axis_config_tdata<= 16'b0000010101010101;
//else
//s_axis_config_tdata<= 16'b0000000000000000;
//end


endmodule