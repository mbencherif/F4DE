# AVSS09/test

all:
	@echo "Nothing to do"

install:
	@echo "Nothing to do for install"

check:
	@(cd Pre; make $@)
	@(cd AVSS09ViPERValidator; make $@)
	@(cd AVSS09Scorer; make $@)
	@(rm -f ../../common/lib/foomerge*)
	@echo "***** All tests ran succesfully"

makecheckfiles:
	@(cd Pre; make check)
	@(cd AVSS09ViPERValidator; make $@)
	@(cd AVSS09Scorer; make $@)
	@(rm -f ../../common/lib/foomerge*)
	@echo "***** All files generated succesfully"

makecompcheckfiles:
	@(cd Pre; make check)
	@(cd AVSS09ViPERValidator; make $@)
	@(cd AVSS09Scorer; make $@)
	@(rm -f ../../common/lib/foomerge*)
	@echo "***** All files generated succesfully"

cleanresfiles:
	@(cd AVSS09ViPERValidator; make $@)
	@(cd AVSS09Scorer; make $@)
	@(rm -f ../../common/lib/foomerge*)
	@echo "***** All results files removed"
