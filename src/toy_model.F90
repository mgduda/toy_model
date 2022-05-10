program toy_model

    use physics, only : phys_state_t, physics_init, physics_driver

    implicit none

    character(len=*), parameter :: version = '1.0'

    type (phys_state_t) :: pstate    ! Model state for physics
    integer :: istep                 ! Timestep


    write(0,*) '----- MMM Toy Model Version '//trim(version)//' -----'

    call physics_init()

    do istep = 1, 10
        call physics_driver(pstate)
    end do
     
    write(0,*) '----- model simulation completed! -----'

end program toy_model
