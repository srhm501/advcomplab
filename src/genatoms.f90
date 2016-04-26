program genatoms
  use random
  implicit none

  integer,  parameter :: side = 4
  integer,  parameter :: num_atoms = side**3
  real(dp), parameter :: maxpos = 0.5_dp

  real(dp) :: step = maxpos / (side-1)

  integer  :: i, j, k, l
  real(dp) :: xc,yc,zc
  character(2) :: atoms(num_atoms)

  10 format (4x,a2,3(4x,f12.10))

  call init_random_seed()

  l=0
  do i=1,num_atoms/side
     k = l*side
     if (mod(l,2)==0) then
        do j=1,side,2
           atoms(j+k) = rand_atom()
        end do
        do j=2,side,2
           atoms(j+k) = ' O'
        end do
     else
        do j=1,side,2
           atoms(j+k) = ' O'
        end do
        do j=2,side,2
           atoms(j+k) = rand_atom()
        end do
     end if
     l = l + 1
  end do

  l  = 1
  xc = 0.0_dp
  yc = 0.0_dp
  zc = 0.0_dp

  do k=1,side
     do j=1,side
        do i=1,side
           write(*,10) atoms(l), xc, yc, zc
           l = l + 1
           xc = xc + step
        end do
        xc = 0.0_dp
        yc = yc + step
     end do
     yc = 0.0_dp
     zc = zc + step
  end do

contains

  function rand_atom() result(atom)
    character(2) :: atom
    real(dp) :: r
  
     call random_number(r)

     if (r < 0.5_dp) then
        atom = 'Mg'
     else
        atom = 'Ca'
     end if
   end function rand_atom
end program
