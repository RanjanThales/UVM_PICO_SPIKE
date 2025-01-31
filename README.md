# UVM_PICO_SPIKE
UVM based PICO verification Environment with integrated SPIKE
UVM based PICO verification Environment
UVM_PICO_SPIKE

Original PICO core 
https://github.com/YosysHQ/picorv32.git

Added missing RVFI signals to picorv32_axi and picorv32_wb
https://github.com/MathieuSnd/picorv32.git

For the development of the UVM based verification environment, we have considered the RVFI signals with PICO core. This is because verification environment demands comparison of RVFI signals with generated ISS log.

RVFI trace output format:
Trace output format
The trace log file format is as described below.
1.	pc: The program counter
2.	rs1(data) Register read port 1 source register and read data
3.	rs2(data) Register read port 2 source register and read data
4.	rd(data) Register write port 1 destination register and write data
5.	memaddr Memory address for instructions accessing memory
6.	rmask Bitmask specifying which bytes in rdata contain valid read data
7.	rdata The data read from memory address specified in memaddr
8.	wmask Bitmask specifying which bytes in wdata contain valid write data
9.	wdata The data written to memory address specified in memaddr
10.	Assembly Assembly code. This column is only populated if an itb file is provided

![image](https://github.com/user-attachments/assets/7713cdf1-3260-4a06-9854-14d7c0c01d24)
Here we have integrated SPIKE (Instruction set simulator) to the UVM environment of PICO and compared the both packets in the Scoreboard of environment. 

**Installation**

**Tool chain** 
Installation of Toolchain is same as riscv-gnu-toolchain.

https://github.com/riscv-collab/riscv-gnu-toolchain.git

**SPIKE:**
Installation of spike for this project is same as the provided steps in core-v-verif/vendor 

https://github.com/openhwgroup/core-v-verif/tree/master/vendor

Build Steps
We assume that the RISCV environment variable is set to the RISC-V tools install path.
$ apt-get install device-tree-compiler

$ mkdir build

$ cd build

$ ../configure --prefix=$RISCV

$ make

$ [sudo] make install 

Note: to support current RTL version (in PICO), we have following changes before to the installation 
https://github.com/openhwgroup/core-v-verif/blob/master/vendor/riscv/riscv-isa-sim/riscv/Types.h

![image](https://github.com/user-attachments/assets/4f0e7286-2789-48b2-a736-bbe1df108bc8)

Integration of Spike with UVM environment

![image](https://github.com/user-attachments/assets/3199ed17-79de-402c-ac68-9ac6d8bcbcdf)


UVM Test Bench with RVFI Agent & Reference model 
![image](https://github.com/user-attachments/assets/022d5070-a9df-4d01-a4e0-a5520f6e422d)


Stages of Development So far
1.	Updated PICO core with a Wrapper  (i.e DUT)
2.	Develop a Memory Model (MM) & populate in Base test 
3.	Reutilize existing AXI logic to develop a AXI Agent (need to revisit !!) 
4.	Develop a UVM Framework and Test-bench around DUT
5.	Considering the need to RVFI for capturing the core Status, Minimum design changes is made*
6.	Develop a RVFI Agent & connection to Scoreboard  
7.	Spike Integration to the Environment 
	Modification to UVM component 
	Modification to Simulation argument 
8.	Integration of Scoreboard to ENV with PICO parameters 

Test files:

**files.flist**

./uvm/tb_pkg.sv

./interface/axi_intf.sv

./interface/rvfi_intf.sv

./RTL/picorv32.sv

./RTL/picorv32_axi_adapter.sv    

./RTL/picorv32_axi.sv

./RTL/picorv32_wrapper.sv

./tb_top.sv

**tb_pkg.sv**

package tb_pkg;
        import uvm_pkg::*;
        
        `include "uvm_macros.svh"
        
        `include "axi_mem_model.sv"
        
        `include "axi_sequencer.sv"
        
        `include "axi_driver.sv"
        
        `include "axi_agent.sv"
        
        `include "uvma_rvfi_tdefs.sv"
        
        `include  "uvma_core_cntrl_tdefs.sv"
        
        `include  "uvma_core_cntrl_cfg.sv"
        
        `include  "uvme_cva6_cfg.sv"
        
        `include "rvfi_seq_item.sv"
        
        `include "rvfi_monitor.sv"
        
        `include "rvfi_agent.sv"
        
        `include "rvfi_utils.sv"
        
        `include "rvfi_ref_model.sv"
        
        `include "rvfi_spike.sv"
        
        `include "rvfi_scb.sv"
        
        `include "env.sv"
        
        `include "base_test.sv"
        
endpackage

**User need to change following configuration & path**

•	TOOLCHAIN_PREFIX

•	link.ld

•	riscv_test.h

•	makehex.py


**Toolchain command**
riscv64-unknown-elf-gcc -mabi=ilp32 -march=rv32imc -o unit_test unit_test.S -static -mcmodel=medany -fvisibility=hidden -nostdlib -nostartfiles ........../riscv_test.h -T ........./link.ld –lgcc

•	riscv64-unknown-elf-objcopy -O elf32-littleriscv unit_test unit_test.elf
•	riscv64-unknown-elf-objcopy -O binary unit_test.elf unit_test.bin
•	python3 firmware/makehex.py unit_test.bin 32768 >unit_test.hex

**Simulation command:**

rm -rf verdi_config_file simv simv.daidir csrc ucli.key tb_top.trace vcdplus.vpd log tandem.log
vcs -full64 -sverilog -lca -debug_access+all -debug_access+class -kdb -ntb_opts uvm-1.2  +vpi -f file.flist
./simv +vpd +vcd +verbose -sv_lib ..../spike_install/lib/libriscv -sv_lib ..../spike_install/lib/libfesvr -sv_lib ..../spike_install/lib/libdisasm +trace +firmware=./test/unit_test.hex +permissive-off +elf_file=./test/unit_test > log


**Test input**
![image](https://github.com/user-attachments/assets/e0fd730f-ce37-4ee8-92db-7b12a68cd1c3)

**Logs: RTL, Spike**

![image](https://github.com/user-attachments/assets/be0fb5ee-666f-49c9-a65f-887a8afe8d1e)


**Logs: Scoreboard Comparison**

![image](https://github.com/user-attachments/assets/17bbaab1-ce80-41c4-b314-be57ac47d6dc)

 
**Future Work**

•	Synchronization of Core & Spike Comparison Parameters

•	To Analyze more on the output capture from Spike (to find out a better way !!)    

•	To add Control Mechanism for Core and Spike simulation using a single Config File.

•	Integrate RISCV-DV / Force generator to the UVM environment setup.

•	Driving Test scenarios from UVM sequence lib to make generic UVM Environment


