program genatoms
  use random
  implicit none

  integer, parameter :: num_atoms = 24

  real(dp) :: r
  integer  :: i

  call init_random_seed()

  ! half the atoms are O
  do i=1,num_atoms/2
     call random_number(r)

     if (r < 0.5_dp) then
        print *, 'Mg'
     else
        print *, 'Ca'
     end if
  end do
end program
