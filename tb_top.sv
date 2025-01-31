//`include "tb_pkg.sv"
//`include "axi_intf.sv"
//`include "base_test_pkg.sv"

module tb_top;

		
	    import uvm_pkg::*;
	    axi_intf    axi_vif () ;
            rvfi_intf    rvfi_if () ;
      	parameter VERBOSE = 0;
	parameter AXI_TEST = 0;
	
	logic clk ;
	logic rstn ;
	logic trap;
	logic trace_valid;
	logic [35:0] trace_data ;
        logic trace_file ;
	int axi_test , verbose ;
	logic [63:0] xorshift64_state = 64'd88172645463325252;
     //  logic [31:0] rvfi_testing;

	
	picorv32_wrapper   dut_i 
                (
                   .clk ( clk   ),
                   .resetn( rstn  ),
		   .trap( trap  ),
		   .trace_valid( trace_valid),
		   .trace_data( trace_data)
                 //.rvfi_pc_rdata(rvfi_testing)

                );
				  
				  
	assign axi_vif.mem_axi_awvalid = dut_i.mem_axi_awvalid  ;
	assign dut_i.mem_axi_awready = 	axi_vif.mem_axi_awready ;
	assign  axi_vif.mem_axi_awaddr = dut_i.mem_axi_awaddr  ;
	assign   axi_vif.mem_axi_awprot = dut_i.mem_axi_awprot  ;
	assign   axi_vif.mem_axi_wvalid = dut_i.mem_axi_wvalid  ;
	assign dut_i.mem_axi_wready =   axi_vif.mem_axi_wready ;
	assign   axi_vif.mem_axi_wdata = dut_i.mem_axi_wdata  ;
	assign   axi_vif.mem_axi_wstrb = dut_i.mem_axi_wstrb  ;
	assign dut_i.mem_axi_bvalid =   axi_vif.mem_axi_bvalid ;
	assign axi_vif.mem_axi_bready = dut_i.mem_axi_bready  ;
	assign axi_vif.mem_axi_arvalid =  dut_i.mem_axi_arvalid ;
	assign dut_i.mem_axi_arready =   axi_vif.mem_axi_arready ;
	assign   axi_vif.mem_axi_araddr = dut_i.mem_axi_araddr  ;
	assign axi_vif.mem_axi_arprot =  dut_i.mem_axi_arprot  ;
	assign dut_i.mem_axi_rvalid =   axi_vif.mem_axi_rvalid ;
	assign axi_vif.mem_axi_rready =  dut_i.mem_axi_rready  ;
	assign dut_i.mem_axi_rdata =   axi_vif.mem_axi_rdata ;
	assign dut_i.tests_passed =   axi_vif.tests_passed ;
	
        //rvfi intf connections
  assign rvfi_if.valid                = dut_i.rvfi_valid;
  assign rvfi_if.order                = dut_i.rvfi_order;
  assign rvfi_if.insn                 = dut_i.rvfi_insn;
  assign rvfi_if.trap                 = dut_i.rvfi_trap;
  assign rvfi_if.intr                 = dut_i.rvfi_intr;
  assign rvfi_if.halt                 = dut_i.rvfi_halt;
  assign rvfi_if.rs1_addr             = dut_i.rvfi_rs1_addr;
  assign rvfi_if.rs2_addr             = dut_i.rvfi_rs2_addr;
  assign rvfi_if.rs1_rdata            = dut_i.rvfi_rs1_rdata;
  assign rvfi_if.rs2_rdata            = dut_i.rvfi_rs2_rdata;
  assign rvfi_if.rd_addr              = dut_i.rvfi_rd_addr;
  assign rvfi_if.rd_wdata             = dut_i.rvfi_rd_wdata;
  assign rvfi_if.pc_rdata             = dut_i.rvfi_pc_rdata;
  assign rvfi_if.pc_wdata             = dut_i.rvfi_pc_wdata;
  assign rvfi_if.mem_addr             = dut_i.rvfi_mem_addr;
  assign rvfi_if.mem_rmask            = dut_i.rvfi_mem_rmask;
  assign rvfi_if.mem_wmask            = dut_i.rvfi_mem_wmask;  
  assign rvfi_if.mem_rdata            = dut_i.rvfi_mem_rdata;
  assign rvfi_if.mem_wdata            = dut_i.rvfi_mem_wdata;


	assign axi_vif.clk = clk ;
        assign axi_vif.reset = rstn ;
        assign rvfi_if.clk = clk ;
        assign rvfi_if.reset = rstn ;
	always begin
		#5 clk = ~clk; // clk period =10ns
	end

	initial begin
		if ($test$plusargs("verbose"))
			verbose = 1;
		else
			verbose = 0;
	end
	initial begin
		if ($test$plusargs("axi_test"))
			axi_test = 1;
		else
			axi_test = 0;
	end 
	
	/*reg verbose;
	initial verbose = $test$plusargs("verbose") || VERBOSE;

	reg axi_test;
	initial axi_test = $test$plusargs("axi_test") || AXI_TEST;*/

	initial begin
	axi_vif.mem_axi_awready = 0;
	axi_vif.mem_axi_wready = 0;
	axi_vif.mem_axi_bvalid = 0;
	axi_vif.mem_axi_arready = 0;
	axi_vif.mem_axi_rvalid = 0;
	axi_vif.tests_passed = 0;
	end

	initial begin
		clk = 1;
		rstn = 0;
		#100;
		rstn =1;
	end
    
        initial begin
	//	if ($test$plusargs("vcd")) begin
	//		$dumpfile("tb_top.vpd");
	//		$dumpvars(0, tb_top);
         $vcdpluson;
	//	end
		repeat (10000000000) @(posedge clk);
		$display("TIMEOUT");
	//	$finish;
	end

	initial begin
		if ($test$plusargs("trace")) begin
			trace_file = $fopen("tb_top.trace", "w");
			repeat (10) @(posedge clk);
			while (!trap) begin
				@(posedge clk);
				if (trace_valid)
					$fwrite(trace_file, "%x\n", trace_data);
			end
			$fclose(trace_file);
			$display("Finished writing tb_top.trace.");
		end
	end
        
       	initial begin
        
	         uvm_config_db #(virtual axi_intf) :: set(null, "*", "vif", axi_vif);
                uvm_config_db #(virtual rvfi_intf) :: set(null, "*", "if", rvfi_if);
                
          
		uvm_config_db #(int) :: set(null, "*", "axitest", axi_test);
		uvm_config_db #(int) :: set(null, "*", "verb", verbose);		
	
        run_test("base_test");	
		  
	end
 
endmodule

