subroutine load_isotopes
  use isotope_data
  implicit none

  character(len=200) :: line
  integer :: ios, i
  character(len=100) :: fname
  character(len=10) :: decay_mode_str, decay_daughter_str
  real :: decay_ratio
  integer :: Z, A, n_decay
  character(len=10) :: name
  real(8) :: hl, sig_c, sig_f, fy, mass
  type(decay_mode_type) :: decay_array(max_decay_modes)

  fname = "isotopes.csv"
  open(unit=10, file=fname, status="old", action="read", iostat=ios)
  if (ios /= 0) then
    print *, "ERROR: Cannot open file: ", fname
    stop
  end if

  ! Skip header
  read(10, *)

  do
    read(10, '(A)', iostat=ios) line
    if (ios /= 0) exit

    read(line, *) Z, A, name, hl, sig_c, sig_f, fy, mass, n_decay

    do i = 1, n_decay
      read(10, *) decay_mode_str, decay_daughter_str, decay_ratio
      decay_array(i)%mode = decay_mode_str
      decay_array(i)%daughter = decay_daughter_str
      decay_array(i)%branching_ratio = decay_ratio
    end do

    call add_isotope(Z, A, name, hl, sig_c, sig_f, fy, mass, decay_array, n_decay)
  end do

  close(10)

  print *, "Loaded ", isotope_count, " isotopes."
  do i = 1, isotope_count
    print *, isotope_list(i)%name, " --> Half-life: ", isotope_list(i)%half_life, " s"
  end do
end subroutine load_isotopes
