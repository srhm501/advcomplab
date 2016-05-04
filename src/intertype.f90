module interface_t

contains

function get_intertype(intercase) result(intertype)
  integer :: intercase
  character(2) :: intertype(3,3)
  integer :: i, j

  do j = 1,3
     do i = 1,3
        if (mod(i+j,2)==0) then
           intertype(i,j) = 'Mg'
        else
           intertype(i,j) = ' O'
        end if
     end do
  end do

  ! generate the interface between Mg and Ca layers
  select case (intercase)
  case (0)
  case (1)
     intertype(1,1) = 'Ca'
  case (2)
     intertype(1,1) = 'Ca'
     intertype(1,3) = 'Ca'
  case (3)
     intertype(1,1) = 'Ca'
     intertype(1,3) = 'Ca'
     intertype(3,1) = 'Ca'
  case (4)
     intertype(1,1) = 'Ca'
     intertype(1,3) = 'Ca'
     intertype(3,1) = 'Ca'
     intertype(3,3) = 'Ca'
  case (5)
     intertype(1,1) = 'Ca'
     intertype(3,3) = 'Ca'
case default
        stop "ERROR: interface type not valid"
  end select
end function get_intertype

end module interface_t

