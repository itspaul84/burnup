# Makefile for Fortran burnup project

# Compiler and options
FC = gfortran
FFLAGS = -Wall -O2

# Auto-detect all Fortran source files
SRC = $(wildcard *.f90)
TARGET = burnup

# Default rule
$(TARGET): $(SRC)
	$(FC) $(FFLAGS) -o $(TARGET) $(SRC)

# Clean build artifacts
clean:
	rm -f $(TARGET)
