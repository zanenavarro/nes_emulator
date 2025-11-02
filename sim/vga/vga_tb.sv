module vga_tb ();

    logic clk;
    logic rst;
    logic h_sync;
    logic v_sync;
    logic [2:0] sw;

    vga_top vga (.clk(clk), .rst(rst), .sw(sw), .h_sync(h_sync), .v_sync(v_sync), .rgb(rgb), .led_rst());



    // Clock generation
    localparam time CLK_PERIOD = 10ns;  // 100 MHz

    initial clk = 0;
    always #(CLK_PERIOD/2) clk = ~clk;

    // Reset generation
    initial begin
        rst = 1;
        #100;        // hold reset low for 100ns
        rst = 0;
        sw = 2;
    end


endmodule