all: clean inputData mpi

inputData:
	gfortran -std=f2008 -ffree-form -o createData createData.F
	chmod +x createData
	./createData

mpi:
	mpirun -np 8 python3 doMPI.py

clean:
	rm -f createData
	rm -f inputData.txt outputData.txt
