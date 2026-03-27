module system
use, non_intrinsic :: kinds, only: char, bool
use, non_intrinsic :: constants, only: debug
implicit none
private
public :: debug_error_condition

    interface debug_error_condition
        module procedure :: debug_error_condition_default
        module procedure :: debug_error_condition_bool
    end interface debug_error_condition

contains

    pure elemental subroutine debug_error_condition_default(logical_expression, error_message)
        logical, intent(in) :: logical_expression
        character(len=*, kind=char), intent(in) :: error_message
        if (debug) then
            if (logical_expression) then
                error stop error_message
            end if
        end if
    end subroutine debug_error_condition_default

    pure elemental subroutine debug_error_condition_bool(logical_expression, error_message)
        logical(kind=bool), intent(in) :: logical_expression
        character(len=*, kind=char), intent(in) :: error_message
        if (debug) then
            if (logical_expression) then
                error stop error_message
            end if
        end if
    end subroutine debug_error_condition_bool

end module system
