program genatoms
  use random, only : dp, Mgmax, Camax, init_random_seed, rand_atom
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

  type(axis) :: axes(3)

  integer  :: i, j, k
  real(dp) :: xc,yc,zc

  10 format (4x,a2,3(4x,f12.10))

  axes(:) = axis(2, 0.5_dp)

  where (axes(:)%numatm /= 1) axes(:)%step = axes(:)%maxpos / (axes(:)%numatm-1)

  read *, Mgmax, Camax
  if (Mgmax + Camax /= product(axes(:)%numatm)) &
       stop 'Mgmax + Camax must equal total number of atoms'

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

end program
