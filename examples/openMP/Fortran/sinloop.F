program sinloop

use omp_lib

implicit none

integer, parameter :: n=800

integer          :: i,j
double precision :: a(n)

!$omp parallel do
do i = 1, n
	a(i) = dble(i)
	call doIndependentWork(a(i))
enddo
!$omp end parallel do

end program

subroutine doIndependentWork(x)

integer :: i
double precision :: x

do i=1,1000000
    x = sin(x)
enddo

end subroutine
