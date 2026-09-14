module fifo #(parameter DSIZE = 8, parameter ASIZE =4)
(
    input logic [DSIZE-1:0] wdata,
    input logic winc, wclk, wrst_n,
    input logic rinc, rclk, rrst_n,
    output logic [DSIZE-1:0] rdata,
    output logic rempty, wfull
);

logic [ASIZE:0] rptr, wptr, rq2_wptr, wq2_rptr;
logic [ASIZE-1:0] raddr, waddr;

fifomem #(DSIZE, ASIZE) FifoMem
(
    .wclk(wclk), .wclken(winc), .wfull(wfull),
    .wdata(wdata),
    .waddr(waddr), .raddr(raddr),
    .rdata(rdata)
);

sync_w2r #(ASIZE) Sync_w2r
(
    .rclk(rclk), .rrst_n(rrst_n),
    .wptr(wptr),
    .rq2_wptr(rq2_wptr)
);

sync_r2w #(ASIZE) Sync_r2w
(
    .wclk(wclk), .wrst_n(wrst_n),
    .rptr(rptr),
    .wq2_rptr(wq2_rptr)
);

rptr_empty #(ASIZE) Rptr_empty
(
    .rclk(rclk), .rrst_n(rrst_n), .rinc(rinc),
    .rq2_wptr(rq2_wptr),
    .rptr(rptr),
    .rempty(rempty),
    .raddr(raddr)
);

wptr_full #(ASIZE) Wptr_full
(
    .wclk(wclk), .wrst_n(wrst_n), .winc(winc),
    .wq2_rptr(wq2_rptr),
    .wptr(wptr),
    .wfull(wfull),
    .waddr(waddr)
);
    
    
endmodule
