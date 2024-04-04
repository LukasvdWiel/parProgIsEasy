from mpi4py import MPI
import numpy

n = 80

globalInput = numpy.zeros(80)
globalOutput = numpy.zeros(80)

localData = numpy.zeros(10)

size = MPI.COMM_WORLD.Get_size()
rank = MPI.COMM_WORLD.Get_rank()

#-----------------------------------------------------
# Thread 0 reads input to file
#-----------------------------------------------------

if rank == 0:
	globalInput = numpy.loadtxt("inputData.txt")

#-----------------------------------------------------
# Scatter the data to the local arrays
#-----------------------------------------------------

MPI.COMM_WORLD.Scatter(globalInput, localData, root=0)

#-----------------------------------------------------
# Do some computation
#-----------------------------------------------------

localData = 10 * localData

#-----------------------------------------------------
# Gather the data back to the global array
#-----------------------------------------------------

MPI.COMM_WORLD.Gather(localData, globalOutput, root=0)

#-----------------------------------------------------
# Thread 0 writes output to file
#-----------------------------------------------------

if rank == 0:
    numpy.savetxt("outputData.txt", globalOutput)

