program genatoms
  use interface_t
  implicit none
  
  integer, parameter :: dp = selected_real_kind(15,300)

  type axis
     ! number of atoms along axis
     integer  :: numatm=3
     
     ! maximum position of atom along axis
     real(dp) :: maxpos=0.67_dp
     
     ! distance between atoms along axis
     ! doesn't matter what the default is, as long as there is one
     real(dp) :: step=0.0_dp
  end type axis

  type(axis) :: axes(3)
  
  integer  :: intercase
  character(2) :: intertype(3,3)
  integer  :: purelines = 1
  integer  :: i, j, k
  real(dp) :: xc,yc,zc

  10 format (4x,a2,3(4x,f12.10))

  read *, intercase
  intertype = get_intertype(intercase)

  axes(:) = axis()

  where (axes(:)%numatm /= 1) axes(:)%step = axes(:)%maxpos / (axes(:)%numatm-1)

  xc = 0.0_dp
  yc = 0.0_dp
  zc = 0.0_dp

  ! upper layer (all Mg)
  do k=1,purelines
     do j=1,axes(2)%numatm
        do i=1,axes(1)%numatm
           if(mod(k+j+i,2)==0) then
              write(*,10) 'Mg', xc, yc, zc
           else
              write(*,10) 'O', xc, yc, zc
           end if
           xc = xc + axes(1)%step
        end do
        xc = 0.0_dp
        yc = yc + axes(2)%step
     end do
     yc = 0.0_dp
     zc = zc + axes(3)%step
  end do

  ! middle layer (interface)
  do k=1,axes(3)%numatm-2*purelines
     do j=1,axes(2)%numatm
        do i=1,axes(1)%numatm
               write(*,10) intertype(i,j), xc, yc, zc
           xc = xc + axes(1)%step
        end do
        xc = 0.0_dp
        yc = yc + axes(2)%step
     end do
     yc = 0.0_dp
     zc = zc + axes(3)%step
  end do

  ! bottom layer (all Ca)
  do k=1,purelines
     do j=1,axes(2)%numatm
        do i=1,axes(1)%numatm
           if(mod(k+j+i,2)==0) then
               write(*,10) 'Ca', xc, yc, zc
            else
               write(*,10) 'O', xc, yc, zc
            end if
           xc = xc + axes(1)%step
        end do
        xc = 0.0_dp
        yc = yc + axes(2)%step
     end do
     yc = 0.0_dp
     zc = zc + axes(3)%step
  end do

end program

