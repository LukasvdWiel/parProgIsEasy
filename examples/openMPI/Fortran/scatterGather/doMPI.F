program doMPI

use mpi

implicit none

integer :: iError
integer :: myProcID, nProcs
integer :: iRead, iWrite, iCompute
integer,parameter :: n = 80

double precision :: globalInput(n)
double precision :: globalOutput(n)

double precision :: localData(10)

call mpi_init(iError )
call mpi_comm_rank(MPI_COMM_WORLD, myProcID, iError)
call mpi_comm_size(MPI_COMM_WORLD, nProcs, iError)


!-----------------------------------------------------
! Thread 0 reads input to file
!-----------------------------------------------------

if (myProcID .eq. 0) then
    open(unit=43, file="inputData.txt")
    do iRead = 1,n
        read(43,*) globalInput(iRead)
    enddo
    close(43)
endif

!-----------------------------------------------------
! Scatter the data to the local arrays
!-----------------------------------------------------

call MPI_Scatter (globalInput, &       ! Scatter 10 doubles from the globalInput array...
                  10, &
                  MPI_double, &
                  localData, &         ! ...to the localData array.
                  10, &
                  MPI_double, &
                  0, &                 ! Thread 0 is the sender.
                  MPI_COMM_WORLD, &    ! All threads participate.
                  iError)

!-----------------------------------------------------
! Do some computation
!-----------------------------------------------------

do iCompute=1,10
    localData(iCompute) = 10 * localData(iCompute)
enddo

!-----------------------------------------------------
! Gather the data back to the global array
!-----------------------------------------------------


call MPI_Gather (localData, &       ! Gather 10 doubles from the localData array...
                 10, &
                 MPI_double, &
                 globalOutput, &    ! ...into the globalOutput array.
                 10, &
                 MPI_double, &
                 0, &               ! Thread 0 is the recipient.
                 MPI_COMM_WORLD, &  ! All threads participate.
                 iError)

!-----------------------------------------------------
! Thread 0 writes output to file
!-----------------------------------------------------


if (myProcID .eq. 0) then
    open(unit=44, file="outputData.txt")
    do iWrite = 1,n 
        write(44,*) globalOutput(iWrite)
    enddo
    close(43)
endif


call mpi_finalize(iError)


end program
