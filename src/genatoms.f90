program genatoms
  implicit none
  
  integer, parameter :: dp = selected_real_kind(15,300)

  ! atoms per side of cube cell
  ! keep as 3 for now
  integer,  parameter :: N = 3

<<<<<<< HEAD
  ! distance between atoms
  real(dp), parameter :: step = 1.0_dp/N

  type atom
     character(2) :: atom_type = "XX"
     real(dp)     :: coord(3)  = [0.0_dp, 0.0_dp, 0.0_dp]
  end type atom
=======
  type(axis) :: axes(3)
  
  integer  :: intercase
  character(2) :: intertype(2,4,2)
  integer  :: purelines = 2
  integer  :: i, j, k
  real(dp) :: xc,yc,zc
>>>>>>> a6f4a8471331ab9e5157518026ccb8a7980b6132

  type (atom) :: lattice(N**3)

  integer  :: i, j, k, l
  real(dp) :: xc,yc,zc

<<<<<<< HEAD

  character(1) :: iface
  character(2) :: middle(4) = "Mg"

  call get_command_argument(1,iface)
=======
  where (axes(:)%numatm /= 1) axes(:)%step = axes(:)%maxpos / (axes(:)%numatm-1)
>>>>>>> a6f4a8471331ab9e5157518026ccb8a7980b6132

  ! create coordinates
  xc = 0.0_dp
  yc = 0.0_dp
  zc = 0.0_dp
<<<<<<< HEAD
  l = 1
  do k=1,N
     zc = zc + (k-1)*step
     do j=1,N
        yc = yc + (j-1)*step
        do i=1,N
           xc = xc + (i-1)*step
           lattice(l)%coord = [ xc, yc, zc ]
           l = l + 1
=======

  ! upper layer (all Mg)
  do k=1,purelines
     do j=1,axes(2)%numatm
        do i=1,axes(1)%numatm
!	   if((mod(k,2)==0).and.(mod(j,2)==0)) then
	   if(mod(k+j+i,2)==0) then
               write(*,10) 'Mg', xc, yc, zc
	   else
	       write(*,10) 'O', xc, yc, zc
 	   end if
           xc = xc + axes(1)%step
>>>>>>> a6f4a8471331ab9e5157518026ccb8a7980b6132
        end do
        xc = 0.0_dp
     end do
     yc = 0.0_dp
  end do

<<<<<<< HEAD
  ! middle layer (interface)
  do k=1,axes(3)%numatm-2*purelines
     do j=1,axes(2)%numatm
        do i=1,axes(1)%numatm
	   if(mod(k+j+i,2)==0) then
               write(*,10) intertype(i,j,k), xc, yc, zc
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
=======
  ! create pure top and bottom layers and init middle
  lattice(01:09)%atom_type = gen_layer(0,"Mg")
  lattice(10:18)%atom_type = gen_layer(1,"Mg")
  lattice(19:27)%atom_type = gen_layer(0,"Ca")

  select case (iface)
  case ('0')
  case ('1')
     middle(1) = "Ca"
  case ('2')
     middle(1:2) = "Ca"
  case ('3')
     middle(1:3) = "Ca"
  case ('4')
     middle(:) = "Ca"
  case ('5')
     middle(1) = "Ca"
     middle(3) = "Ca"
  case default
     stop "iface not valid"
  end select

  j = 1
  do i=10,18
     if (lattice(i)%atom_type /= " O") then
        lattice(i)%atom_type = middle(j)
        j = j + 1
     end if
  end do
  
  do i=1,N**3
     write(*,'(a2,3(1x,f4.2))') lattice(i)
>>>>>>> c89e95c8239fe25abe655cad8f198ed517c775c5
  end do

contains
  function gen_layer(offset,atm) result(layer)
    integer      :: offset
    character(2) :: atm
    character(2) :: layer(9)
    integer      :: i
    do i=1,9
       if (mod(i+offset,2)/=0) then
          layer(i) = atm
       else
          layer(i) = " O"
       end if
    end do
  end function gen_layer
end program
