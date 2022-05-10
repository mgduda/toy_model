all: toy_model

#
# If a ./phys directory exists, include the contents of phys/Makefile
# here and add ./phys to VPATH
#
ifneq ($(wildcard ./phys), )
    VPATH := ./phys
    include ./phys/Makefile
endif

#
# Set object files for model, including $(PHYS_OBJS) which is
# defined in ./phys/Makefile
#
OBJS = toy_model.o physics_driver.o $(PHYS_OBJS)


phys_checkout:
	@echo "----- Obtaining shared physics -----"
	@import_physics.sh
	@echo "----- Done obtaining shared physics -----"

toy_model: $(OBJS)
	$(FC) -o toy_model $(OBJS)


#
# Object file dependencies
#
toy_model.o: physics_driver.o

physics_driver.o: $(PHYS_OBJS)


#
# Clean
#
clean:
	$(RM) *.o *.mod toy_model


# Cancel the built-in implicit rule for Modula-2 files (.mod) to avoid having 'make'
# try to create .o files from Fortran .mod files
%.o : %.mod

%.o : %.F90
	$(FC) -c $< -I./phys
