
import "DPI-C" function int spike_create(string filename);

import "DPI-C" function void spike_set_param_uint64_t(string base, string name, longint unsigned value);
import "DPI-C" function void spike_set_param_str(string base, string name, string value);
import "DPI-C" function void spike_set_param_bool(string base, string name, bit value);
import "DPI-C" function void spike_set_default_params(string profile);

import "DPI-C" function void spike_step_svOpenArray(inout bit [63:0] core[], inout bit [63:0] reference_model[]);
import "DPI-C" function void spike_step_struct(inout st_rvfi core, inout st_rvfi reference_model);

 function automatic void rvfi_spike_step(ref st_rvfi s_core, ref st_rvfi s_reference_model);

        union_rvfi u_core;
        union_rvfi u_reference_model;
        bit [63:0] a_core [`ST_NUM_WORDS-1:0];
    //   bit [63:0] a_core [64-1:0];
        bit [63:0] a_reference_model [`ST_NUM_WORDS-1:0];
   //    bit [63:0] a_reference_model [64-1:0];

        u_core.rvfi = s_core;

        foreach(u_core.array[i]) begin
            a_core[i] = u_core.array[i];
        end
         `uvm_info("utils", "before svopenarray", UVM_LOW)

        spike_step_svOpenArray(a_core, a_reference_model);

         `uvm_info("utils", "AFTER svopenarray", UVM_LOW)


        foreach(a_reference_model[i]) begin
            u_reference_model.array[i] = a_reference_model[i];
        end
        s_reference_model = u_reference_model.rvfi;

    endfunction : rvfi_spike_step

    function automatic void rvfi_initialize_spike(string core_name, st_core_cntrl_cfg core_cfg);
       string binary, rtl_isa, rtl_priv;
        string base = $sformatf("/top/core/%0d/", core_cfg.mhartid);

        if ($value$plusargs("elf_file=%s", binary))
            `uvm_info("spike_tandem", $sformatf("Setting up Spike with binary %s...", binary), UVM_LOW);

                        
        //rtl_isa = $sformatf("RV32I");
        rtl_isa = $sformatf("RV32I");
        rtl_priv = "M";
    /*    if (core_cfg.ext_a_supported)       rtl_isa = {rtl_isa, "A"};
        if (core_cfg.ext_f_supported)       rtl_isa = {rtl_isa, "F"};
        if (core_cfg.ext_d_supported)       rtl_isa = {rtl_isa, "D"};
        if (core_cfg.ext_c_supported)       rtl_isa = {rtl_isa, "C"};
        if (core_cfg.ext_zba_supported)     rtl_isa = {rtl_isa, "_zba"};
        if (core_cfg.ext_zbb_supported)     rtl_isa = {rtl_isa, "_zbb"};
        if (core_cfg.ext_zbc_supported)     rtl_isa = {rtl_isa, "_zbc"};
        if (core_cfg.ext_zbs_supported)     rtl_isa = {rtl_isa, "_zbs"};
        if (core_cfg.ext_zcb_supported)     rtl_isa = {rtl_isa, "_zcb"};
        if (core_cfg.ext_zicsr_supported)     rtl_isa = {rtl_isa, "_zicsr"};
        if (core_cfg.ext_zicntr_supported)     rtl_isa = {rtl_isa, "_zicntr"};

        if (core_cfg.mode_s_supported)      rtl_priv = {rtl_priv, "S"};
        if (core_cfg.mode_u_supported)      rtl_priv = {rtl_priv, "U"};

        if (core_cfg.ext_cv32a60x_supported) begin
            void'(spike_set_param_str("/top/core/0/", "extensions", "cv32a60x"));
        end
*/
        assert(binary != "") else `uvm_error("spike_tandem", "We need a preloaded binary for tandem verification");
        void'(spike_set_default_params(core_name));

        void'(spike_set_param_uint64_t("/top/", "num_procs", 64'h1));

        void'(spike_set_param_str("/top/", "isa", rtl_isa));
        void'(spike_set_param_str(base, "isa", rtl_isa));
        void'(spike_set_param_str("/top/", "priv", rtl_priv));
        void'(spike_set_param_str(base, "priv", rtl_priv));
        void'(spike_set_param_bool("/top/", "misaligned", core_cfg.unaligned_access_supported));

       // if (core_cfg.boot_addr_valid)
         //   void'(spike_set_param_uint64_t(base, "boot_addr", core_cfg.boot_addr));
            //void'(spike_set_param_uint64_t(base, "boot_addr", 64'h80000080));
            //void'(spike_set_param_uint64_t(base, "boot_addr", 64'h10000000));
          // void'(spike_set_param_uint64_t(base, "boot_addr", 32'h80000000));
            void'(spike_set_param_uint64_t(base, "boot_addr", 32'h10000));
            //void'(spike_set_param_uint64_t(base, "boot_addr", 64'h00000028));
        void'(spike_set_param_uint64_t(base, "pmpregions", core_cfg.pmp_regions));
        if (core_cfg.mhartid_valid) begin
            void'(spike_set_param_uint64_t(base, "mhartid", core_cfg.mhartid));
        if (core_cfg.mvendorid_valid) void'(spike_set_param_uint64_t(base, "mvendorid", core_cfg.mvendorid));
            void'(spike_set_param_bool(base, "misaligned", core_cfg.unaligned_access_supported));
         end
        void'(spike_create(binary));

    endfunction : rvfi_initialize_spike

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


         

      /*  if (t_core.valid == t_reference_model.valid) begin
`uvm_info("t_core.valid & t_reference_model.valid matching", "###Lets_compare####", UVM_LOW) 
      if (t_core[82:75] == t_reference_model[82:75]) begin
 //`uvm_info("t_core.insn=%h & t_reference_model.insn=%h matching" t_core.insn, t_reference_model.insn), UVM_LOW)
 `uvm_info("t_core.insn & t_reference_model.insn matching","INSN", UVM_LOW)
    if (t_core[71:64] == t_reference_model[71:64]) begin
                                //    error = 1;
                    cause_str = $sformatf("%s\nRD ADDR  Mismatch [REF]: 0x%-16h [CORE]: 0x%-16h", cause_str, t_reference_model.pc_rdata, t_core.pc_rdata);
                end
                if (t_core.rd_wdata != t_reference_model.rd_wdata) begin
                    error = 1;
                    cause_str = $sformatf("%s\nRD VAL Mismatch  [REF]: 0x%-16h [CORE]: 0x%-16h", cause_str, t_reference_model.rd_wdata, t_core.rd_wdata);
                end

      
      else begin
          error =1 ;
                cause_str = $sformatf("%s\nINSN Mismatch    [REF]: 0x%-16h [CORE]: 0x%-16h", cause_str, t_reference_model.insn, t_core.insn);
            end
            
           

                 
            if (t_core.mode !== t_reference_model.mode) begin
                error = 1;
                cause_str = $sformatf("%s\nPRIV Mismatch    [REF]: 0x%-16h [CORE]: 0x%-16h", cause_str, t_reference_model.mode, t_core.mode);
            end 
        
    
      if (core_pc64 !== reference_model_pc64) begin
            error = 1;
            cause_str = $sformatf("%s\nPC Mismatch      [REF]: 0x%-16h [CORE]: 0x%-16h", cause_str, reference_model_pc64, core_pc64);
        end*/

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
       // if (error) begin
         //   `uvm_error("spike_tandem", cause_str)
       // end
    endfunction : rvfi_compare

