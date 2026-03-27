module constants
use, non_intrinsic :: kinds, only: bool
implicit none
private
public :: debug

#ifdef __COMPILE_FOR_DEBUG__
    logical(kind=bool), parameter :: debug = .true.
#else
    logical(kind=bool), parameter :: debug = .false.
#endif

end module constants
