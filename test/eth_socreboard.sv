class eth_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(eth_scoreboard)
  uvm_analysis_imp#(eth_seq_item, eth_scoreboard) item_collected_export;
 
  // new - constructor
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
 
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_collected_export = new("item_collected_export", this); //creating port
  endfunction: build_phase
   
   //calling write method from monitor
  //item_collected_port.write(pkt);
  
  
  // write
  virtual function void write(eth_seq_item pkt);
    $display("SCB:: Pkt recived");
    pkt.print();
  endfunction : write
 
  // run phase
  virtual task run_phase(uvm_phase phase);
    //--- comparision logic ---   
  endtask : run_phase
  
endclass : eth_scoreboard
