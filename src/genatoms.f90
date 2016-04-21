program genatoms
  use random
  implicit none

  integer, parameter :: num_atoms = 8

  real(dp) :: r
  integer  :: i

  real(dp) :: coords(3,num_atoms/2) = reshape((/ &
       0.0_dp, 0.0_dp, 0.0_dp, &
       0.0_dp, 0.5_dp, 0.5_dp, &
       0.5_dp, 0.0_dp, 0.5_dp, &
       0.5_dp, 0.5_dp, 0.0_dp  &
       /), shape(coords))

  10 format (a,3(x,f17.15))

  call init_random_seed()

  ! half the atoms are O
  do i=1,num_atoms/2
     call random_number(r)

     if (r < 0.5_dp) then
        write(*,10) 'Mg', coords(:,i)
     else
        write(*,10) 'Ca', coords(:,i)
     end if
  end do
end program
