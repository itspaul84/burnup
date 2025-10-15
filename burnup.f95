program burnup

    use isotope_data
    implicit none

    call load_isotopes_from_file("isotopes.csv")

    print *, "Loaded ", isotope_count, " isotopes."


end program burnup