
class rvfi_monitor extends uvm_monitor ;
    
    	virtual rvfi_intf     rvfi_vif;
        event load_e ;

    `uvm_component_utils(rvfi_monitor)

    uvm_analysis_port#(rvfi_seq_item) ap;
    
    rvfi_seq_item  tr ;
    

    function new(string name , uvm_component parent );
        super.new(name , parent );
    endfunction

     function void build_phase(uvm_phase phase);
      super.build_phase(phase);
  
       if (!uvm_config_db#(virtual rvfi_intf)::get(this, "", "if", rvfi_vif)) begin
         `uvm_fatal(get_full_name(), "Cannot get rvfi_vif")
       end 

       ap = new("ap",this) ;
       tr = new();
    endfunction

virtual task run_phase (uvm_phase phase );

//wait(load_e.triggered);

`uvm_info(get_full_name(), $sformatf(" inside mon run phase "), UVM_LOW)

fork 
    collect();
join

 `uvm_info(get_full_name(), $sformatf("after collect task "), UVM_LOW)

    
endtask

task collect ();
 `uvm_info(get_full_name(),$sformatf(" inside collect task in monitor "), UVM_LOW)

`uvm_info(get_full_name(),$sformatf(" time : %0t", $time), UVM_LOW)
   
//    wait(rvfi_vif.valid===1'b1)
  
`uvm_info(get_full_name(),$sformatf(" time : %0t", $time), UVM_LOW)
 
`uvm_info(get_full_name(), $sformatf("MONITOR: resp collected :%0h ", rvfi_vif.valid), UVM_LOW)
 while(1) begin
     @(posedge rvfi_vif.clk)
     @(rvfi_vif.valid or rvfi_vif.trap)

fork   
     begin
        if(rvfi_vif.valid == 1'b1 || rvfi_vif.trap ) begin 

        tr.valid = rvfi_vif.valid ;
        tr.order = rvfi_vif.order ;
        tr.insn = rvfi_vif.insn ;
        tr.trap = rvfi_vif.trap ;
        tr.halt = rvfi_vif.halt ;
        tr.intr = rvfi_vif.intr ;

        tr.pc_rdata = rvfi_vif.pc_rdata ;
        tr.pc_wdata = rvfi_vif.pc_wdata ;

        tr.rs1_addr = rvfi_vif.rs1_addr ;
        tr.rs1_rdata = rvfi_vif.rs1_rdata ;

        tr.rs2_addr = rvfi_vif.rs2_addr ;
        tr.rs2_rdata = rvfi_vif.rs2_rdata ;
        
        tr.rd_addr = rvfi_vif.rd_addr ;
        tr.rd_wdata = rvfi_vif.rd_wdata ;

        tr.mem_addr = rvfi_vif.mem_addr ;
        tr.mem_rmask = rvfi_vif.mem_rmask ;
        tr.mem_wmask = rvfi_vif.mem_wmask ;

        tr.mem_rdata = rvfi_vif.mem_rdata ;
        tr.mem_wdata = rvfi_vif.mem_wdata ;
/*        
      //`uvm_info(get_full_name(), $sformatf("from monitor : \n%s", tr.convert2string()), UVM_LOW);
// `uvm_info(get_full_name(), $psprintf("MONITOR: resp collected :\n%s", tr.sprint()), UVM_LOW)
// `uvm_info(get_full_name(), $sformatf("MONITOR: resp intr :%h", tr.intr), UVM_LOW)
      `uvm_info(get_full_name(), $sformatf("MONITOR: resp valid :%h", tr.valid), UVM_LOW)
`uvm_info(get_full_name(), $sformatf("MONITOR: resp order :%h", tr.order), UVM_LOW)
`uvm_info(get_full_name(), $sformatf("MONITOR: resp insn :%h", tr.insn), UVM_LOW)
`uvm_info(get_full_name(), $sformatf("MONITOR: resp trap :%h", tr.trap), UVM_LOW)
`uvm_info(get_full_name(), $sformatf("MONITOR: resp halt:%h", tr.halt), UVM_LOW)
`uvm_info(get_full_name(), $sformatf("MONITOR: resp intr :%h", tr.intr), UVM_LOW)

 `uvm_info(get_full_name(), $sformatf("MONITOR: resp pc_rdata :%h", tr.pc_rdata), UVM_LOW)
 `uvm_info(get_full_name(), $sformatf("MONITOR: resp pc_wdata :%h", tr.pc_wdata), UVM_LOW)
 `uvm_info(get_full_name(), $sformatf("MONITOR: resp rs1_addr :%h", tr.rs1_addr), UVM_LOW)
 `uvm_info(get_full_name(), $sformatf("MONITOR: resp rs1_rdata :%h", tr.rs1_rdata), UVM_LOW)

  //`uvm_info(get_full_name(),$sformatf(" before ap write function in monitor "), UVM_LOW)
    
*/  
  ap.write(tr);

    `uvm_info(get_full_name(),$sformatf(" after ap write function in monitor "), UVM_LOW)
  end
 end
join_any


end


endtask

endclass


