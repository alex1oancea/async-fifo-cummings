module rptr_empty #(parameter ASIZE = 4)
(
    input logic rclk, rrst_n, rinc,
    input logic [ASIZE:0] rq2_wptr,
    output logic [ASIZE:0] rptr,
    output logic rempty,
    output logic [ASIZE-1:0] raddr
);

logic [ASIZE:0] rgray_next, rbin, rbin_next;

always_ff @(posedge rclk, negedge rrst_n) begin
if(~rrst_n) 
    {rbin, rptr} <= 0;
else
    {rbin, rptr} <= {rbin_next, rgray_next};
end

assign raddr = rbin[ASIZE-1:0];

assign rbin_next = rbin + (rinc & ~rempty);
assign rgray_next = (rbin_next>>1) ^ rbin_next;

always_ff @(posedge rclk, negedge rrst_n) begin
if(~rrst_n) rempty <= 1;
else rempty <= (rgray_next == rq2_wptr);
end

endmodule