class env extends uvm_env ;

    virtual axi_intf     axi_vif;
    axi_agent agt;
    rvfi_agent agent;
    rvfi_scb  scb ; 
    rvfi_ref_model  refm ;
    uvme_cva6_cfg_c  cfg ;
    `uvm_component_utils(env)

    function new(string name, uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);

        if (!uvm_config_db#(virtual axi_intf)::get(this, "", "vif", axi_vif)) begin
         `uvm_fatal(get_full_name(), "Cannot get axi_vif")
        end
            
        scb =rvfi_scb::type_id::create("scb",this) ; 
        agent = rvfi_agent::type_id::create("agent", this);
        agt = axi_agent::type_id::create("agt", this);
        refm = rvfi_ref_model::type_id::create("refm", this);
    endfunction
   
   function void connect_phase(uvm_phase phase);
       agent.rvfi_ap.connect(scb.a_imp) ;
       agent.rvfi_ap.connect(refm.m_analysis_imp );
     refm.m_analysis_port.connect(scb.a_imp_ref_model);  
     refm.cfg = cfg ;
 endfunction
 
endclass
