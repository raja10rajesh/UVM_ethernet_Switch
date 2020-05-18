class eth_seq_item extends uvm_sequence_item;
  
  
  //data and control ports
  rand bit	[31:0]  	inDataA;
  rand bit  			inSopA;
  rand bit  			inEopA;
  rand bit	[31:0]  	inDataB;
  rand bit  			inSopB;
  rand bit  			inEopB;
  rand bit	[31:0]  	outDataA; 
  rand bit  			outSopA;
  rand bit  			outEopA; 
  rand bit	[31:0]  	outDataB; 
  rand bit  			outSopB;
  rand bit  			outEopB;
  rand bit  			portAStall;
  rand bit  			portBStall;
  
  //Utility and Field macros,
  `uvm_object_utils_begin(eth_seq_item)
  	`uvm_field_int(inDataA,UVM_ALL_ON)
    `uvm_field_int(inSopA,UVM_ALL_ON)
  	`uvm_field_int(inEopA,UVM_ALL_ON)
  	`uvm_field_int(inDataB,UVM_ALL_ON)
  	`uvm_field_int(inSopB,UVM_ALL_ON)
  	`uvm_field_int(inEopB,UVM_ALL_ON)
  	`uvm_field_int(outDataA,UVM_ALL_ON)
  	`uvm_field_int(outSopA,UVM_ALL_ON)
  	`uvm_field_int(outEopA,UVM_ALL_ON)
  	`uvm_field_int(outDataB,UVM_ALL_ON)
  	`uvm_field_int(outSopB,UVM_ALL_ON)
    `uvm_field_int(outEopB,UVM_ALL_ON)
    `uvm_field_int(portAStall,UVM_ALL_ON)
  	`uvm_field_int(portBStall,UVM_ALL_ON)
  `uvm_object_utils_end
  
  
  function new(string name="eth_seq_item");
    super.new(name);
  endfunction
  
  
endclass:eth_seq_item
