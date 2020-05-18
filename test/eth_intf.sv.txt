interface eth_if();
  
	logic  			clk;
	logic  			reset_n;
	logic [31:0] 	        inDataA;
	logic  			inSopA;
	logic  			inEopA;
  	logic  [31:0] 	        inDataB;
	logic  			inSopB;
	logic  			inEopB;
        logic  [31:0] 	        outDataA; 
	logic  			outSopA;
	logic  			outEopA; 
        logic  [31:0]  	        outDataB; 
	logic  			outSopB;
	logic  			outEopB;
	logic  			portAStall;
	logic  			portBStall;
  	
endinterface: eth_if
