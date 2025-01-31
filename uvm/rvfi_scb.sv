`uvm_analysis_imp_decl(_rvfi_core)
`uvm_analysis_imp_decl(_rvfi_ref_model)


class rvfi_scb extends uvm_scoreboard ;

    uvm_analysis_imp_rvfi_core#(rvfi_seq_item , rvfi_scb) a_imp ;
    uvm_analysis_imp_rvfi_ref_model#(rvfi_seq_item, rvfi_scb) a_imp_ref_model;
   
    `uvm_component_utils(rvfi_scb)
   
    event load_e ;

    rvfi_seq_item   item[$];
     rvfi_seq_item   item_ref[$];
     rvfi_seq_item  txn ;
      rvfi_seq_item  tr_ref ;

    function new(name , uvm_component parent);
        super.new(name,parent);
        a_imp = new("a_imp",this) ;
        a_imp_ref_model = new("a_imp_ref_model", this) ;
    endfunction

   
     function void build_phase(uvm_phase phase);
       super.build_phase(phase);
      
        txn = rvfi_seq_item::type_id::create("txn") ;
        tr_ref = rvfi_seq_item::type_id::create("tr_ref") ;

     endfunction
    
    virtual task run_phase(uvm_phase phase);
        
   forever begin
             `uvm_info(get_full_name(),$sformatf(" inside forever of runphase of scb  "), UVM_LOW)

            @(item.size > 0)
        while(item.size > 0) begin
      //       `uvm_info(get_full_name(),$sformatf(" inside runphase of scb after item change "), UVM_LOW)
                tr_ref = item_ref.pop_front();
            `uvm_info(get_full_name(), $sformatf("SCB: order,insn,trap,halt,pc_rdata,pc_wdata,rs1_addr,rs1_rdata:%h\t%h\t%h\t%h\t%h\t%h\t%h\t%h", tr_ref.order,tr_ref.insn,tr_ref.trap,tr_ref.halt,tr_ref.pc_rdata,tr_ref.pc_wdata,tr_ref.rs1_addr,tr_ref.rs1_rdata), UVM_LOW)
               
 txn = item.pop_front();

  `uvm_info(get_full_name(), $sformatf("SC: resp valid :%h", txn.valid), UVM_LOW)
`uvm_info(get_full_name(), $sformatf("sc: resp order :%h", txn.order), UVM_LOW)
`uvm_info(get_full_name(), $sformatf("sc: resp insn :%h", txn.insn), UVM_LOW)
`uvm_info(get_full_name(), $sformatf("sc: resp trap :%h", txn.trap), UVM_LOW)
`uvm_info(get_full_name(), $sformatf("sc: resp halt:%h", txn.halt), UVM_LOW)
 `uvm_info(get_full_name(), $sformatf("sc: resp pc_rdata :%h", txn.pc_rdata), UVM_LOW)
 `uvm_info(get_full_name(), $sformatf("sc: resp pc_wdata :%h", txn.pc_wdata), UVM_LOW)
 `uvm_info(get_full_name(), $sformatf("sc: resp rs1_addr :%h", txn.rs1_addr), UVM_LOW)
 `uvm_info(get_full_name(), $sformatf("sc: resp rs1_rdata :%h", txn.rs1_rdata), UVM_LOW)
 `uvm_info(get_full_name(), $sformatf("sc: resp rs2_addr :%h", txn.rs2_addr), UVM_LOW)
 `uvm_info(get_full_name(), $sformatf("sc: resp rs2_rdata :%h", txn.rs2_rdata), UVM_LOW)
 `uvm_info(get_full_name(), $sformatf("sc: resp rd_addr :%h", txn.rd_addr), UVM_LOW)
 `uvm_info(get_full_name(), $sformatf("sc: resp rd_wdata :%h", txn.rd_wdata), UVM_LOW)
 `uvm_info(get_full_name(), $sformatf("sc: resp mem_addr :%h", txn.mem_addr), UVM_LOW)
 `uvm_info(get_full_name(), $sformatf("sc: resp mem_rdata :%h", txn.mem_rdata), UVM_LOW)
 `uvm_info(get_full_name(), $sformatf("sc: resp mem_wdata :%h", txn.mem_wdata), UVM_LOW)


                 rvfi_compare(txn.seq2rvfi(), tr_ref.seq2rvfi());


                    `uvm_info(get_full_name(),$sformatf(" inside scb runphase after pop  "), UVM_LOW) 
                //    `uvm_info(get_full_name(),$sformatf(" inside scb runphase after pop  printing txn: \n %s ",txn.sprint()), UVM_LOW) 
                 
 
 
 end
   end

    endtask

    function void write_rvfi_ref_model(rvfi_seq_item t);
         // rvfi_seq_item temp=new();
        item_ref.push_back(t);
//temp = item_ref.pop_front();
//`uvm_info(get_full_name(), $sformatf("SC: spike_insn :%h", temp.insn), UVM_LOW)

    endfunction

    function void write_rvfi_core(rvfi_seq_item tx);
         `uvm_info(get_full_name(),$sformatf(" inside write function in scb "), UVM_LOW)

        item.push_back(tx);
         `uvm_info(get_full_name(),$sformatf(" after item push back in write function in scb "), UVM_LOW)

    endfunction


 function automatic void rvfi_compare(st_rvfi t_core, st_rvfi t_reference_model);
        int core_pc64, reference_model_pc64;
        string cause_str = "";
        bit error;
        string instr;
        uvma_rvfi_mode mode;

       // core_pc64 = {{riscv::XLEN-riscv::VLEN{t_core.pc_rdata[riscv::VLEN-1]}}, t_core.pc_rdata};
        //reference_model_pc64 = {{riscv::XLEN-riscv::VLEN{t_reference_model.pc_rdata[riscv::VLEN-1]}}, t_reference_model.pc_rdata};
      

              if(t_core.pc_rdata[7:0] == t_reference_model.pc_rdata[7:0]) begin
             `uvm_info("RVFI","t_core.pc_rdata & t_reference_model.pc_rdata matching", UVM_LOW)
              `uvm_info("RVFI_UTILS", $sformatf("UTILS: resp pc_rdata :%h\t%h", t_core.pc_rdata, t_reference_model.pc_rdata), UVM_LOW)
      

          if(t_core.insn == t_reference_model.insn) begin
             `uvm_info("RVFI","t_core.insn & t_reference_model.insn matching", UVM_LOW)
              `uvm_info("RVFI_UTILS", $sformatf("UTILS: resp insn :%h\t%h", t_core.insn, t_reference_model.insn), UVM_LOW)
          end

              if(t_core.rd_addr == t_reference_model.rd_addr) begin
             `uvm_info("RVFI",$sformatf("t_core.rd_addr & t_reference_model.rd_addr matching : %h\t%h",t_core.rd_addr,t_reference_model.rd_addr), UVM_LOW)
         end
         
         
          if(t_core.trap == t_reference_model.trap) begin
             `uvm_info("RVFI","t_core.trap & t_reference_model.trap matching", UVM_LOW)
              `uvm_info("RVFI_UTILS", $sformatf("UTILS: resp trap :%h\t%h", t_core.trap, t_reference_model.trap), UVM_LOW)

         end

         
         if(t_core.rs1_addr == t_reference_model.rs1_addr) begin
             `uvm_info("RVFI",$sformatf("t_core.rs1_addrrs1_addr & t_reference_model.rs1_addr matching : %h\t%h",t_core.rs1_addr,t_reference_model.rs1_addr), UVM_LOW)
         end



         if(t_core.order == t_reference_model.order) begin
             `uvm_info("RVFI",$sformatf("t_core.order & t_reference_model.order matching : %h\t%h",t_core.order,t_reference_model.order), UVM_LOW)
         end
        if(t_core.halt == t_reference_model.halt) begin
            `uvm_info("RVFI",$sformatf("t_core.halt & t_reference_model.halt matching : %h\t%h",t_core.halt,t_reference_model.halt), UVM_LOW)
         end
      else begin
             error =1 ;

         end

        end

 

   
     /*   $cast(mode, t_reference_model.mode);
        // TODO Add more fields from Spike side
        // This macro avoid glitches in verilator
        //instr = $sformatf(`FORMAT_INSTR_STR_MACRO, $sformatf("%t", $time),
                       // 0,
                       // t_reference_model.trap,
                        t_reference_model.pc_rdata,
                        $sformatf("%08x", t_reference_model.insn),
                        get_mode_str(mode),
                        t_reference_model.rs1_addr, t_reference_model.rs1_rdata,
                        t_reference_model.rs2_addr, t_reference_model.rs2_rdata,
                        t_reference_model.rd1_addr, t_reference_model.rd1_wdata);
        `uvm_info("spike_tandem", instr, UVM_NONE)
        */
        if (error) begin
            //`uvm_error("spike_tandem", cause_str)
            `uvm_error("spike_tandem", cause_str)
        end
    endfunction : rvfi_compare

endclass 

