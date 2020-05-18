`include "uvm_pkg.sv"
  import uvm_pkg::*;
`include "eth_intf.sv"
`include "eth_seq_tx.sv"
`include "eth_seq.sv"
`include "eth_sequencer.sv"
`include "eth_driver.sv"
`include "eth_monitor.sv"
`include "eth_agent.sv"
`include "eth_scoreboard.sv"
`include "eth_environment.sv"
`include "eth_test.sv"

`include "eth_sw2x2.v"

module eth_tbench_top;
   
  //creatinng instance of interface, inorder to connect DUT and testcase
  eth_if intf();
   
  //DUT instance, interface signals are connected to the DUT ports
  eth_sw2x2 DUT( 
    			.clk(intf.clk),
    			.reset_n(intf.reset_n),
                .inDataA(intf.inDataA),
                .inSopA(intf.inSopA),
    			.inEopA(intf.inEopA),
                .inDataB(intf.inDataB),
                .inSopB(intf.inSopB),
                .inEopB(intf.inEopB),
                .outDataA(intf.outDataA),
                .outSopA(intf.outSopA),
                .outEopA(intf.outEopA),
                .outDataB(intf.outDataB),
                .outSopB(intf.outSopB),
                .outEopB(intf.outEopB),
                .portAStall(intf.portAStall),
                .portBStall(intf.portBStall)
  );
  
  
  initial begin
		//Registers the Interface in the configuration block so that other
		//blocks can use it
    uvm_resource_db#(virtual eth_if)::set(.scope("ifs"),.name("eth_if"),.val(intf));
		
		run_test();//Executes the test
	end
   
  
  initial begin //enabling the wave dump
    uvm_config_db#(virtual eth_if)::set(uvm_root::get(),"*","vif",intf);
    $dumpfile("dump.vcd"); $dumpvars;
  end
  
initial begin
		intf.clk <= 1'b1;
	end

	//Clock generation
	always
		#5 intf.clk = ~intf.clk;
  
endmodule
