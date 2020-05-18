class eth_driver extends uvm_driver #(eth_seq_item);
 `uvm_component_utils(eth_driver)
  
	virtual eth_if vif; // Virtual Interface
  
  
  	function new (string name, uvm_component parent);
    	super.new(name, parent);   // Constructor
  	endfunction : new
 
      
  	
	function void build_phase(uvm_phase phase);
    	super.build_phase(phase);
      if(!uvm_config_db#(virtual eth_if)::get(this, "", "vif", vif))
       `uvm_fatal("NO_VIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
  	endfunction: build_phase
      
   
   
  	virtual task run_phase(uvm_phase phase);
    	forever begin
          seq_item_port.get_next_item(req);
          //respond_to_transfer(req);
    	drive();
    	seq_item_port.item_done();
    	end
  	endtask : run_phase
      
    
    virtual task drive(); // drive
    	req.print();
      	vif.inSopA <= 0;
      	vif.inEopA <= 0;
      
      	@(posedge vif.clk);
      	vif.inDataA <= req.inDataA;
      if(!req.portAStall) 
        begin
        	vif.inSopA <= req.inSopA;
            vif.inEopA <= req.inEopA;
        	vif.inDataA <= req.inDataA;
          $display("\tinSopA = %0h \tinEOPA = %0h\tinDataA= %0h",req.inSopA,req.inEopA,req.inDataA);
          	req.outDataA = vif.outDataA;
            req.outSopA = vif.outSopA;
            req.outEopA = vif.outEopA;
          $display("\toutSopA = %0h \toutEOPA = %0h\toutDataA= %0h",req.outSopA,req.outEopA,req.outDataA);
        	@(posedge vif.clk);
      	end
      if(!req.portBStall) 
        begin
        	vif.inSopB <= req.inSopB;
            vif.inEopB <= req.inEopB;
        	vif.inDataB <= req.inDataB;
        	@(posedge vif.clk);
       	 	req.outDataA = vif.outDataA;
            req.outSopA = vif.outSopA;
            req.outEopA = vif.outEopA;          
          $display("\toutSopB = %0h \toutEOPB = %0h\toutDataB= %0h",req.outSopB,req.outEopB,req.outDataB);
      	end
      		$display("-----------------------------------------");
  	endtask : drive
 
endclass : eth_driver
  
