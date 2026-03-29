module random
use, non_intrinsic :: kinds, only: i32, dp
implicit none
private
public :: random_uniform_i32

contains

    impure subroutine random_uniform_i32(x, n, lo, hi)
        integer(kind=i32), intent(in) :: n, lo, hi
        integer(kind=i32), intent(inout) :: x(n)
        real(kind=dp) :: work
        integer(kind=i32) :: i
        do i=1_i32,n
            call random_number(work)
            x(i) = int(work*(hi - lo + 1_i32), kind=i32) + lo
        end do
    end subroutine random_uniform_i32

end module random
