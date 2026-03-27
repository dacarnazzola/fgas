program test_kinds
use, non_intrinsic :: kinds, only: stdin, stdout, stderr, i32, i64, sp, dp, bool, char
implicit none

   write(unit=stdout, fmt='(a,i0)') 'stdin  = ',stdin
   write(unit=stdout, fmt='(a,i0)') 'stdout = ',stdout
   write(unit=stdout, fmt='(a,i0)') 'stderr = ',stderr

   write(unit=stdout, fmt='(a,i0)') 'i32 = ',i32
   write(unit=stdout, fmt='(a,i0)') 'i64 = ',i64
   write(unit=stdout, fmt='(a,i0)') 'sp  = ',sp
   write(unit=stdout, fmt='(a,i0)') 'dp  = ',dp

   write(unit=stdout, fmt='(a,i0)') 'bool = ',bool
   write(unit=stdout, fmt='(a,i0)') 'char = ',char

end program test_kinds
