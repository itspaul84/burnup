subroutine load_isotopes_from_file(filename)
  use isotope_data
  implicit none

  character(len=*), intent(in) :: filename
  character(len=200) :: line
  integer :: ios, i
  character(len=10) :: decay_mode_str, decay_daughter_str
  real :: decay_ratio
  integer :: Z, A, n_decay
  character(len=10) :: name
  real(8) :: hl, sig_c, sig_f, fy, mass
  type(decay_mode_type) :: decay_array(max_decay_modes)

  open(unit=10, file=filename, status="old", action="read", iostat=ios)
  if (ios /= 0) then
    print *, "ERROR: Cannot open file: ", filename
    stop
  end if

  read(10, *) ! skip header

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
end subroutine load_isotopes_from_file

