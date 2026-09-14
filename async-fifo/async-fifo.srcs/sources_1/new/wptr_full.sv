module wptr_full #(parameter ASIZE = 4)
(
    input logic wclk, wrst_n, winc,
    input logic [ASIZE:0] wq2_rptr,
    output logic [ASIZE:0] wptr,
    output logic wfull,
    output logic [ASIZE-1:0] waddr
);

logic [ASIZE:0] wgray_next, wbin, wbin_next;

always_ff @(posedge wclk, negedge wrst_n) begin
if(~wrst_n) 
    {wbin, wptr} <= 0;
else
    {wbin, wptr} <= {wbin_next, wgray_next};
end

assign waddr = wbin[ASIZE-1:0];

assign wbin_next = wbin + (winc & ~wfull);
assign wgray_next = (wbin_next>>1) ^ wbin_next;

always_ff @(posedge wclk, negedge wrst_n) begin
    if(~wrst_n) 
        wfull <= 0;
    else 
        wfull <= ((wgray_next[ASIZE] != wq2_rptr[ASIZE]) && 
        (wgray_next[ASIZE-1] != wq2_rptr[ASIZE-1]) &&
        (wgray_next[ASIZE-2:0] == wq2_rptr[ASIZE-2:0]));
end

endmodule