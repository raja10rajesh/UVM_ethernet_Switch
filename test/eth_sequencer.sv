class eth_sequencer extends uvm_sequencer#(eth_seq_item);
 
  `uvm_component_utils(eth_sequencer)
 
  //constructor
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction

  
endclass : eth_sequencer
