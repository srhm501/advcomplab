program genatoms
  use random
  implicit none

  integer,  parameter :: num_atoms = 8
  real(dp), parameter :: maxpos = 0.5_dp
  integer,  parameter :: side = nint(num_atoms**(1./3.))
  real(dp) :: step = maxpos / (side-1)

  real(dp) :: r
  integer  :: i, j, k, l
  real(dp) :: xc,yc,zc

<<<<<<< HEAD
  real(dp) :: positions_frac(3,num_atoms)
=======
  real(dp) :: positions_frac(3,num_atoms/2) = reshape((/ &
       0.0_dp, 0.0_dp, 0.0_dp, &
       0.0_dp, 1.0_dp, 1.0_dp, &
       1.0_dp, 0.0_dp, 1.0_dp, &
       1.0_dp, 1.0_dp, 0.0_dp  &
       /), shape(positions_frac))
>>>>>>> 3c12fc1219b5913b2b69cfcc513b8f2f9a520bad

  10 format (4x,a2,3(4x,f12.10))

  l = 0
  xc = 0.0_dp
  yc = 0.0_dp
  zc = 0.0_dp

  ! populate positions_frac
  do k=1,side
     do j=1,side
        do i=1,side
           positions_frac(:,l) = (/ xc, yc, zc /)
           xc = xc + step
           l = l + 1
        end do
        xc = 0.0_dp
        yc = yc + step
     end do
     yc = 0.0_dp
     zc = zc + step
  end do

  call init_random_seed()

  do i=1,num_atoms
     !if (mod(i,2)==0) then
     !   write(*,10) ' O', positions_frac(:,i)
     !   cycle
     !end if

     call random_number(r)

     if (r < 1.0_dp/3.0_dp) then
        write(*,10) 'Mg', positions_frac(:,i)
     else if (r < 2.0_dp/3.0_dp) then
        write(*,10) 'Ca', positions_frac(:,i)
     else
        write(*,10) ' O', positions_frac(:,i)
     end if
  end do
end program
