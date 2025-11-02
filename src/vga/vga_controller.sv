module vga_controller (
    input logic clk,
    input logic rst,

    output logic v_sync,
    output logic h_sync,

    output logic [9:0] h_count,
    output logic [9:0] v_count,
    output logic pulse_25MHZ,

    output logic video_on
);

localparam HD = 512; // horizontal display area
localparam HF = 112;  // h. front (left) border
localparam HB = 80;  // h. back (right border) 
localparam HR = 96;   // h. retrace

localparam VD = 480; // vertical display area
localparam VF = 24;  // v. front (top) border
localparam VB = 24;  // v. back (bottom) border
localparam VR = 2;   // v. retrace


logic h_sync_next;
logic v_sync_next;

assign h_sync_next = (h_count >= (HD+HB) && h_count <= (HD+HB+HR-1));
assign v_sync_next = (v_count >= (VD+VB) && v_count <= (VD+VB+VR-1));


logic [1:0] pulse_cnt;
logic pulse_25MHZ;

always_ff @(posedge clk, posedge rst) begin
    if (rst) pulse_cnt <= 1;
    else     pulse_cnt <= pulse_cnt + 1;
end
assign pulse_25MHZ = (pulse_cnt == 0);



always_ff @(posedge clk, posedge rst) begin
    if (rst) begin
        h_count <= 0;
        v_count <= 0;
        h_sync <= '0;
        v_sync <= '0;
    end else begin
        h_count <= h_count_next;
        v_count <= v_count_next;
        h_sync <= h_sync_next;
        v_sync <= v_sync_next;
    end
end


logic h_end;
// logic [9:0] h_count;
logic [9:0] h_count_next;

assign h_end = (h_count == (HD + HF + HB + HR - 1));

// logic for horizontal counter
always_comb begin
    if (pulse_25MHZ) begin
        if (h_end)
            h_count_next = '0;
        else
            h_count_next = h_count + 1;
    end else begin
        h_count_next = h_count;
    end
end


logic v_end;
logic [9:0] v_count_next;

assign v_end = (v_count == (VD + VF + VB + VR - 1));

// logic for vorizontal counter
always_comb begin
    if (pulse_25MHZ & h_end) begin
        if (v_end)
            v_count_next = '0;
        else
            v_count_next = v_count + 1;
    end else begin 
        v_count_next = v_count;
    end
end

assign video_on = (h_count < HD) && (v_count < VD);


endmodule






