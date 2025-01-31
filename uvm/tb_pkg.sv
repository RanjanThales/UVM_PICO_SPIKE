
  
package tb_pkg;
        import uvm_pkg::*;
        `include "uvm_macros.svh"

        `include "./uvm/axi_mem_model.sv"

        `include "./uvm/axi_sequencer.sv"
        `include "./uvm/axi_driver.sv"
        `include "./uvm/axi_agent.sv"

        `include "./uvm/uvma_rvfi_tdefs.sv"
         `include  "./uvm/uvma_core_cntrl_tdefs.sv"
         `include  "./uvm/uvma_core_cntrl_cfg.sv"
           `include  "./uvm/uvme_core_cfg.sv"

        `include "./uvm/rvfi_seq_item.sv"
        `include "./uvm/rvfi_monitor.sv"
        `include "./uvm/rvfi_agent.sv"

              
        `include "./uvm/rvfi_utils.sv"
        `include "./uvm/rvfi_ref_model.sv"
       `include "./uvm/rvfi_spike.sv"
         `include "./uvm/rvfi_scb.sv"
        `include "./uvm/env.sv"
        `include "./uvm/base_test.sv"

endpackage
