// import uvm_pkg::*;
//`include "uvm_macros.svh"
//import tb_pkg::*;

class axi_mem_model extends uvm_object ;

	/*localparam int MaskWidth  = DataWidth / 8;

	typedef logic [AddrWidth-1:0] mem_addr_t;
	typedef logic [DataWidth-1:0] mem_data_t;
	typedef logic [MaskWidth-1:0] mem_mask_t; */

	//logic [31:0]   memory [0:128*1024/4-1];
	logic [31:0]   memory [0:512*1024/4-1];

	`uvm_object_utils(axi_mem_model)
	
	function new(string name="");
    super.new(name);
	endfunction
        
        function printmem();
            for (int i = 0; i < (128*1024/4); i++) begin
         `uvm_info("Memory_Printing", $sformatf("memory[%0d] = %h", i, memory[i]), UVM_HIGH);
    end 
        endfunction

/*	function void init();
		memory.delete();
	endfunction*/

/*	function int get_written_bytes();
		return memory.size();
	endfunction*/

	/*function bit [7:0] read_byte(mem_addr_t addr);
		bit [7:0] data;
		if (addr_exists(addr)) begin
		data = memory[addr];
		`uvm_info(get_full_name(), $sformatf("Read Mem  : Addr[0x%0h], Data[0x%0h]", addr, data), UVM_LOW)
		end else begin
		//`DV_CHECK_STD_RANDOMIZE_FATAL(data)
		`uvm_error(get_full_name(), $sformatf("read from uninitialized addr 0x%0h", addr))
		end
		return data;
	endfunction

	function void write_byte(mem_addr_t addr, logic [7:0] data);
		`uvm_info(get_full_name(), $sformatf("Write Mem : Addr[0x%0h], Data[0x%0h]", addr, data), UVM_HIGH)
		memory[addr] = data;
	endfunction

	function void compare_byte(mem_addr_t addr, logic [7:0] act_data);
	`uvm_info(get_full_name(), $sformatf("Compare Mem : Addr[0x%0h], Act Data[0x%0h], Exp Data[0x%0h]",
                             addr, act_data,memory[addr]), UVM_MEDIUM)
   // `DV_CHECK_CASE_EQ(act_data, system_memory[addr],
                    //  $sformatf("addr 0x%0h read out mismatch", addr))
	endfunction

	function void write(input mem_addr_t addr, mem_data_t data, mem_mask_t mask = '1);
		bit [7:0] byte_data;
		for (int i = 0; i < DataWidth / 8; i++) begin
		if (mask[0]) begin
			byte_data = data[7:0];
			write_byte(addr + i, byte_data);
		`uvm_info(get_full_name(), $sformatf("Addr[0x%0h], byte_data[0x%0h]", addr, byte_data), UVM_HIGH)
		end
	    data = data >> 8;
		mask = mask >> 1;
	`uvm_info(get_full_name(), $sformatf("data[0x%0h], mask[0x%0h]",data, mask), UVM_HIGH)
		end 
	endfunction

	function mem_data_t read(mem_addr_t addr, mem_mask_t mask = '1);
		mem_data_t data;
		for (int i = DataWidth / 8 - 1; i >= 0; i--) begin
		data = data << 8;
		if (mask[MaskWidth - 1]) data[7:0] = read_byte(addr + i);
		else                     data[7:0] = 0;
		mask = mask << 1;
		end
		return data;
	endfunction

	function void compare(mem_addr_t addr, mem_data_t act_data, mem_mask_t mask = '1,
                        bit compare_exist_addr_only = 1);
		bit [7:0] byte_data;
		for (int i = 0; i < DataWidth / 8; i++) begin
		mem_addr_t byte_addr = addr + i;
		byte_data = act_data[7:0];
		if (mask[0]) begin
			if (addr_exists(byte_addr)) begin
				compare_byte(byte_addr, byte_data);
			end else if (!compare_exist_addr_only) begin
				`uvm_error(get_full_name(), $sformatf("address 0x%0x not exists", byte_addr))
			end
		end else begin
    	end
		act_data = act_data>> 8;
		mask = mask >> 1;
		end
	endfunction */

/*	function bit addr_exists(mem_addr_t addr);
		return memory.exists(addr);
	endfunction*/
endclass
