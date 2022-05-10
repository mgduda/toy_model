default:
	@echo "Please run 'make' with one of the following targets:"
	@echo " gnu"
	@echo " intel"
	exit 1

gnu:
	$(MAKE) all "FC = gfortran"

intel:
	$(MAKE) all "FC = ifort"

all:
	$(MAKE) -C src phys_checkout
	$(MAKE) -C src toy_model
	ln -sf src/toy_model .

clean:
	( $(MAKE) -C src clean )
	$(RM) toy_model
