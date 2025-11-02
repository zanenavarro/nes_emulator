module vga_top(
    input logic clk,
    input logic rst,
    input logic [11:0] sw,

    output logic h_sync,
    output logic v_sync,
    output logic [11:0] rgb,
    output logic led_rst,
    output logic [11:0] led_sw
);
logic video_on;
vga_controller vga (.clk(clk), .rst(rst), .v_sync(v_sync), .h_sync(h_sync), .video_on(video_on), .h_count(), .v_count());

assign rgb = (video_on) ? sw : '0;

always_ff @(posedge clk, posedge rst) begin
    if (rst)
        led_rst <= 1;
    else 
        led_rst <= '0;
end


always_ff @(posedge clk, posedge rst) begin
    if (rst)
        led_sw <= 0;
    else 
        led_sw <= sw;
end

endmodule