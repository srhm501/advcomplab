program genatoms
  implicit none
  
  integer, parameter :: dp = selected_real_kind(15,300)

  ! atoms per side of cube cell
  ! keep as 3 for now
  integer,  parameter :: N = 3

  ! distance between atoms
  real(dp), parameter :: step = 1.0_dp/N

  type atom
     character(2) :: atom_type = "XX"
     real(dp)     :: coord(3)  = [0.0_dp, 0.0_dp, 0.0_dp]
  end type atom

  type (atom) :: lattice(N**3)

  integer  :: i, j, k, l
  real(dp) :: xc,yc,zc

  character(1) :: iface
  character(2) :: middle(4) = "Mg"

  call get_command_argument(1,iface)

  ! create coordinates
  xc = 0.0_dp
  yc = 0.0_dp
  zc = 0.0_dp

  l = 1
  do k=1,N
     zc = zc + (k-1)*step
     do j=1,N
        yc = yc + (j-1)*step
        do i=1,N
           xc = xc + (i-1)*step
           lattice(l)%coord = [ xc, yc, zc ]
           l = l + 1
        end do
        xc = 0.0_dp
     end do
     yc = 0.0_dp
  end do

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
