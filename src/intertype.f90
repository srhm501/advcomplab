module interface_t

contains

function get_intertype(intercase) result(intertype)
  integer :: intercase
  character(2) :: intertype(3,3)
  integer :: i, j

  ! first initialise to pure MgO
  do j = 1,3
     do i = 1,3
        if (mod(i+j,2)==0) then
           intertype(i,j) = 'Mg'
        else
           intertype(i,j) = ' O'
        end if
     end do
  end do

  ! replace some Mg with Ca
  select case (intercase)     ! num Ca
  case (0)
     ! keep as pure MgO       ! 0
  case (1)
     intertype(1,1) = 'Ca'    ! 1
  case (2)
     intertype(1,1) = 'Ca'    ! 2
     intertype(1,3) = 'Ca'
  case (3)
     intertype(1,1) = 'Ca'    ! 3
     intertype(1,3) = 'Ca'
     intertype(3,1) = 'Ca'
  case (4)
     intertype(1,1) = 'Ca'    ! 4
     intertype(1,3) = 'Ca'
     intertype(3,1) = 'Ca'
     intertype(3,3) = 'Ca'
  case (5)
     intertype(1,1) = 'Ca'    ! 5
     intertype(1,3) = 'Ca'
     intertype(3,1) = 'Ca'
     intertype(3,3) = 'Ca'
     intertype(2,2) = 'Ca'
  case (6)
     intertype(1,1) = 'Ca'    ! 2
     intertype(2,2) = 'Ca'
  case (7)
     intertype(1,1) = 'Ca'    ! 2
     intertype(3,3) = 'Ca'
  case (7)
     intertype(1,1) = 'Ca'    ! 3
     intertype(2,2) = 'Ca'
     intertype(3,3) = 'Ca'
  case (8)
     intertype(1,1) = 'Ca'    ! 3
     intertype(1,3) = 'Ca'
     intertype(2,2) = 'Ca'
  case (9)
     intertype(1,1) = 'Ca'    ! 4
     intertype(1,3) = 'Ca'
     intertype(3,3) = 'Ca'
     intertype(2,2) = 'Ca'
case default
        stop "ERROR: interface type not valid"
  end select
end function get_intertype

end module interface_t

