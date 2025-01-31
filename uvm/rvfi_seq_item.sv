typedef struct packed {
   longint unsigned         valid;
   longint unsigned         order;
   longint unsigned         insn;
   longint unsigned         trap;
   longint unsigned         halt;
   longint unsigned         intr;
 
   longint unsigned         pc_rdata;
   longint unsigned         pc_wdata;

   longint unsigned         rs1_addr;
   longint unsigned         rs1_rdata;

   longint unsigned         rs2_addr;
   longint unsigned         rs2_rdata;


   longint unsigned         rd_addr;
   longint unsigned         rd_wdata;

   longint unsigned         mem_addr;
   longint unsigned         mem_rdata;
   longint unsigned         mem_rmask;
   longint unsigned         mem_wdata;
   longint unsigned         mem_wmask;

} st_rvfi;

`define ST_NUM_WORDS (($size(st_rvfi)/$size(longint unsigned)))

typedef union {
    st_rvfi rvfi;
    bit [63:0] array [`ST_NUM_WORDS-1:0] ;
 //   bit [63:0] array [64-1:0] ; //edited
} union_rvfi;


//`include "uvma_rvfi_tdefs.sv"

class rvfi_seq_item extends uvm_sequence_item ;

    `uvm_object_utils(rvfi_seq_item)
    
        rand bit            valid; // 99
    	rand bit [63:0]      order; // 98 83
	rand bit  [31:0]      insn; // 82 75
	rand bit             trap; //74
	rand bit            halt;  //73
	rand bit            intr;  // 72

	rand bit [31:0]       pc_rdata; // 71  64
	rand bit [31:0]      pc_wdata; // 63 56

	rand bit [ 4:0]       rs1_addr; //  55 54
	rand bit [31:0]       rs1_rdata;//  53 46

	rand bit  [4:0]       rs2_addr; // 45 44
	rand bit  [31:0]      rs2_rdata; //43 36

        rand bit  [4:0]      rd_addr;  // 35 34
	rand bit  [31:0]      rd_wdata; //33 26

	rand bit [31:0]        mem_addr; //25  18
	rand bit [3:0]      mem_rmask; //   17
	rand bit [3:0]      mem_wmask;  // 16
	rand bit  [31:0]      mem_rdata; //15 8
	rand bit  [31:0]      mem_wdata; //7 0
	
/*
typedef struct packed {
   longint unsigned         valid;
   longint unsigned         order;
   longint unsigned         insn;
   longint unsigned         trap;
   longint unsigned         halt;
   longint unsigned         intr;
 
   longint unsigned         pc_rdata;
   longint unsigned         pc_wdata;

   longint unsigned         rs1_addr;
   longint unsigned         rs1_rdata;

   longint unsigned         rs2_addr;
   longint unsigned         rs2_rdata;


   longint unsigned         rd_addr;
   longint unsigned         rd_wdata;

   longint unsigned         mem_addr;
   longint unsigned         mem_rdata;
   longint unsigned         mem_rmask;
   longint unsigned         mem_wdata;
   longint unsigned         mem_wmask;

} st_rvfi;

*/

    function new(string name=" ");
        super.new(name);

    endfunction

    extern function st_rvfi seq2rvfi();

   extern function void rvfi2seq(st_rvfi rvfi);

endclass
    function st_rvfi rvfi_seq_item::seq2rvfi();
        st_rvfi rvfi ;

        rvfi.valid           = valid        ;
        rvfi.order           = order        ;
        rvfi.insn            = insn         ;
        rvfi.trap            = trap         ;
        rvfi.halt            = halt         ;   
        rvfi.intr            = intr         ;
        rvfi.pc_rdata        = pc_rdata     ;
        rvfi.pc_wdata        = pc_wdata     ;
        rvfi.rs1_addr        = rs1_addr     ;
        rvfi.rs1_rdata       = rs1_rdata    ;
        rvfi.rs2_addr        = rs2_addr     ;
        rvfi.rs2_rdata       = rs2_rdata    ;
        rvfi.rd_addr         = rd_addr      ;
        rvfi.rd_wdata        = rd_wdata     ;
        rvfi.mem_addr        = mem_addr     ;
        rvfi.mem_rmask       = mem_rmask    ;
        rvfi.mem_wmask       = mem_wmask    ;
        rvfi.mem_rdata       = mem_rdata    ;
        rvfi.mem_wdata       = mem_wdata    ;
        
        return rvfi ;
    endfunction 

    function void rvfi_seq_item::rvfi2seq(st_rvfi rvfi);
                           
       valid                     =        rvfi.valid          ; 
       order                     =        rvfi.order          ;
       insn                      =        rvfi.insn           ;
       trap                      =        rvfi.trap           ;
       halt                      =        rvfi.halt           ;
       intr                      =        rvfi.intr           ;
       pc_rdata                  =        rvfi.pc_rdata       ;
       pc_wdata                  =        rvfi.pc_wdata       ;
       rs1_addr                  =        rvfi.rs1_addr       ;
       rs1_rdata                 =        rvfi.rs1_rdata      ;
       rs2_addr                  =        rvfi.rs2_addr       ;
       rs2_rdata                 =        rvfi.rs2_rdata      ;
       rd_addr                   =        rvfi.rd_addr        ;
       rd_wdata                  =        rvfi.rd_wdata       ;
       mem_addr                  =        rvfi.mem_addr       ;
       mem_rmask                 =        rvfi.mem_rmask      ;
       mem_wmask                 =        rvfi.mem_wmask      ;
       mem_rdata                 =        rvfi.mem_rdata      ;
       mem_wdata                 =        rvfi.mem_wdata      ;

    endfunction


