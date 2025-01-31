
class base_test extends uvm_test;

	virtual axi_intf     axi_vif;
        axi_mem_model     mem;
        uvme_cva6_cfg_c  cfg ;
        env                     envi ;
	string               firmware_file;
	time timeout = 5000ms/1ps ;
       
    logic [31:0] local_mem [0:512*1024/4-1];
        
        `uvm_component_utils(base_test)
  
	function new(string name, uvm_component parent);
          super.new(name, parent);
	endfunction: new

virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  
    if (!uvm_config_db#(virtual axi_intf)::get(this, "", "vif", axi_vif)) begin
      `uvm_fatal(get_full_name(), "Cannot get axi_vif")
    end 
	envi = env#()::type_id::create("envi" , this);
	mem = axi_mem_model#()::type_id::create("mem");
   
        cfg = uvme_cva6_cfg_c::type_id::create("cfg");
     uvm_config_db#(uvme_cva6_cfg_c)::set(this, "*", "cfg", cfg);

    uvm_config_db #(axi_mem_model)::set(null, "*", "memory", mem);
    
   `uvm_info("firmware_test", "Overriding Reference Model with Spike", UVM_NONE)
   set_type_override_by_type(rvfi_ref_model::get_type(),rvfi_spike::get_type());

           
endfunction

virtual function void connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  envi.cfg = cfg;
endfunction



virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    uvm_top.set_timeout(timeout) ;
    void'($value$plusargs("firmware=%0s", firmware_file));
    if (firmware_file == "")begin
      `uvm_fatal(get_full_name(), "Please specify test binary by +firmware=firmware_file_name")
    end
    else begin
     `uvm_info(get_full_name(), $sformatf("inside"), UVM_LOW)
     load_binary_to_mems();
    `uvm_info(get_full_name(), $sformatf("Running test binary : %0s", firmware_file), UVM_LOW)
    -> envi.agt.driver.load_e ;
  //  -> envi.agent.monitor.load_e ;
  //  -> envi.scb.load_e ;

   end
   
//    phase.drop_objection(this);

endtask

	task load_binary_to_mems();

	`uvm_info(get_full_name(), $sformatf("in base test"), UVM_LOW);

	$readmemh(firmware_file, local_mem);
   
    for (int i = 0; i < 20; i++) begin
        //mem.memory[i+32'h10000]=local_mem[i];
        envi.agt.driver.axi_mem.memory[i+65536]=local_mem[i];
         `uvm_info("Memory_Printing", $sformatf("local_mem[%0d] = %h", i, local_mem[i]), UVM_LOW);
        // `uvm_info("Memory_Printing", $sformatf("memory[%0d] = %h", i, mem.memory[i+65536]), UVM_LOW);
          end
    -> envi.agt.driver.load_e ;
	endtask
      endclass
