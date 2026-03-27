module kinds
use, intrinsic :: iso_fortran_env, only: input_unit, output_unit, error_unit
use, intrinsic :: iso_c_binding, only: c_int32_t, c_int64_t, c_float, c_double, c_bool, c_char
implicit none
private
public :: stdin, stdout, stderr, i32, i64, sp, dp, bool, char

    ! iso_fortran_env default unit numbers for system intput, output, and error
    integer, parameter :: stdin  = input_unit
    integer, parameter :: stdout = output_unit
    integer, parameter :: stderr = error_unit

    ! iso_c_binding Fortran kinds for 32-bit and 64-bit integer variables
    integer, parameter :: i32 = c_int32_t
    integer, parameter :: i64 = c_int64_t

    ! iso_c_binding Fortran kinds for 32-bit and 64-bit real variables
    integer, parameter :: sp = c_float
    integer, parameter :: dp = c_double

    ! iso_c_binding Fortran kinds for boolean and character variables
    integer, parameter :: bool = c_bool
    integer, parameter :: char = c_char

end module kinds
