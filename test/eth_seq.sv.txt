class eth_sequence extends uvm_sequence#(eth_seq_item);
`uvm_object_utils(eth_sequence)
   eth_seq_item txn;
  //Constructor
  function new(string name = "eth_sequence");
    super.new(name);
  endfunction : new
  
  //`uvm_declare_p_sequencer(eth_sequencer)
  
  task body();
    req = eth_seq_item::type_id::create(.name("req"),.contxt(get_full_name()));
    wait_for_grant();
    req.randomize();
    send_request(req);
    wait_for_item_done();
    finish_item(req);
  endtask
   
endclass : eth_sequence

class eth_seq_a extends eth_sequence;
`uvm_object_utils(eth_seq_a)
	function new(string name="");
		super.new(name);
	endfunction

	task body();
      	wait_for_grant();
		start_item(txn);
			assert(txn.randomize());
      	wait_for_item_done();
		finish_item(txn);
	endtask
endclass
