#include "counter8bit.h"
#include "TestbenchCounter.h"
#include "systemc.h"

SC_MODULE(CounterMain){
  	sc_clock clock;	//Declare the clock, named 'clock' (without constructor)
  	sc_signal<bool> reset, enable;	//Declare signals necessary for interconnecting 'reset', 'enable' of the testbench and counter8bit module
	sc_signal<sc_uint<8>> counter_out;	//Declare signal for connecting the 'counter_out' of counter8bit module

	counter8bit counter;	//Declare an instance of counter8bit, named 'counter' (without constructor)
	TestbenchCounter test1;	//Declare an instance of Testbench, named 'test1' (without constructor)
       
	//Notice how Modelsim expects the constructor of Top-level Module
	SC_CTOR(CounterMain): clock("SystemClock", 2, 0.5, true), counter("counter8bit"), test1("TestbenchCounter"){
		//Interconnect 'reset', 'enable', 'clock', 'counter_out' of 'counter' with the signals necessary
		counter.clock(clock);
		counter.reset(reset);
		counter.enable(enable);
		counter.counter_out(counter_out);
        
		//Interconnect 'reset', 'enable' of 'test1' with the signals necessary
		test1.reset(reset);
		test1.enable(enable);
	}
 };

//Notice this is most crucial part in making Top-Level Module of Modelsim
SC_MODULE_EXPORT(CounterMain);
