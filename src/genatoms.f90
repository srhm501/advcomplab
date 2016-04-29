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
  
  integer  :: intercase
  character(2) :: intertype(3,4,6)

  integer  :: purelines = 2
  integer  :: num_atm_interface

  integer  :: i, j, k
  real(dp) :: xc,yc,zc

  10 format (4x,a2,3(4x,f12.10))

  select case (intercase)
     case(1)
        intertype(:,:,:)  = 'Mg'
     case(2)
        intertype(1,:,:)  = 'Ca'
        intertype(2:,:,:) = 'Mg'
  end select

  axes(1) = axis(3, 1.0_dp)
  axes(2) = axis(4, 1.0_dp)
  axes(3) = axis(6, 1.0_dp)

  where (axes(:)%numatm /= 1) axes(:)%step = axes(:)%maxpos / (axes(:)%numatm-1)

  num_atm_interface = axes(1)%numatm*axes(2)%numatm*(axes(3)%numatm-(2*purelines))

  read *, Mgmax, Camax, intercase
  if (Mgmax + Camax /= num_atm_interface) &
       stop 'Mgmax + Camax must equal total number of atoms'

  call init_random_seed()

  xc = 0.0_dp
  yc = 0.0_dp
  zc = 0.0_dp

  do k=1,purelines
     do j=1,axes(2)%numatm
        do i=1,axes(1)%numatm
           write(*,10) 'Mg', xc, yc, zc
           xc = xc + axes(1)%step
        end do
        xc = 0.0_dp
        yc = yc + axes(2)%step
     end do
     yc = 0.0_dp
     zc = zc + axes(3)%step
  end do

  do k=1,axes(3)%numatm-2*purelines
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

  do k=1,purelines
     do j=1,axes(2)%numatm
        do i=1,axes(1)%numatm
           write(*,10) 'Ca', xc, yc, zc
           xc = xc + axes(1)%step
        end do
        xc = 0.0_dp
        yc = yc + axes(2)%step
     end do
     yc = 0.0_dp
     zc = zc + axes(3)%step
  end do

end program
