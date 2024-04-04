all: serial parallel

serial:
	gfortran -std=f2008 -ffree-form -o sinloop sinloop.F
	chmod +x sinloop
	time ./sinloop

parallel:
	gfortran -fopenmp -std=f2008 -ffree-form -o sinloop sinloop.F
	chmod +x sinloop
	time ./sinloop
