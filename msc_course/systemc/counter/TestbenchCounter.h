#include "systemc.h"

SC_MODULE(TestbenchCounter){
	sc_out<bool> enable, reset;
	void testprocess(){
		enable.write(false);
		reset.write(false);
		wait(100, SC_NS);

		enable.write(false);
		reset.write(true);
		wait(100, SC_NS);

		enable.write(true);
		reset.write(false);
		wait(100, SC_NS);
		
		enable.write(true);
		reset.write(true);
		wait(100, SC_NS);
	}
	SC_CTOR(TestbenchCounter){
		SC_THREAD(testprocess);
	}
};