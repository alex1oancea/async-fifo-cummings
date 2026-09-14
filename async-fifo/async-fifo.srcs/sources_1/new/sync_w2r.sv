module sync_w2r #(parameter ASIZE = 4)
(
    input logic rclk, rrst_n,
    input logic [ASIZE:0] wptr,
    output logic [ASIZE:0] rq2_wptr
);

logic [ASIZE:0] rq1_wptr;

always_ff @(posedge rclk, negedge rrst_n) begin
    if (!rrst_n) {rq2_wptr, rq1_wptr} <= 0;
    else
        {rq2_wptr, rq1_wptr} <= {rq1_wptr, wptr};
end

endmodule