program genatoms
  use random
  implicit none

  integer, parameter :: num_atoms = 8

  real(dp) :: r
  integer  :: i

  real(dp) :: positions_frac(3,num_atoms/2) = reshape((/ &
       0.0_dp, 0.0_dp, 0.0_dp, &
       0.0_dp, 1.0_dp, 1.0_dp, &
       1.0_dp, 0.0_dp, 1.0_dp, &
       1.0_dp, 1.0_dp, 0.0_dp  &
       /), shape(positions_frac))

  10 format (4x,a2,3(4x,f12.10))

  call init_random_seed()

  ! half the atoms are O
  do i=1,num_atoms/2
     call random_number(r)

     if (r < 0.5_dp) then
        write(*,10) 'Mg', positions_frac(:,i)
     else
        write(*,10) 'Ca', positions_frac(:,i)
     end if
  end do
end program
