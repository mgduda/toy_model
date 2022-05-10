all: model

ifneq ($(wildcard ./phys), )
VPATH := ./phys
include ./phys/Makefile
endif

OBJS = toy_model.o physics_driver.o $(PHYS_OBJS)

phys_checkout:
	@echo "----- Obtaining shared physics -----"
	@import_physics.sh

model: $(OBJS)
	$(FC) -o toy_model $(OBJS)

toy_model.o: physics_driver.o

physics_driver.o: $(PHYS_OBJS)

clean:
	$(RM) *.o *.mod toy_model


# Cancel the built-in implicit rule for Modula-2 files (.mod) to avoid having 'make'
# try to create .o files from Fortran .mod files
%.o : %.mod

%.o : %.F90
	$(FC) -c $< -I./phys
