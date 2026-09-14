module fifomem #( parameter DSIZE = 8, ASIZE = 4)
(
    input logic wclk, wclken, wfull,
    input logic [DSIZE-1:0] wdata,
    input logic [ASIZE-1:0] waddr, raddr,
    output logic [DSIZE-1:0] rdata
);

localparam DEPTH = 1<<ASIZE;
logic [DSIZE-1:0] mem [0:DEPTH-1];

assign rdata = mem[raddr];

always_ff @(posedge wclk)
if(wclken && !wfull)
    mem[waddr] <= wdata;

endmodule