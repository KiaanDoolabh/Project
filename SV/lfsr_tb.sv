// testbench to prove maximal LFSR
module tb ();

   //logic variables to route input and output to DUT
   logic clk, reset;
   logic [7:0] grid_out;
   logic shift_seed;
   logic [63:0] lfsr_seed;

   //create file handles to write results to a file
   file outputfile;
   // instantiate device under test (small LFSR)
   lfsr dut(seed, clk, reset, shift_seed);

   //set up a clock signal
   always     
     begin
	clk = 1; #1; clk = 0; #1;
     end
   
   initial
     begin
	//set up output file
  outputfile = $fopen("results.txt", "w");

	//set up any book keeping variables you may want to use
      int iterations;
      iterations = 0;
      int repeat_iterations;
      repeat_iterations = 0;

	//set up a starting seed.  What happens with all 0s?
      reset = 1;
      lfsr_seed = 64'h0412_6424_0034_3C28;

	//reset your DUT
  #10 reset = 0;

	//save the initial output of your DUT to compare with current output
  logic [7:0] initial_output;
  initial_output = grid_out;
	//and see whenb you repeat
     end

   always @(posedge clk)
     begin
      iterations++;
		//output your results to a file
    $fdisplay(outputfile, "Iteration %0d: Grid Out = %b", iterations, grid_out);
     end

   // check results on falling edge of clk
   always @(negedge clk) begin
		if(~reset) begin
		//check if your output equals the initial output 
    if (iterations == (1 << 6))
    $fdisplay(outputfile, "Output never repeated for 2^n iterations.");
    $fdisplay(outputfile, "Total iterations: %0d", iterations);
    $fdisplay(outputfile, "Iterations to repeat: %0d", repeat_iterations);
    $fclose(outputfile);
    $finish;
		end
	end
   
endmodule // tb

