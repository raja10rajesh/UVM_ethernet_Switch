class eth_monitor extends uvm_monitor;
  `uvm_component_utils(eth_monitor)
 
  // Virtual Interface
  virtual eth_if vif;
 
  uvm_analysis_port #(eth_seq_item) item_collected_port;
 
  // Placeholder to capture transaction information.
  eth_seq_item trans_collected;
 
  
 
  // new - constructor
  function new (string name, uvm_component parent);
    super.new(name, parent);
    trans_collected = new();
    item_collected_port = new("item_collected_port", this);
  endfunction : new
  
  
 
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual eth_if)::get(this, "", "vif", vif))
       `uvm_fatal("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
  endfunction: build_phase
  
  
 
  // run phase
  virtual task run_phase(uvm_phase phase);
    forever begin
      @(posedge vif.clk);
        trans_collected.inDataA = vif.inDataA;
      	trans_collected.inDataB = vif.inDataB;
      
      	trans_collected.inSopA = vif.inSopA;
      	trans_collected.inSopB = vif.inSopB;
      
      	trans_collected.inEopA = vif.inEopA;
      	trans_collected.inEopB = vif.inEopB;
      
      	trans_collected.inDataB = vif.inDataB;
      	trans_collected.inDataB = vif.inDataB;
      
      	
      	trans_collected.inDataB = vif.inDataB;
      	trans_collected.inDataB = vif.inDataB;
      	
      
      
      item_collected_port.write(trans_collected);
    end
  endtask : run_phase
 
endclass : eth_monitor
