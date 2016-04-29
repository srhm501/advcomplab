module interface_t

contains

function get_intertype(intercase) result(intertype)
  integer :: intercase

  character(2) :: intertype(2,4,2)

  intertype(:,:,:) = 'Mg'

  ! generate the interface between Mg and Ca layers
  select case (intercase)
     case(1)
     case(2)
        intertype(1,1,2)  = 'Ca'
     case(3)
        intertype(:,1,2) = 'Ca'
     case(4)
        intertype(1,1:2,2) = 'Ca'
     case(5)
        intertype(1,1:3,2) = 'Ca'
     case(6)
        intertype(1,:,2) = 'Ca'
     case(7)
        intertype(1,:,2) = 'Ca'
        intertype(2,1,2)   = 'Ca'
     case(8)
        intertype(1,:,2) = 'Ca'
        intertype(2,1:2,2) = 'Ca'
     case(9)
        intertype(1,:,2) = 'Ca'
        intertype(2,1:3,2) = 'Ca'
     case(10)
        intertype(:,:,2) = 'Ca'
     case(11)
        intertype(:,:,2) = 'Ca'
        intertype(1,1,1) = 'Ca'
     case(12)
        intertype(:,:,2) = 'Ca'
        intertype(1,1:2,1) = 'Ca'
     case(13)
        intertype(:,:,2) = 'Ca'
        intertype(1,1:3,1) = 'Ca'
     case(14)
        intertype(:,:,2) = 'Ca'
        intertype(1,:,1) = 'Ca'
     case(15)
        intertype(1,1,2) = 'Ca'
        intertype(1,3,2) = 'Ca'
     case(16)
        intertype(:,1,2) = 'Ca'
        intertype(:,3,2) = 'Ca'
     case(17)
        intertype(1,1,2) = 'Ca'
        intertype(1,3,2) = 'Ca'
        intertype(2,2,2) = 'Ca'
        intertype(2,4,2) = 'Ca'
     case(18)
        intertype(1,1,:) = 'Ca'
        intertype(1,3,:) = 'Ca'
        intertype(2,2,:) = 'Ca'
        intertype(2,4,:) = 'Ca'
     case default
        stop "ERROR: interface type not valid"
  end select
end function get_intertype

end module interface_t
