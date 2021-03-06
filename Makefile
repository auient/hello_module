##
##  Makefile -- Build procedure for sample hello_module Apache module
##  Autogenerated via ``apxs -n hello_module -g''.
##

# command:
# ln -s /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain \
#       /Applications/Xcode.app/Contents/Developer/Toolchains/OSX10.8.xctoolchain
builddir=.
top_srcdir=/usr
top_builddir=/usr/share/httpd
include /usr/share/httpd/build/special.mk

#   the used tools
APXS=apxs
APACHECTL=apachectl

#   additional defines, includes and libraries
#DEFS=-Dmy_define=my_value
#INCLUDES=-Imy/include/dir
#LIBS=-Lmy/lib/dir -lmylib

#   the default target
all: local-shared-build

#   install the shared object file into Apache 
install: install-modules-yes

#   cleanup
clean:
	-rm -f mod_hello_module.o mod_hello_module.lo mod_hello_module.slo mod_hello_module.la 

#   simple test
test: reload
	lynx -mime_header http://localhost/hello_module

#   install and activate shared object by reloading Apache to
#   force a reload of the shared object file
reload: install restart

#   the general Apache start/restart/stop
#   procedures
start:
	$(APACHECTL) start
restart:
	$(APACHECTL) restart
stop:
	$(APACHECTL) stop

