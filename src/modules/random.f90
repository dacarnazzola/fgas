module random
use, non_intrinsic :: kinds, only: i32, i64, dp
implicit none
private
public :: random_uniform_i32

contains

    impure subroutine random_uniform_i32(x, n, lo, hi)
        integer(kind=i32), intent(in) :: n, lo, hi
        integer(kind=i32), intent(inout) :: x(n)
        real(kind=dp) :: work(n), hi_lo
        call random_number(work)
        hi_lo = real(int(hi, kind=i64) - int(lo, kind=i64) + 1_i64, kind=dp)
        x = int(int(work*hi_lo, kind=i64) + int(lo, kind=i64), kind=i32)
    end subroutine random_uniform_i32

end module random
