module isotope_data
  implicit none

  integer, parameter :: max_decay_modes = 3
  integer, parameter :: max_isotopes = 100
  integer :: isotope_count = 0

  type :: decay_mode_type
    character(len=10) :: mode        ! e.g., "b", "np"
    character(len=10) :: daughter    ! e.g., "239Pu"
    real :: branching_ratio
  end type decay_mode_type

  type :: isotope
    integer :: Z
    integer :: A
    character(len=10) :: name
    real(8) :: half_life
    real(8) :: decay_constant
    real(8) :: capture_cross_section
    real(8) :: fission_cross_section
    real(8) :: fission_yield
    real(8) :: atomic_mass
    integer :: n_decay_modes
    type(decay_mode_type), dimension(max_decay_modes) :: decay_modes
  end type isotope

  !type(isotope), dimension(max_isotopes) :: isotope_list
  type(isotope), dimension(max_isotopes) :: isotope_list

contains

  subroutine add_isotope(Z, A, name, hl, sig_c, sig_f, fy, mass, decay_data, n_decay)
    integer, intent(in) :: Z, A, n_decay
    character(len=*), intent(in) :: name
    real(8), intent(in) :: hl, sig_c, sig_f, fy, mass
    type(decay_mode_type), dimension(:), intent(in) :: decay_data

    if (isotope_count >= max_isotopes) then
      print *, "ERROR: Max number of isotopes exceeded"
      stop
    end if

    isotope_count = isotope_count + 1

    isotope_list(isotope_count)%Z = Z
    isotope_list(isotope_count)%A = A
    isotope_list(isotope_count)%name = name
    isotope_list(isotope_count)%half_life = hl
    isotope_list(isotope_count)%decay_constant = log(2.0d0) / hl
    isotope_list(isotope_count)%capture_cross_section = sig_c
    isotope_list(isotope_count)%fission_cross_section = sig_f
    isotope_list(isotope_count)%fission_yield = fy
    isotope_list(isotope_count)%atomic_mass = mass
    isotope_list(isotope_count)%n_decay_modes = n_decay

    if (n_decay > 0) then
      isotope_list(isotope_count)%decay_modes(1:n_decay) = decay_data(1:n_decay)
    end if
  end subroutine add_isotope

end module isotope_data
