
/*
class rvfi_spike extends rvfi_ref_model ;

    `uvm_component_utils(rvfi_spike)


    function new(string name="rvfi_spike", uvm_component parent=null);
       super.new(name, parent);
   endfunction : new


   function void build_phase(uvm_phase phase);

       super.build_phase(phase);


    //  rvfi_initialize_spike(cfg.core_name, st);
   endfunction : build_phase

   virtual function step (int i, rvfi_seq_item  t);

       st_rvfi  s_core, s_reference_model;

       rvfi_seq_item t_reference_model;

       s_core = t.seq2rvfi();

       rvfi_spike_step(s_core, s_reference_model);

       t_reference_model = new("t_reference_model");
       t_reference_model.rvfi2seq(s_reference_model);
       return t_reference_model;

   endfunction : step

endclass 
*/


class rvfi_spike#(int ILEN=32,int XLEN=32) extends rvfi_ref_model;

   `uvm_component_param_utils(rvfi_spike)
   /**
    * Default constructor.
    */
   function new(string name="rvfi_spike", uvm_component parent=null);

       super.new(name, parent);

   endfunction : new

   /**
    * Build phase
    */
   function void build_phase(uvm_phase phase);
 st_core_cntrl_cfg st;

       super.build_phase(phase);
           
       st = cfg.to_struct();
  `uvm_info("spike", "bp Spike", UVM_LOW)

       rvfi_initialize_spike(cfg.core_name, st);
   endfunction : build_phase

   /**
    * Step function - Steps the core and returns a rvfi transaction
    */
   virtual function rvfi_seq_item#(ILEN,XLEN) step (int i, rvfi_seq_item#(ILEN,XLEN) t);

       st_rvfi s_core, s_reference_model;
       rvfi_seq_item#(ILEN,XLEN) t_reference_model;

       s_core = t.seq2rvfi();

`uvm_info(get_full_name(), $sformatf("rvfi_spike: s_core (input_2_spike):%h", s_core), UVM_LOW)
 `uvm_info("spike", "bEFORE  Spike", UVM_LOW)
       rvfi_spike_step(s_core, s_reference_model);
 `uvm_info("spike", "AFTER Spike", UVM_LOW)
`uvm_info(get_full_name(), $sformatf("rvfi_spike: s_reference_model (out of spike):%h", s_reference_model), UVM_LOW)

       t_reference_model = new("t_reference_model");
       t_reference_model.rvfi2seq(s_reference_model);
       `uvm_info(get_full_name(), $sformatf("rvfi_spike: valid,order,insn,trap,halt,intr,pc_rdata,pc_wdata,rs1_addr,rs1_rdata:%h\t%h\t%h\t%h\t%h\t%h\t%h\t%h\t%h\t%h\t%h\t%h\t%h\t%h", t_reference_model.valid,t_reference_model.order,t_reference_model.insn,t_reference_model.trap,t_reference_model.halt,t_reference_model.intr,t_reference_model.pc_rdata,t_reference_model.pc_wdata,t_reference_model.rs1_addr,t_reference_model.rs1_rdata,t_reference_model.rs2_addr,t_reference_model.rs2_rdata,t_reference_model.rd_addr,t_reference_model.rd_wdata), UVM_LOW)


`uvm_info(get_full_name(), $sformatf("rvfi_spike: t_reference_model:%h", t_reference_model), UVM_LOW)
       return t_reference_model;

   endfunction : step

endclass : rvfi_spike



