module constants
use, non_intrinsic :: kinds, only: sp, dp, bool
implicit none
private
public :: pi_sp, pi_dp, twopi_sp, twopi_dp
public :: debug

#ifdef __COMPILE_FOR_DEBUG__
    logical(kind=bool), parameter :: debug = .true.
#else
    logical(kind=bool), parameter :: debug = .false.
#endif

    real(kind=sp), parameter :: pi_sp = real(acos(-1.0_dp), kind=sp)
    real(kind=sp), parameter :: twopi_sp = real(2.0_dp*acos(-1.0_dp), kind=sp)
    real(kind=dp), parameter :: pi_dp = acos(-1.0_dp)
    real(kind=dp), parameter :: twopi_dp = 2.0_dp*acos(-1.0_dp)

end module constants
