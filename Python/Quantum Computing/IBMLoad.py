from qiskit import QuantumCircuit, execute, Aer, IBMQ
from qiskit.compiler import transpile, assemble
from qiskit.tools.jupyter import *
from qiskit.visualization import *

provider = IBMQ.load_account()

from qiskit.visualization import(
plot_state_city,
plot_bloch_multivector,
plot_state_paulivec,
plot_state_hinton,
plot_state_qsphere)
q = QuantumRegister(3);
bell = QuantumCircuit(q);
#for X: 0->1
bell.x(q[0])
backend = BasicAer.get_backend('statevector_simulator')
result = execute(bell,backend).result()
psi=result.get_statevector(bell)
#plot_bloch_multivector(psi)
plot_state_city(psi)