program genatoms
  use random
  implicit none

  ! number of atoms on each side of cube
  integer, parameter :: sidex = 4
  integer, parameter :: sidey = 4
  integer, parameter :: sidez = 2

  ! max 'coord' along each axis
  real(dp), parameter :: maxposx = 1.0_dp
  real(dp), parameter :: maxposy = 1.0_dp
  real(dp), parameter :: maxposz = 0.5_dp

  ! distance between each atom along the axis directions
  real(dp), parameter :: stepx = maxposx / (sidex-1)
  real(dp), parameter :: stepy = maxposy / (sidey-1)
  real(dp), parameter :: stepz = maxposz / (sidez-1)

  integer  :: i, j, k
  real(dp) :: xc,yc,zc
  
  ! maximum amount of Mg and Ca
  integer :: Mgmax, Camax

  10 format (4x,a2,3(4x,f12.10))

  read *, Mgmax, Camax
  if (Mgmax + Camax /= sidex*sidey*sidez) stop 'Mgmax + Camax must equal side'

  call init_random_seed()

  xc = 0.0_dp
  yc = 0.0_dp
  zc = 0.0_dp

  do k=1,sidez
     do j=1,sidey
        do i=1,sidex
           write(*,10) rand_atom(), xc, yc, zc
           xc = xc + stepx
        end do
        xc = 0.0_dp
        yc = yc + stepy
     end do
     yc = 0.0_dp
     zc = zc + stepz
  end do

contains

  function rand_atom() result(atom)
    character(2) :: atom
    real(dp) :: r
    integer, save :: counterMg = 0
    integer, save :: counterCa = 0
  
    call random_number(r)

    if (counterMg >= Mgmax) then
       atom = 'Ca'
       return
    else if (counterCa >= Camax) then
       atom = 'Mg'
       return
    end if

    if (r < 0.5_dp) then
       atom = 'Mg'
       counterMg = counterMg + 1
    else
       atom = 'Ca'
       counterCa = counterCa + 1
    end if

   end function rand_atom
end program
