//import tb_pkg::*;
 
//`include "axi_mem_model.sv"


class axi_driver extends uvm_driver ;

    	virtual axi_intf     axi_vif;
	axi_mem_model        axi_mem;
        
        //logic [31:0]   memory [0:128*1024/4-1];
        logic [31:0]   memory [0:512*1024/4-1];
      //  rvfi_agent  agt ;
        event load_e ;
    
       int verbose, axi_test ;

        logic [2:0] fast_axi_transaction = ~0;
	logic [4:0] async_axi_transaction = ~0;
	logic [4:0] delay_axi_transaction = 0;
	logic latched_raddr_en = 0;
	logic latched_waddr_en = 0;
	logic latched_wdata_en = 0;

	logic fast_raddr = 0;
	logic fast_waddr = 0;
	logic fast_wdata = 0;

	logic [31:0] latched_raddr;
	logic [31:0] latched_waddr;
	logic [31:0] latched_wdata;
	logic [ 3:0] latched_wstrb;
	logic        latched_rinsn;
	logic [63:0] xorshift64_state = 64'd88172645463325252;
        

    `uvm_component_utils(axi_driver)

    function new(string name , uvm_component parent );
        super.new(name , parent );
    endfunction

 function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  
    if (!uvm_config_db#(virtual axi_intf)::get(this, "", "vif", axi_vif)) begin
      `uvm_fatal(get_full_name(), "Cannot get axi_vif")
    end 
 if (!uvm_config_db#(int)::get(this, "", "verb", verbose)) begin
      `uvm_fatal(get_full_name(), "Cannot get verbose")
    end 
//	axi_mem=axi_mem_model::type_id::create("axi_mem");
   if (!uvm_config_db#(axi_mem_model)::get(this, "", "memory", axi_mem)) begin
      `uvm_fatal(get_full_name(), "Cannot get memory")
    end 
endfunction

virtual task run_phase (uvm_phase phase );
wait(load_e.triggered);
//@(load_e);
 this.memory = axi_mem.memory ;
`uvm_info(get_full_name(), $sformatf("AFTER EVENT "), UVM_LOW)
   	for (int i = 0; i < (512*1024/4); i++) begin
         `uvm_info("Memory_Printing", $sformatf("memory[%0d] = %h", i, memory[i]), UVM_LOW);
        end 
 `uvm_info(get_full_name(), $sformatf("BEFORE DRIVE "), UVM_LOW)

    drive ();

endtask

virtual protected task drive ();
    fork
         forever begin
         `uvm_info(get_full_name(), $sformatf("inside forever"), UVM_HIGH)

             @(posedge axi_vif.clk) begin
                 `uvm_info(get_full_name(), $sformatf("inside clk"), UVM_HIGH)

		if (axi_test) begin
				xorshift64_next;
				{fast_axi_transaction, async_axi_transaction, delay_axi_transaction} <= xorshift64_state;
		end
             end
        end

        forever begin
             @(negedge axi_vif.clk) begin
                 `uvm_info(get_full_name(), $sformatf("inside 2nd forever"), UVM_HIGH)
 
		if (axi_vif.mem_axi_arvalid && !(latched_raddr_en || fast_raddr) && async_axi_transaction[0]) handle_axi_arvalid;
		if (axi_vif.mem_axi_awvalid && !(latched_waddr_en || fast_waddr) && async_axi_transaction[1]) handle_axi_awvalid;
		if (axi_vif.mem_axi_wvalid  && !(latched_wdata_en || fast_wdata) && async_axi_transaction[2]) handle_axi_wvalid;
		if (!axi_vif.mem_axi_rvalid && latched_raddr_en && async_axi_transaction[3]) handle_axi_rvalid;
		if (!axi_vif.mem_axi_bvalid && latched_waddr_en && latched_wdata_en && async_axi_transaction[4]) handle_axi_bvalid;
        	end
        end
        forever begin
	      @(posedge axi_vif.clk) begin
                axi_vif.mem_axi_arready <= 0;
		axi_vif.mem_axi_awready <= 0;
		axi_vif.mem_axi_wready <= 0;

		fast_raddr <= 0;
		fast_waddr <= 0;
		fast_wdata <= 0;

                 `uvm_info(get_full_name(), $sformatf("inside 3rd forever"), UVM_HIGH)
            
		if (axi_vif.mem_axi_rvalid && axi_vif.mem_axi_rready) begin
			axi_vif.mem_axi_rvalid <= 0;
		end

		if (axi_vif.mem_axi_bvalid && axi_vif.mem_axi_bready) begin
			axi_vif.mem_axi_bvalid <= 0;
		end

		if (axi_vif.mem_axi_arvalid && axi_vif.mem_axi_arready && !fast_raddr) begin
			latched_raddr = axi_vif.mem_axi_araddr;
			latched_rinsn = axi_vif.mem_axi_arprot[2];
			latched_raddr_en = 1;
		end

		if (axi_vif.mem_axi_awvalid && axi_vif.mem_axi_awready && !fast_waddr) begin
			latched_waddr = axi_vif.mem_axi_awaddr;
			latched_waddr_en = 1;
 		end

		if (axi_vif.mem_axi_wvalid && axi_vif.mem_axi_wready && !fast_wdata) begin
			latched_wdata = axi_vif.mem_axi_wdata;
			latched_wstrb = axi_vif.mem_axi_wstrb;
			latched_wdata_en = 1;
		end

		if (axi_vif.mem_axi_arvalid && !(latched_raddr_en || fast_raddr) && !delay_axi_transaction[0]) handle_axi_arvalid;
		if (axi_vif.mem_axi_awvalid && !(latched_waddr_en || fast_waddr) && !delay_axi_transaction[1]) handle_axi_awvalid;
		if (axi_vif.mem_axi_wvalid  && !(latched_wdata_en || fast_wdata) && !delay_axi_transaction[2]) handle_axi_wvalid;

		if (!axi_vif.mem_axi_rvalid && latched_raddr_en && !delay_axi_transaction[3]) handle_axi_rvalid;
		if (!axi_vif.mem_axi_bvalid && latched_waddr_en && latched_wdata_en && !delay_axi_transaction[4]) handle_axi_bvalid;
	 end
        end
    join
`uvm_info(get_full_name(),$sformatf(" time : %0t", $time), UVM_LOW)
endtask

        
        	task xorshift64_next;
		begin
			// see page 4 of Marsaglia, George (July 2003). "Xorshift RNGs". Journal of Statistical Software 8 (14).
			xorshift64_state = xorshift64_state ^ (xorshift64_state << 13);
			xorshift64_state = xorshift64_state ^ (xorshift64_state >>  7);
			xorshift64_state = xorshift64_state ^ (xorshift64_state << 17);
		end
	        endtask


	task handle_axi_arvalid; begin
		axi_vif.mem_axi_arready <= 1;
		latched_raddr = axi_vif.mem_axi_araddr;
		latched_rinsn = axi_vif.mem_axi_arprot[2];
		latched_raddr_en = 1;
		fast_raddr <= 1;
	end endtask 

	task handle_axi_awvalid; begin
		axi_vif.mem_axi_awready <= 1;
		latched_waddr = axi_vif.mem_axi_awaddr;
		latched_waddr_en = 1;
		fast_waddr <= 1;
	end endtask

	task handle_axi_wvalid; begin
		axi_vif.mem_axi_wready <= 1;
		latched_wdata = axi_vif.mem_axi_wdata;
		latched_wstrb = axi_vif.mem_axi_wstrb;
		latched_wdata_en = 1;
		fast_wdata <= 1;
	end endtask

	task handle_axi_rvalid; begin
        int x;
         $display (" inside rvalid ") ;
		if (verbose)
			//$display("ranjan: ADDR=%08x memory[]=%08x%s", latched_raddr, memory[latched_raddr]);
			$display("RD: ADDR=%08x DATA=%08x%s", latched_raddr, memory[latched_raddr >> 2], latched_rinsn ? " INSN" : "");
	if (latched_raddr < 512*1024) begin
        axi_vif.mem_axi_rdata <= memory[65536 + (latched_raddr[15:0] >> 2)];
			//axi_vif.mem_axi_rdata <= memory[latched_raddr];
			axi_vif.mem_axi_rvalid <= 1;
			latched_raddr_en = 0;
		end else begin
			$display("OUT-OF-BOUNDS MEMORY READ FROM %08x", latched_raddr);
		//	$finish;
		end
	end endtask 

	task handle_axi_bvalid; begin
           $display (" inside bvalid ") ;
		if (verbose)
			$display("WR: ADDR=%08x DATA=%08x STRB=%04b", latched_waddr, latched_wdata, latched_wstrb);
		if (latched_waddr < 128*1024) begin
			if (latched_wstrb[0]) memory[latched_waddr >> 2][ 7: 0] <= latched_wdata[ 7: 0];
			if (latched_wstrb[1]) memory[latched_waddr >> 2][15: 8] <= latched_wdata[15: 8];
			if (latched_wstrb[2]) memory[latched_waddr >> 2][23:16] <= latched_wdata[23:16];
			if (latched_wstrb[3]) memory[latched_waddr >> 2][31:24] <= latched_wdata[31:24];
		end else
		if (latched_waddr == 32'h1000_0000) begin
			if (verbose) begin
				if (32 <= latched_wdata && latched_wdata < 128)
					$display("OUT: '%c'", latched_wdata[7:0]);
				else
					$display("OUT: %3d", latched_wdata);
			end else begin
				$write("%c", latched_wdata[7:0]);
`ifndef VERILATOR
				$fflush();
`endif
			end
		end else
		if (latched_waddr == 32'h2000_0000) begin
			if (latched_wdata == 123456789)
				axi_vif.tests_passed = 1;
		end else begin
			$display("OUT-OF-BOUNDS MEMORY WRITE TO %08x", latched_waddr);
		//	$finish;
		end
		axi_vif.mem_axi_bvalid <= 1;
		latched_waddr_en = 0;
		latched_wdata_en = 0;
	end endtask

endclass

