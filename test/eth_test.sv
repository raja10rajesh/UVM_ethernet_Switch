class eth_model_test extends uvm_test;
 
  `uvm_component_utils(eth_model_test)
 
  // environment and sequence instance
  eth_model_env env;
  eth_sequence  seq;
  
  
   	// new - constructor
  function new(string name = "eth_model_test",uvm_component parent=null);
    super.new(name,parent);
  endfunction : new
  
		 //build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = eth_model_env::type_id::create("env", this);
    seq = eth_sequence::type_id::create("seq");
  endfunction : build_phase
  
  //function void end_of_elobartion_phase(uvm_phase phase);
	//	factory.print();
	//endfunction
 
  		//run-phase
  task run_phase(uvm_phase phase);
    eth_seq_a seq_a;
    phase.raise_objection(this);
    seq.start(env.eth_agnt.sequencer);
    phase.drop_objection(this);
  endtask : run_phase
 
endclass : eth_model_test
