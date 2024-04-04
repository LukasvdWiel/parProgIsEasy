all: serial 

compile:
	mpif90 -std=f2008 -ffree-form -o sinloop -I/usr/lib/x86_64-linux-gnu/fortran/gfortran-mod-15/openmpi/ sinloop.F
	chmod +x sinloop

serial: compile
	time ./sinloop

parallel: compile
	time mpirun -np 8 ./sinloop
