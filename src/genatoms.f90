program genatoms
  use random
  implicit none

  integer,  parameter :: side = 2
  real(dp), parameter :: maxpos = 0.5_dp

  real(dp) :: step = maxpos / (side-1)

  integer  :: i, j, k
  real(dp) :: xc,yc,zc

  integer :: Mgmax, Camax

  10 format (4x,a2,3(4x,f12.10))

  read *, Mgmax, Camax

  call init_random_seed()

  xc = 0.0_dp
  yc = 0.0_dp
  zc = 0.0_dp

  do k=1,side
     do j=1,side
        do i=1,side
           write(*,10) rand_atom(), xc, yc, zc
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
    integer, save :: counterMg = 0
    integer, save :: counterCa = 0
  
     call random_number(r)

     if (r < 0.5_dp) then
        if (counterMg >= Mgmax) then
           atom = "Ca"
        else
           atom = "Mg"
           counterMg = counterMg + 1
        end if
     else
        if (counterCa >= Camax) then
           atom = "Mg"
        else
           atom = "Ca"
           counterCa = counterCa + 1
        end if
     end if
   end function rand_atom
end program
