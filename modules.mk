mod_hello_module.la: mod_hello_module.slo
	$(SH_LINK) -rpath $(libexecdir) -module -avoid-version  mod_hello_module.lo
DISTCLEAN_TARGETS = modules.mk
shared =  mod_hello_module.la
