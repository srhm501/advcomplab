module random
implicit none

integer, parameter :: dp = selected_real_kind(15,300)

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

end module random
