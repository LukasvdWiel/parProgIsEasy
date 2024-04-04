all: clean inputData mpi

inputData:
	gfortran -std=f2008 -ffree-form -o createData createData.F
	chmod +x createData
	./createData


mpi:
	mpif90 -std=f2008 -ffree-form -o doMPI doMPI.F
	chmod +x doMPI
	mpirun -np 8 doMPI

clean:
	rm -f createData doMPI
	rm -f inputData.txt outputData.txt
