program genatoms
  use random
  implicit none

  type axis
     ! number of atoms along axis
     integer  :: numatm
     
     ! maximum position of atom along axis
     real(dp) :: maxpos
     
     ! distance between atoms along axis
     ! doesn't matter what the default is, as long as there is one
     real(dp) :: step=0.0_dp
  end type axis

  type (axis) :: axes(3)

  integer  :: i, j, k
  real(dp) :: xc,yc,zc
  
  ! maximum amount of Mg and Ca
  integer :: Mgmax, Camax

  10 format (4x,a2,3(4x,f12.10))

  axes(1) = axis(2, 1.0_dp)
  axes(2) = axis(2, 1.0_dp)
  axes(3) = axis(1, 0.5_dp)

  do i=1,3
     if (axes(i)%numatm /= 1) then
        axes(i)%step = axes(i)%maxpos / (axes(i)%numatm-1)
     end if
  end do
  
  read *, Mgmax, Camax
  if (Mgmax + Camax /= (axes(1)%numatm * &
                        axes(2)%numatm * &
                        axes(3)%numatm)) stop 'Mgmax + Camax must equal total number of atoms'

  call init_random_seed()

  xc = 0.0_dp
  yc = 0.0_dp
  zc = 0.0_dp

  do k=1,axes(3)%numatm
     do j=1,axes(2)%numatm
        do i=1,axes(1)%numatm
           write(*,10) rand_atom(), xc, yc, zc
           xc = xc + axes(1)%step
        end do
        xc = 0.0_dp
        yc = yc + axes(2)%step
     end do
     yc = 0.0_dp
     zc = zc + axes(3)%step
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
