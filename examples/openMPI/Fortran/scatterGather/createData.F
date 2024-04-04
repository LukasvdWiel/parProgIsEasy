program createData

implicit none

integer, parameter :: n = 80
integer :: i

open(unit=42, file="inputData.txt")
do i=1,n
    write(42,*) sqrt(abs(sin(dble(i))))
enddo
close(42)

end program
