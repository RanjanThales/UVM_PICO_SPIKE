
`uvm_analysis_imp_decl(_rvfi_instr)



class rvfi_ref_model extends uvm_component ;
   
    uvm_analysis_imp_rvfi_instr#(rvfi_seq_item, rvfi_ref_model) m_analysis_imp;
    uvm_analysis_port#(rvfi_seq_item, rvfi_ref_model) m_analysis_port;

    uvme_cva6_cfg_c  cfg ;

    `uvm_component_utils_begin(rvfi_ref_model)
      `uvm_field_object(cfg  , UVM_DEFAULT)
   `uvm_component_utils_end

function new(string name="rvfi_ref_model", uvm_component parent=null);

       super.new(name, parent);
       m_analysis_imp = new("m_analysis_imp", this);
       m_analysis_port = new("m_analysis_port", this);
endfunction : new

   function void build_phase(uvm_phase phase);
       super.build_phase(phase);

    if (uvm_config_db#(uvme_cva6_cfg_c)::get(this, "", "cfg", cfg)) begin
      `uvm_info("CFG", $sformatf("Found configuration handle:\n%s", cfg.sprint()), UVM_HIGH)
      uvm_config_db#(uvme_cva6_cfg_c)::set(this, "*", "cfg", cfg);
    end
    else begin
      `uvm_fatal("CFG", $sformatf("%s: Could not find configuration handle", this.get_full_name()));
    end  
   endfunction

   virtual function rvfi_seq_item step (int i, rvfi_seq_item t);

       `uvm_fatal(get_type_name(), "RVFI Reference model must be overridden")

   endfunction : step

   virtual function void write_rvfi_instr(rvfi_seq_item t);

       rvfi_seq_item   t_reference_model = step(1, t);
    


       m_analysis_port.write(t_reference_model);
                   `uvm_info(get_full_name(), $sformatf("ref_model: valid,order,insn,trap,halt,pc_rdata,pc_wdata,rs1_addr,rs1_rdata:%h\t%h\t%h\t%h\t%h\t%h\t%h\t%h\t%h\t%h\t%h\t%h\t%h", t_reference_model.valid,t_reference_model.order,t_reference_model.insn,t_reference_model.trap,t_reference_model.halt,t_reference_model.pc_rdata,t_reference_model.pc_wdata,t_reference_model.rs1_addr,t_reference_model.rs1_rdata,t_reference_model.rs2_addr,t_reference_model.rs2_rdata,t_reference_model.rd_addr,t_reference_model.rd_wdata), UVM_LOW)


   endfunction : write_rvfi_instr

   endclass




