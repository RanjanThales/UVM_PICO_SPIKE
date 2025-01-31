class rvfi_agent extends uvm_agent ;

   
    `uvm_component_utils(rvfi_agent)
     
      rvfi_monitor     monitor ;

      uvm_analysis_port#(rvfi_seq_item) rvfi_ap;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

   function void build_phase(uvm_phase phase);
       super.build_phase(phase);

       monitor = rvfi_monitor::type_id::create("monitor",this);

     endfunction

   function void connect_phase(uvm_phase phase);
       rvfi_ap = monitor.ap ;

   endfunction



endclass

