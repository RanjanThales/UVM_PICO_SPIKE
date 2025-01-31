interface axi_intf#(
  parameter AXI_TEST = 0,
  parameter VERBOSE = 0
) (input clk);
        logic       reset ;
	logic        mem_axi_awvalid;
	logic        mem_axi_awready;
	logic [31:0] mem_axi_awaddr;
	logic [ 2:0] mem_axi_awprot;
	logic        mem_axi_wvalid;
	logic        mem_axi_wready;
	logic [31:0] mem_axi_wdata;
	logic [ 3:0] mem_axi_wstrb;
	logic        mem_axi_bvalid;
	logic        mem_axi_bready;
	logic        mem_axi_arvalid;
	logic        mem_axi_arready;
	logic [31:0] mem_axi_araddr;
	logic [ 2:0] mem_axi_arprot;
	logic        mem_axi_rvalid;
	logic        mem_axi_rready;
	logic [31:0] mem_axi_rdata;
	logic        tests_passed ;
  
endinterface : axi_intf
