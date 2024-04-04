program sinloop

use mpi

implicit none

integer, parameter :: n=800

integer          :: i,j, iError
double precision :: a(n)

integer          :: nProcs
integer          :: myProcID
integer          :: firstidx, lastidx

call MPI_Init(iError)
call MPI_Comm_size(MPI_COMM_WORLD, nProcs, iError)
call MPI_Comm_rank(MPI_COMM_WORLD, myProcID, iError)

firstidx = myProcID * 100 + 1
lastidx  = (myProcID+1) * 100

write(*,*) "thread", myProcID, "runs from", firstidx, "to", lastidx

do i = firstidx, lastidx
    a(i) = dble(i)
	call doIndependentWork(a(i))
enddo

call mpi_finalize(iError)

end program



subroutine doIndependentWork(x)

integer :: i
double precision :: x

do i=1,1000000
    x = sin(x)
enddo

end subroutine
