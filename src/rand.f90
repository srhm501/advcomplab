module random
implicit none

public
integer, parameter :: dp = selected_real_kind(15,300)
integer :: Mgmax, Camax

contains

  subroutine init_random_seed()
    implicit none
    integer, allocatable :: seed(:)
    integer :: n, un
    call random_seed(size=n)
    allocate(seed(n))

    open(newunit=un, file="/dev/urandom", access="stream", &
         & form="unformatted", action="read", status="old")
    read(un) seed
    close(un)

    call random_seed(put=seed)
  end subroutine init_random_seed

  function rand_atom() result(atom)
    character(2)  :: atom
    real(dp)      :: r
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

end module random
