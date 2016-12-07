# This Makefile is for the Verilog::Language extension to perl.
#
# It was generated automatically by MakeMaker version
# 6.66 (Revision: 66600) from the contents of
# Makefile.PL. Don't edit this file, edit Makefile.PL instead.
#
#       ANY CHANGES MADE HERE WILL BE LOST!
#
#   MakeMaker ARGV: ()
#

#   MakeMaker Parameters:

#     ABSTRACT => q[Verilog language utilities and parsing]
#     AUTHOR => [q[Wilson Snyder <wsnyder@wsnyder.org>]]
#     BUILD_REQUIRES => {  }
#     CONFIGURE_REQUIRES => {  }
#     DISTNAME => q[Verilog-Perl]
#     EXE_FILES => [q[vrename], q[vpassert], q[vppreproc], q[vhier], q[vsplitmodule]]
#     NAME => q[Verilog::Language]
#     NO_META => q[1]
#     PMLIBDIRS => [q[Netlist]]
#     PREREQ_PM => { Time::HiRes=>q[1], Data::Dumper=>q[1], warnings=>q[1], Pod::Usage=>q[1.34], Test::More=>q[0], Test=>q[1], Digest::SHA=>q[0] }
#     TEST_REQUIRES => {  }
#     VERSION_FROM => q[Language.pm]
#     clean => { simv=>undef, FILES=>q[test_dir], signals.vrename=>q[.vpassert] }
#     dist => { COMPRESS=>q[gzip -9f], SUFFIX=>q[.gz], DIST_DEFAULT=>q[README all tardist] }

# --- MakeMaker post_initialize section:


# --- MakeMaker const_config section:

# These definitions are from config.sh (via /usr/lib/perl/5.18/Config.pm).
# They may have been overridden via Makefile.PL or on the command line.
AR = ar
CC = cc
CCCDLFLAGS = -fPIC
CCDLFLAGS = -Wl,-E
DLEXT = so
DLSRC = dl_dlopen.xs
EXE_EXT = 
FULL_AR = /usr/bin/ar
LD = cc
LDDLFLAGS = -shared -L/usr/local/lib -fstack-protector
LDFLAGS =  -fstack-protector -L/usr/local/lib
LIBC = 
LIB_EXT = .a
OBJ_EXT = .o
OSNAME = linux
OSVERS = 3.2.0-58-generic
RANLIB = :
SITELIBEXP = /usr/local/share/perl/5.18.2
SITEARCHEXP = /usr/local/lib/perl/5.18.2
SO = so
VENDORARCHEXP = /usr/lib/perl5
VENDORLIBEXP = /usr/share/perl5


# --- MakeMaker constants section:
AR_STATIC_ARGS = cr
DIRFILESEP = /
DFSEP = $(DIRFILESEP)
NAME = Verilog::Language
NAME_SYM = Verilog_Language
VERSION = 3.410
VERSION_MACRO = VERSION
VERSION_SYM = 3_410
DEFINE_VERSION = -D$(VERSION_MACRO)=\"$(VERSION)\"
XS_VERSION = 3.410
XS_VERSION_MACRO = XS_VERSION
XS_DEFINE_VERSION = -D$(XS_VERSION_MACRO)=\"$(XS_VERSION)\"
INST_ARCHLIB = blib/arch
INST_SCRIPT = blib/script
INST_BIN = blib/bin
INST_LIB = blib/lib
INST_MAN1DIR = blib/man1
INST_MAN3DIR = blib/man3
MAN1EXT = 1p
MAN3EXT = 3pm
INSTALLDIRS = site
DESTDIR = 
PREFIX = /usr
PERLPREFIX = $(PREFIX)
SITEPREFIX = $(PREFIX)/local
VENDORPREFIX = $(PREFIX)
INSTALLPRIVLIB = $(PERLPREFIX)/share/perl/5.18
DESTINSTALLPRIVLIB = $(DESTDIR)$(INSTALLPRIVLIB)
INSTALLSITELIB = $(SITEPREFIX)/share/perl/5.18.2
DESTINSTALLSITELIB = $(DESTDIR)$(INSTALLSITELIB)
INSTALLVENDORLIB = $(VENDORPREFIX)/share/perl5
DESTINSTALLVENDORLIB = $(DESTDIR)$(INSTALLVENDORLIB)
INSTALLARCHLIB = $(PERLPREFIX)/lib/perl/5.18
DESTINSTALLARCHLIB = $(DESTDIR)$(INSTALLARCHLIB)
INSTALLSITEARCH = $(SITEPREFIX)/lib/perl/5.18.2
DESTINSTALLSITEARCH = $(DESTDIR)$(INSTALLSITEARCH)
INSTALLVENDORARCH = $(VENDORPREFIX)/lib/perl5
DESTINSTALLVENDORARCH = $(DESTDIR)$(INSTALLVENDORARCH)
INSTALLBIN = $(PERLPREFIX)/bin
DESTINSTALLBIN = $(DESTDIR)$(INSTALLBIN)
INSTALLSITEBIN = $(SITEPREFIX)/bin
DESTINSTALLSITEBIN = $(DESTDIR)$(INSTALLSITEBIN)
INSTALLVENDORBIN = $(VENDORPREFIX)/bin
DESTINSTALLVENDORBIN = $(DESTDIR)$(INSTALLVENDORBIN)
INSTALLSCRIPT = $(PERLPREFIX)/bin
DESTINSTALLSCRIPT = $(DESTDIR)$(INSTALLSCRIPT)
INSTALLSITESCRIPT = $(SITEPREFIX)/bin
DESTINSTALLSITESCRIPT = $(DESTDIR)$(INSTALLSITESCRIPT)
INSTALLVENDORSCRIPT = $(VENDORPREFIX)/bin
DESTINSTALLVENDORSCRIPT = $(DESTDIR)$(INSTALLVENDORSCRIPT)
INSTALLMAN1DIR = $(PERLPREFIX)/share/man/man1
DESTINSTALLMAN1DIR = $(DESTDIR)$(INSTALLMAN1DIR)
INSTALLSITEMAN1DIR = $(SITEPREFIX)/man/man1
DESTINSTALLSITEMAN1DIR = $(DESTDIR)$(INSTALLSITEMAN1DIR)
INSTALLVENDORMAN1DIR = $(VENDORPREFIX)/share/man/man1
DESTINSTALLVENDORMAN1DIR = $(DESTDIR)$(INSTALLVENDORMAN1DIR)
INSTALLMAN3DIR = $(PERLPREFIX)/share/man/man3
DESTINSTALLMAN3DIR = $(DESTDIR)$(INSTALLMAN3DIR)
INSTALLSITEMAN3DIR = $(SITEPREFIX)/man/man3
DESTINSTALLSITEMAN3DIR = $(DESTDIR)$(INSTALLSITEMAN3DIR)
INSTALLVENDORMAN3DIR = $(VENDORPREFIX)/share/man/man3
DESTINSTALLVENDORMAN3DIR = $(DESTDIR)$(INSTALLVENDORMAN3DIR)
PERL_LIB = /usr/share/perl/5.18
PERL_ARCHLIB = /usr/lib/perl/5.18
LIBPERL_A = libperl.a
FIRST_MAKEFILE = Makefile
MAKEFILE_OLD = Makefile.old
MAKE_APERL_FILE = Makefile.aperl
PERLMAINCC = $(CC)
PERL_INC = /usr/lib/perl/5.18/CORE
PERL = /usr/bin/perl
FULLPERL = /usr/bin/perl
ABSPERL = $(PERL)
PERLRUN = $(PERL)
FULLPERLRUN = $(FULLPERL)
ABSPERLRUN = $(ABSPERL)
PERLRUNINST = $(PERLRUN) "-I$(INST_ARCHLIB)" "-I$(INST_LIB)"
FULLPERLRUNINST = $(FULLPERLRUN) "-I$(INST_ARCHLIB)" "-I$(INST_LIB)"
ABSPERLRUNINST = $(ABSPERLRUN) "-I$(INST_ARCHLIB)" "-I$(INST_LIB)"
PERL_CORE = 0
PERM_DIR = 755
PERM_RW = 644
PERM_RWX = 755

MAKEMAKER   = /usr/share/perl/5.18/ExtUtils/MakeMaker.pm
MM_VERSION  = 6.66
MM_REVISION = 66600

# FULLEXT = Pathname for extension directory (eg Foo/Bar/Oracle).
# BASEEXT = Basename part of FULLEXT. May be just equal FULLEXT. (eg Oracle)
# PARENT_NAME = NAME without BASEEXT and no trailing :: (eg Foo::Bar)
# DLBASE  = Basename part of dynamic library. May be just equal BASEEXT.
MAKE = make
FULLEXT = Verilog/Language
BASEEXT = Language
PARENT_NAME = Verilog
DLBASE = $(BASEEXT)
VERSION_FROM = Language.pm
OBJECT = 
LDFROM = $(OBJECT)
LINKTYPE = dynamic
BOOTDEP = 

# Handy lists of source code files:
XS_FILES = 
C_FILES  = 
O_FILES  = 
H_FILES  = 
MAN1PODS = vhier \
	vpassert \
	vppreproc \
	vrename
MAN3PODS = EditFiles.pm \
	Getopt.pm \
	Language.pm \
	Netlist.pm \
	Netlist/Cell.pm \
	Netlist/ContAssign.pm \
	Netlist/Defparam.pm \
	Netlist/File.pm \
	Netlist/Interface.pm \
	Netlist/Logger.pm \
	Netlist/ModPort.pm \
	Netlist/Module.pm \
	Netlist/Net.pm \
	Netlist/Pin.pm \
	Netlist/Port.pm \
	Netlist/Subclass.pm \
	Std.pm \
	Verilog-Perl.pod

# Where is the Config information that we are using/depend on
CONFIGDEP = $(PERL_ARCHLIB)$(DFSEP)Config.pm $(PERL_INC)$(DFSEP)config.h

# Where to build things
INST_LIBDIR      = $(INST_LIB)/Verilog
INST_ARCHLIBDIR  = $(INST_ARCHLIB)/Verilog

INST_AUTODIR     = $(INST_LIB)/auto/$(FULLEXT)
INST_ARCHAUTODIR = $(INST_ARCHLIB)/auto/$(FULLEXT)

INST_STATIC      = 
INST_DYNAMIC     = 
INST_BOOT        = 

# Extra linker info
EXPORT_LIST        = 
PERL_ARCHIVE       = 
PERL_ARCHIVE_AFTER = 


TO_INST_PM = EditFiles.pm \
	Getopt.pm \
	Language.pm \
	Netlist.pm \
	Netlist/Cell.pm \
	Netlist/ContAssign.pm \
	Netlist/Defparam.pm \
	Netlist/File.pm \
	Netlist/Interface.pm \
	Netlist/Logger.pm \
	Netlist/ModPort.pm \
	Netlist/Module.pm \
	Netlist/Net.pm \
	Netlist/Pin.pm \
	Netlist/Port.pm \
	Netlist/Subclass.pm \
	Std.pm \
	Verilog-Perl.pod

PM_TO_BLIB = Netlist/File.pm \
	$(INST_LIB)/Verilog/Netlist/File.pm \
	Language.pm \
	$(INST_LIB)/Verilog/Language.pm \
	Netlist/Logger.pm \
	$(INST_LIB)/Verilog/Netlist/Logger.pm \
	Netlist/Subclass.pm \
	$(INST_LIB)/Verilog/Netlist/Subclass.pm \
	Std.pm \
	$(INST_LIB)/Verilog/Std.pm \
	Netlist/Defparam.pm \
	$(INST_LIB)/Verilog/Netlist/Defparam.pm \
	Getopt.pm \
	$(INST_LIB)/Verilog/Getopt.pm \
	EditFiles.pm \
	$(INST_LIB)/Verilog/EditFiles.pm \
	Netlist.pm \
	$(INST_LIB)/Verilog/Netlist.pm \
	Verilog-Perl.pod \
	$(INST_LIB)/Verilog/Verilog-Perl.pod \
	Netlist/Interface.pm \
	$(INST_LIB)/Verilog/Netlist/Interface.pm \
	Netlist/Port.pm \
	$(INST_LIB)/Verilog/Netlist/Port.pm \
	Netlist/ModPort.pm \
	$(INST_LIB)/Verilog/Netlist/ModPort.pm \
	Netlist/Net.pm \
	$(INST_LIB)/Verilog/Netlist/Net.pm \
	Netlist/Module.pm \
	$(INST_LIB)/Verilog/Netlist/Module.pm \
	Netlist/ContAssign.pm \
	$(INST_LIB)/Verilog/Netlist/ContAssign.pm \
	Netlist/Cell.pm \
	$(INST_LIB)/Verilog/Netlist/Cell.pm \
	Netlist/Pin.pm \
	$(INST_LIB)/Verilog/Netlist/Pin.pm


# --- MakeMaker platform_constants section:
MM_Unix_VERSION = 6.66
PERL_MALLOC_DEF = -DPERL_EXTMALLOC_DEF -Dmalloc=Perl_malloc -Dfree=Perl_mfree -Drealloc=Perl_realloc -Dcalloc=Perl_calloc


# --- MakeMaker tool_autosplit section:
# Usage: $(AUTOSPLITFILE) FileToSplit AutoDirToSplitInto
AUTOSPLITFILE = $(ABSPERLRUN)  -e 'use AutoSplit;  autosplit($$$$ARGV[0], $$$$ARGV[1], 0, 1, 1)' --



# --- MakeMaker tool_xsubpp section:

XSUBPPDIR = /usr/share/perl/5.18/ExtUtils
XSUBPP = $(XSUBPPDIR)$(DFSEP)xsubpp
XSUBPPRUN = $(PERLRUN) $(XSUBPP)
XSPROTOARG = 
XSUBPPDEPS = /usr/share/perl/5.18/ExtUtils/typemap $(XSUBPP)
XSUBPPARGS = -typemap /usr/share/perl/5.18/ExtUtils/typemap
XSUBPP_EXTRA_ARGS = 


# --- MakeMaker tools_other section:
SHELL = /bin/sh
CHMOD = chmod
CP = cp
MV = mv
NOOP = $(TRUE)
NOECHO = @
RM_F = rm -f
RM_RF = rm -rf
TEST_F = test -f
TOUCH = touch
UMASK_NULL = umask 0
DEV_NULL = > /dev/null 2>&1
MKPATH = $(ABSPERLRUN) -MExtUtils::Command -e 'mkpath' --
EQUALIZE_TIMESTAMP = $(ABSPERLRUN) -MExtUtils::Command -e 'eqtime' --
FALSE = false
TRUE = true
ECHO = echo
ECHO_N = echo -n
UNINST = 0
VERBINST = 0
MOD_INSTALL = $(ABSPERLRUN) -MExtUtils::Install -e 'install([ from_to => {@ARGV}, verbose => '\''$(VERBINST)'\'', uninstall_shadows => '\''$(UNINST)'\'', dir_mode => '\''$(PERM_DIR)'\'' ]);' --
DOC_INSTALL = $(ABSPERLRUN) -MExtUtils::Command::MM -e 'perllocal_install' --
UNINSTALL = $(ABSPERLRUN) -MExtUtils::Command::MM -e 'uninstall' --
WARN_IF_OLD_PACKLIST = $(ABSPERLRUN) -MExtUtils::Command::MM -e 'warn_if_old_packlist' --
MACROSTART = 
MACROEND = 
USEMAKEFILE = -f
FIXIN = $(ABSPERLRUN) -MExtUtils::MY -e 'MY->fixin(shift)' --


# --- MakeMaker makemakerdflt section:
makemakerdflt : all
	$(NOECHO) $(NOOP)


# --- MakeMaker dist section:
TAR = tar
TARFLAGS = cvf
ZIP = zip
ZIPFLAGS = -r
COMPRESS = gzip -9f
SUFFIX = .gz
SHAR = shar
PREOP = $(NOECHO) $(NOOP)
POSTOP = $(NOECHO) $(NOOP)
TO_UNIX = $(NOECHO) $(NOOP)
CI = ci -u
RCS_LABEL = rcs -Nv$(VERSION_SYM): -q
DIST_CP = best
DIST_DEFAULT = README all tardist
DISTNAME = Verilog-Perl
DISTVNAME = Verilog-Perl-3.410


# --- MakeMaker macro section:


# --- MakeMaker depend section:


# --- MakeMaker cflags section:

CCFLAGS = -D_REENTRANT -D_GNU_SOURCE -DDEBIAN -fstack-protector -fno-strict-aliasing -pipe -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64
OPTIMIZE = -O2 -g
PERLTYPE = 
MPOLLUTE = 


# --- MakeMaker const_loadlibs section:

# Verilog::Language might depend on some other libraries:
# See ExtUtils::Liblist for details
#


# --- MakeMaker const_cccmd section:
CCCMD = $(CC) -c $(PASTHRU_INC) $(INC) \
	$(CCFLAGS) $(OPTIMIZE) \
	$(PERLTYPE) $(MPOLLUTE) $(DEFINE_VERSION) \
	$(XS_DEFINE_VERSION)

# --- MakeMaker post_constants section:


# --- MakeMaker pasthru section:

PASTHRU = LIBPERL_A="$(LIBPERL_A)"\
	LINKTYPE="$(LINKTYPE)"\
	OPTIMIZE="$(OPTIMIZE)"\
	LD="$(LD)"\
	PREFIX="$(PREFIX)"


# --- MakeMaker special_targets section:
.SUFFIXES : .xs .c .C .cpp .i .s .cxx .cc $(OBJ_EXT)

.PHONY: all config static dynamic test linkext manifest blibdirs clean realclean disttest distdir



# --- MakeMaker c_o section:

.c.i:
	cc -E -c $(PASTHRU_INC) $(INC) \
	$(CCFLAGS) $(OPTIMIZE) \
	$(PERLTYPE) $(MPOLLUTE) $(DEFINE_VERSION) \
	$(XS_DEFINE_VERSION) $(CCCDLFLAGS) "-I$(PERL_INC)" $(PASTHRU_DEFINE) $(DEFINE) $*.c > $*.i

.c.s:
	$(CCCMD) -S $(CCCDLFLAGS) "-I$(PERL_INC)" $(PASTHRU_DEFINE) $(DEFINE) $*.c

.c$(OBJ_EXT):
	$(CCCMD) $(CCCDLFLAGS) "-I$(PERL_INC)" $(PASTHRU_DEFINE) $(DEFINE) $*.c

.cpp$(OBJ_EXT):
	$(CCCMD) $(CCCDLFLAGS) "-I$(PERL_INC)" $(PASTHRU_DEFINE) $(DEFINE) $*.cpp

.cxx$(OBJ_EXT):
	$(CCCMD) $(CCCDLFLAGS) "-I$(PERL_INC)" $(PASTHRU_DEFINE) $(DEFINE) $*.cxx

.cc$(OBJ_EXT):
	$(CCCMD) $(CCCDLFLAGS) "-I$(PERL_INC)" $(PASTHRU_DEFINE) $(DEFINE) $*.cc

.C$(OBJ_EXT):
	$(CCCMD) $(CCCDLFLAGS) "-I$(PERL_INC)" $(PASTHRU_DEFINE) $(DEFINE) $*.C


# --- MakeMaker xs_c section:

.xs.c:
	$(XSUBPPRUN) $(XSPROTOARG) $(XSUBPPARGS) $(XSUBPP_EXTRA_ARGS) $*.xs > $*.xsc && $(MV) $*.xsc $*.c


# --- MakeMaker xs_o section:

.xs$(OBJ_EXT):
	$(XSUBPPRUN) $(XSPROTOARG) $(XSUBPPARGS) $*.xs > $*.xsc && $(MV) $*.xsc $*.c
	$(CCCMD) $(CCCDLFLAGS) "-I$(PERL_INC)" $(PASTHRU_DEFINE) $(DEFINE) $*.c


# --- MakeMaker top_targets section:
all :: pure_all manifypods
	$(NOECHO) $(NOOP)


pure_all :: config pm_to_blib subdirs linkext
	$(NOECHO) $(NOOP)

subdirs :: $(MYEXTLIB)
	$(NOECHO) $(NOOP)

config :: $(FIRST_MAKEFILE) blibdirs
	$(NOECHO) $(NOOP)

help :
	perldoc ExtUtils::MakeMaker


# --- MakeMaker blibdirs section:
blibdirs : $(INST_LIBDIR)$(DFSEP).exists $(INST_ARCHLIB)$(DFSEP).exists $(INST_AUTODIR)$(DFSEP).exists $(INST_ARCHAUTODIR)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists $(INST_SCRIPT)$(DFSEP).exists $(INST_MAN1DIR)$(DFSEP).exists $(INST_MAN3DIR)$(DFSEP).exists
	$(NOECHO) $(NOOP)

# Backwards compat with 6.18 through 6.25
blibdirs.ts : blibdirs
	$(NOECHO) $(NOOP)

$(INST_LIBDIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_LIBDIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_LIBDIR)
	$(NOECHO) $(TOUCH) $(INST_LIBDIR)$(DFSEP).exists

$(INST_ARCHLIB)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_ARCHLIB)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_ARCHLIB)
	$(NOECHO) $(TOUCH) $(INST_ARCHLIB)$(DFSEP).exists

$(INST_AUTODIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_AUTODIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_AUTODIR)
	$(NOECHO) $(TOUCH) $(INST_AUTODIR)$(DFSEP).exists

$(INST_ARCHAUTODIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_ARCHAUTODIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_ARCHAUTODIR)
	$(NOECHO) $(TOUCH) $(INST_ARCHAUTODIR)$(DFSEP).exists

$(INST_BIN)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_BIN)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_BIN)
	$(NOECHO) $(TOUCH) $(INST_BIN)$(DFSEP).exists

$(INST_SCRIPT)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_SCRIPT)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_SCRIPT)
	$(NOECHO) $(TOUCH) $(INST_SCRIPT)$(DFSEP).exists

$(INST_MAN1DIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_MAN1DIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_MAN1DIR)
	$(NOECHO) $(TOUCH) $(INST_MAN1DIR)$(DFSEP).exists

$(INST_MAN3DIR)$(DFSEP).exists :: Makefile.PL
	$(NOECHO) $(MKPATH) $(INST_MAN3DIR)
	$(NOECHO) $(CHMOD) $(PERM_DIR) $(INST_MAN3DIR)
	$(NOECHO) $(TOUCH) $(INST_MAN3DIR)$(DFSEP).exists



# --- MakeMaker linkext section:

linkext :: $(LINKTYPE)
	$(NOECHO) $(NOOP)


# --- MakeMaker dlsyms section:


# --- MakeMaker dynamic section:

dynamic :: $(FIRST_MAKEFILE) $(INST_DYNAMIC) $(INST_BOOT)
	$(NOECHO) $(NOOP)


# --- MakeMaker dynamic_bs section:

BOOTSTRAP =


# --- MakeMaker dynamic_lib section:


# --- MakeMaker static section:

## $(INST_PM) has been moved to the all: target.
## It remains here for awhile to allow for old usage: "make static"
static :: $(FIRST_MAKEFILE) $(INST_STATIC)
	$(NOECHO) $(NOOP)


# --- MakeMaker static_lib section:


# --- MakeMaker manifypods section:

POD2MAN_EXE = $(PERLRUN) "-MExtUtils::Command::MM" -e pod2man "--"
POD2MAN = $(POD2MAN_EXE)


manifypods : pure_all  \
	vppreproc \
	vhier \
	vpassert \
	vrename \
	Netlist/File.pm \
	Netlist/Logger.pm \
	Language.pm \
	EditFiles.pm \
	Getopt.pm \
	Netlist/Subclass.pm \
	Std.pm \
	Netlist/Defparam.pm \
	Netlist.pm \
	Netlist/Port.pm \
	Verilog-Perl.pod \
	Netlist/Interface.pm \
	Netlist/Net.pm \
	Netlist/Module.pm \
	Netlist/ModPort.pm \
	Netlist/Cell.pm \
	Netlist/Pin.pm \
	Netlist/ContAssign.pm
	$(NOECHO) $(POD2MAN) --section=$(MAN1EXT) --perm_rw=$(PERM_RW) \
	  vppreproc $(INST_MAN1DIR)/vppreproc.$(MAN1EXT) \
	  vhier $(INST_MAN1DIR)/vhier.$(MAN1EXT) \
	  vpassert $(INST_MAN1DIR)/vpassert.$(MAN1EXT) \
	  vrename $(INST_MAN1DIR)/vrename.$(MAN1EXT) 
	$(NOECHO) $(POD2MAN) --section=$(MAN3EXT) --perm_rw=$(PERM_RW) \
	  Netlist/File.pm $(INST_MAN3DIR)/Verilog::Netlist::File.$(MAN3EXT) \
	  Netlist/Logger.pm $(INST_MAN3DIR)/Verilog::Netlist::Logger.$(MAN3EXT) \
	  Language.pm $(INST_MAN3DIR)/Verilog::Language.$(MAN3EXT) \
	  EditFiles.pm $(INST_MAN3DIR)/Verilog::EditFiles.$(MAN3EXT) \
	  Getopt.pm $(INST_MAN3DIR)/Verilog::Getopt.$(MAN3EXT) \
	  Netlist/Subclass.pm $(INST_MAN3DIR)/Verilog::Netlist::Subclass.$(MAN3EXT) \
	  Std.pm $(INST_MAN3DIR)/Verilog::Std.$(MAN3EXT) \
	  Netlist/Defparam.pm $(INST_MAN3DIR)/Verilog::Netlist::Defparam.$(MAN3EXT) \
	  Netlist.pm $(INST_MAN3DIR)/Verilog::Netlist.$(MAN3EXT) \
	  Netlist/Port.pm $(INST_MAN3DIR)/Verilog::Netlist::Port.$(MAN3EXT) \
	  Verilog-Perl.pod $(INST_MAN3DIR)/Verilog::Verilog-Perl.$(MAN3EXT) \
	  Netlist/Interface.pm $(INST_MAN3DIR)/Verilog::Netlist::Interface.$(MAN3EXT) \
	  Netlist/Net.pm $(INST_MAN3DIR)/Verilog::Netlist::Net.$(MAN3EXT) \
	  Netlist/Module.pm $(INST_MAN3DIR)/Verilog::Netlist::Module.$(MAN3EXT) \
	  Netlist/ModPort.pm $(INST_MAN3DIR)/Verilog::Netlist::ModPort.$(MAN3EXT) \
	  Netlist/Cell.pm $(INST_MAN3DIR)/Verilog::Netlist::Cell.$(MAN3EXT) \
	  Netlist/Pin.pm $(INST_MAN3DIR)/Verilog::Netlist::Pin.$(MAN3EXT) \
	  Netlist/ContAssign.pm $(INST_MAN3DIR)/Verilog::Netlist::ContAssign.$(MAN3EXT) 




# --- MakeMaker processPL section:


# --- MakeMaker installbin section:

EXE_FILES = vrename vpassert vppreproc vhier vsplitmodule

pure_all :: $(INST_SCRIPT)/vppreproc $(INST_SCRIPT)/vsplitmodule $(INST_SCRIPT)/vrename $(INST_SCRIPT)/vpassert $(INST_SCRIPT)/vhier
	$(NOECHO) $(NOOP)

realclean ::
	$(RM_F) \
	  $(INST_SCRIPT)/vppreproc $(INST_SCRIPT)/vsplitmodule \
	  $(INST_SCRIPT)/vrename $(INST_SCRIPT)/vpassert \
	  $(INST_SCRIPT)/vhier 

$(INST_SCRIPT)/vppreproc : vppreproc $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/vppreproc
	$(CP) vppreproc $(INST_SCRIPT)/vppreproc
	$(FIXIN) $(INST_SCRIPT)/vppreproc
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/vppreproc

$(INST_SCRIPT)/vsplitmodule : vsplitmodule $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/vsplitmodule
	$(CP) vsplitmodule $(INST_SCRIPT)/vsplitmodule
	$(FIXIN) $(INST_SCRIPT)/vsplitmodule
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/vsplitmodule

$(INST_SCRIPT)/vrename : vrename $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/vrename
	$(CP) vrename $(INST_SCRIPT)/vrename
	$(FIXIN) $(INST_SCRIPT)/vrename
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/vrename

$(INST_SCRIPT)/vpassert : vpassert $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/vpassert
	$(CP) vpassert $(INST_SCRIPT)/vpassert
	$(FIXIN) $(INST_SCRIPT)/vpassert
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/vpassert

$(INST_SCRIPT)/vhier : vhier $(FIRST_MAKEFILE) $(INST_SCRIPT)$(DFSEP).exists $(INST_BIN)$(DFSEP).exists
	$(NOECHO) $(RM_F) $(INST_SCRIPT)/vhier
	$(CP) vhier $(INST_SCRIPT)/vhier
	$(FIXIN) $(INST_SCRIPT)/vhier
	-$(NOECHO) $(CHMOD) $(PERM_RWX) $(INST_SCRIPT)/vhier



# --- MakeMaker subdirs section:

# The default clean, realclean and test targets in this Makefile
# have automatically been given entries for each subdir.


subdirs ::
	$(NOECHO) cd Parser && $(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) all $(PASTHRU)

subdirs ::
	$(NOECHO) cd Preproc && $(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) all $(PASTHRU)


# --- MakeMaker clean_subdirs section:
clean_subdirs :
	$(ABSPERLRUN)  -e 'chdir '\''Parser'\'';  system '\''$(MAKE) clean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	$(ABSPERLRUN)  -e 'chdir '\''Preproc'\'';  system '\''$(MAKE) clean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --


# --- MakeMaker clean section:

# Delete temporary files but do not touch installed files. We don't delete
# the Makefile here so a later make realclean still has a makefile to use.

clean :: clean_subdirs
	- $(RM_F) \
	  pm_to_blib.ts blibdirs.ts \
	  tmon.out mon.out \
	  $(BASEEXT).def so_locations \
	  MYMETA.json core \
	  $(BASEEXT).x lib$(BASEEXT).def \
	  core.[0-9][0-9][0-9] MYMETA.yml \
	  perl$(EXE_EXT) $(BOOTSTRAP) \
	  core.[0-9][0-9][0-9][0-9][0-9] *$(OBJ_EXT) \
	  pm_to_blib $(INST_ARCHAUTODIR)/extralibs.ld \
	  *perl.core $(BASEEXT).bso \
	  $(BASEEXT).exp $(INST_ARCHAUTODIR)/extralibs.all \
	  perl core.[0-9][0-9][0-9][0-9] \
	  perlmain.c perl.exe \
	  core.[0-9][0-9] $(MAKE_APERL_FILE) \
	  *$(LIB_EXT) core.[0-9] \
	  core.*perl.*.? 
	- $(RM_RF) \
	  test_dir blib 
	- $(MV) $(FIRST_MAKEFILE) $(MAKEFILE_OLD) $(DEV_NULL)


# --- MakeMaker realclean_subdirs section:
realclean_subdirs :
	- $(ABSPERLRUN)  -e 'chdir '\''Parser'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) realclean'\'' if -f '\''$(MAKEFILE_OLD)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''Parser'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) realclean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''Preproc'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) realclean'\'' if -f '\''$(MAKEFILE_OLD)'\'';' --
	- $(ABSPERLRUN)  -e 'chdir '\''Preproc'\'';  system '\''$(MAKE) $(USEMAKEFILE) $(FIRST_MAKEFILE) realclean'\'' if -f '\''$(FIRST_MAKEFILE)'\'';' --


# --- MakeMaker realclean section:
# Delete temporary files (via clean) and also delete dist files
realclean purge ::  clean realclean_subdirs
	- $(RM_F) \
	  $(MAKEFILE_OLD) $(FIRST_MAKEFILE) 
	- $(RM_RF) \
	  $(DISTVNAME) 


# --- MakeMaker metafile section:
metafile :
	$(NOECHO) $(NOOP)


# --- MakeMaker signature section:
signature :
	cpansign -s


# --- MakeMaker dist_basics section:
distclean :: realclean distcheck
	$(NOECHO) $(NOOP)

distcheck :
	$(PERLRUN) "-MExtUtils::Manifest=fullcheck" -e fullcheck

skipcheck :
	$(PERLRUN) "-MExtUtils::Manifest=skipcheck" -e skipcheck

manifest :
	$(PERLRUN) "-MExtUtils::Manifest=mkmanifest" -e mkmanifest

veryclean : realclean
	$(RM_F) *~ */*~ *.orig */*.orig *.bak */*.bak *.old */*.old 



# --- MakeMaker dist_core section:

dist : $(DIST_DEFAULT) $(FIRST_MAKEFILE)
	$(NOECHO) $(ABSPERLRUN) -l -e 'print '\''Warning: Makefile possibly out of date with $(VERSION_FROM)'\''' \
	  -e '    if -e '\''$(VERSION_FROM)'\'' and -M '\''$(VERSION_FROM)'\'' < -M '\''$(FIRST_MAKEFILE)'\'';' --

tardist : $(DISTVNAME).tar$(SUFFIX)
	$(NOECHO) $(NOOP)

uutardist : $(DISTVNAME).tar$(SUFFIX)
	uuencode $(DISTVNAME).tar$(SUFFIX) $(DISTVNAME).tar$(SUFFIX) > $(DISTVNAME).tar$(SUFFIX)_uu

$(DISTVNAME).tar$(SUFFIX) : distdir
	$(PREOP)
	$(TO_UNIX)
	$(TAR) $(TARFLAGS) $(DISTVNAME).tar $(DISTVNAME)
	$(RM_RF) $(DISTVNAME)
	$(COMPRESS) $(DISTVNAME).tar
	$(POSTOP)

zipdist : $(DISTVNAME).zip
	$(NOECHO) $(NOOP)

$(DISTVNAME).zip : distdir
	$(PREOP)
	$(ZIP) $(ZIPFLAGS) $(DISTVNAME).zip $(DISTVNAME)
	$(RM_RF) $(DISTVNAME)
	$(POSTOP)

shdist : distdir
	$(PREOP)
	$(SHAR) $(DISTVNAME) > $(DISTVNAME).shar
	$(RM_RF) $(DISTVNAME)
	$(POSTOP)


# --- MakeMaker distdir section:
create_distdir :
	$(RM_RF) $(DISTVNAME)
	$(PERLRUN) "-MExtUtils::Manifest=manicopy,maniread" \
		-e "manicopy(maniread(),'$(DISTVNAME)', '$(DIST_CP)');"

distdir : create_distdir  
	$(NOECHO) $(NOOP)



# --- MakeMaker dist_test section:
disttest : distdir
	cd $(DISTVNAME) && $(ABSPERLRUN) Makefile.PL 
	cd $(DISTVNAME) && $(MAKE) $(PASTHRU)
	cd $(DISTVNAME) && $(MAKE) test $(PASTHRU)



# --- MakeMaker dist_ci section:

ci :
	$(PERLRUN) "-MExtUtils::Manifest=maniread" \
	  -e "@all = keys %{ maniread() };" \
	  -e "print(qq{Executing $(CI) @all\n}); system(qq{$(CI) @all});" \
	  -e "print(qq{Executing $(RCS_LABEL) ...\n}); system(qq{$(RCS_LABEL) @all});"


# --- MakeMaker distmeta section:
distmeta : create_distdir metafile
	$(NOECHO) cd $(DISTVNAME) && $(ABSPERLRUN) -MExtUtils::Manifest=maniadd -e 'exit unless -e q{META.yml};' \
	  -e 'eval { maniadd({q{META.yml} => q{Module YAML meta-data (added by MakeMaker)}}) }' \
	  -e '    or print "Could not add META.yml to MANIFEST: $$$${'\''@'\''}\n"' --
	$(NOECHO) cd $(DISTVNAME) && $(ABSPERLRUN) -MExtUtils::Manifest=maniadd -e 'exit unless -f q{META.json};' \
	  -e 'eval { maniadd({q{META.json} => q{Module JSON meta-data (added by MakeMaker)}}) }' \
	  -e '    or print "Could not add META.json to MANIFEST: $$$${'\''@'\''}\n"' --



# --- MakeMaker distsignature section:
distsignature : create_distdir
	$(NOECHO) cd $(DISTVNAME) && $(ABSPERLRUN) -MExtUtils::Manifest=maniadd -e 'eval { maniadd({q{SIGNATURE} => q{Public-key signature (added by MakeMaker)}}) } ' \
	  -e '    or print "Could not add SIGNATURE to MANIFEST: $$$${'\''@'\''}\n"' --
	$(NOECHO) cd $(DISTVNAME) && $(TOUCH) SIGNATURE
	cd $(DISTVNAME) && cpansign -s



# --- MakeMaker install section:

install :: pure_install doc_install
	$(NOECHO) $(NOOP)

install_perl :: pure_perl_install doc_perl_install
	$(NOECHO) $(NOOP)

install_site :: pure_site_install doc_site_install
	$(NOECHO) $(NOOP)

install_vendor :: pure_vendor_install doc_vendor_install
	$(NOECHO) $(NOOP)

pure_install :: pure_$(INSTALLDIRS)_install
	$(NOECHO) $(NOOP)

doc_install :: doc_$(INSTALLDIRS)_install
	$(NOECHO) $(NOOP)

pure__install : pure_site_install
	$(NOECHO) $(ECHO) INSTALLDIRS not defined, defaulting to INSTALLDIRS=site

doc__install : doc_site_install
	$(NOECHO) $(ECHO) INSTALLDIRS not defined, defaulting to INSTALLDIRS=site

pure_perl_install :: all
	$(NOECHO) umask 022; $(MOD_INSTALL) \
		$(INST_LIB) $(DESTINSTALLPRIVLIB) \
		$(INST_ARCHLIB) $(DESTINSTALLARCHLIB) \
		$(INST_BIN) $(DESTINSTALLBIN) \
		$(INST_SCRIPT) $(DESTINSTALLSCRIPT) \
		$(INST_MAN1DIR) $(DESTINSTALLMAN1DIR) \
		$(INST_MAN3DIR) $(DESTINSTALLMAN3DIR)
	$(NOECHO) $(WARN_IF_OLD_PACKLIST) \
		$(SITEARCHEXP)/auto/$(FULLEXT)


pure_site_install :: all
	$(NOECHO) umask 02; $(MOD_INSTALL) \
		read $(SITEARCHEXP)/auto/$(FULLEXT)/.packlist \
		write $(DESTINSTALLSITEARCH)/auto/$(FULLEXT)/.packlist \
		$(INST_LIB) $(DESTINSTALLSITELIB) \
		$(INST_ARCHLIB) $(DESTINSTALLSITEARCH) \
		$(INST_BIN) $(DESTINSTALLSITEBIN) \
		$(INST_SCRIPT) $(DESTINSTALLSITESCRIPT) \
		$(INST_MAN1DIR) $(DESTINSTALLSITEMAN1DIR) \
		$(INST_MAN3DIR) $(DESTINSTALLSITEMAN3DIR)
	$(NOECHO) $(WARN_IF_OLD_PACKLIST) \
		$(PERL_ARCHLIB)/auto/$(FULLEXT)

pure_vendor_install :: all
	$(NOECHO) umask 022; $(MOD_INSTALL) \
		$(INST_LIB) $(DESTINSTALLVENDORLIB) \
		$(INST_ARCHLIB) $(DESTINSTALLVENDORARCH) \
		$(INST_BIN) $(DESTINSTALLVENDORBIN) \
		$(INST_SCRIPT) $(DESTINSTALLVENDORSCRIPT) \
		$(INST_MAN1DIR) $(DESTINSTALLVENDORMAN1DIR) \
		$(INST_MAN3DIR) $(DESTINSTALLVENDORMAN3DIR)

doc_perl_install :: all

doc_site_install :: all
	$(NOECHO) $(ECHO) Appending installation info to $(DESTINSTALLSITEARCH)/perllocal.pod
	-$(NOECHO) umask 02; $(MKPATH) $(DESTINSTALLSITEARCH)
	-$(NOECHO) umask 02; $(DOC_INSTALL) \
		"Module" "$(NAME)" \
		"installed into" "$(INSTALLSITELIB)" \
		LINKTYPE "$(LINKTYPE)" \
		VERSION "$(VERSION)" \
		EXE_FILES "$(EXE_FILES)" \
		>> $(DESTINSTALLSITEARCH)/perllocal.pod

doc_vendor_install :: all


uninstall :: uninstall_from_$(INSTALLDIRS)dirs
	$(NOECHO) $(NOOP)

uninstall_from_perldirs ::

uninstall_from_sitedirs ::
	$(NOECHO) $(UNINSTALL) $(SITEARCHEXP)/auto/$(FULLEXT)/.packlist

uninstall_from_vendordirs ::



# --- MakeMaker force section:
# Phony target to force checking subdirectories.
FORCE :
	$(NOECHO) $(NOOP)


# --- MakeMaker perldepend section:


# --- MakeMaker makefile section:
# We take a very conservative approach here, but it's worth it.
# We move Makefile to Makefile.old here to avoid gnu make looping.
$(FIRST_MAKEFILE) : Makefile.PL $(CONFIGDEP)
	$(NOECHO) $(ECHO) "Makefile out-of-date with respect to $?"
	$(NOECHO) $(ECHO) "Cleaning current config before rebuilding Makefile..."
	-$(NOECHO) $(RM_F) $(MAKEFILE_OLD)
	-$(NOECHO) $(MV)   $(FIRST_MAKEFILE) $(MAKEFILE_OLD)
	- $(MAKE) $(USEMAKEFILE) $(MAKEFILE_OLD) clean $(DEV_NULL)
	$(PERLRUN) Makefile.PL 
	$(NOECHO) $(ECHO) "==> Your Makefile has been rebuilt. <=="
	$(NOECHO) $(ECHO) "==> Please rerun the $(MAKE) command.  <=="
	$(FALSE)



# --- MakeMaker staticmake section:

# --- MakeMaker makeaperl section ---
MAP_TARGET    = perl
FULLPERL      = /usr/bin/perl

$(MAP_TARGET) :: static $(MAKE_APERL_FILE)
	$(MAKE) $(USEMAKEFILE) $(MAKE_APERL_FILE) $@

$(MAKE_APERL_FILE) : $(FIRST_MAKEFILE) pm_to_blib
	$(NOECHO) $(ECHO) Writing \"$(MAKE_APERL_FILE)\" for this $(MAP_TARGET)
	$(NOECHO) $(PERLRUNINST) \
		Makefile.PL DIR=Parser:Preproc \
		MAKEFILE=$(MAKE_APERL_FILE) LINKTYPE=static \
		MAKEAPERL=1 NORECURS=1 CCCDLFLAGS=


# --- MakeMaker test section:

TEST_VERBOSE=0
TEST_TYPE=test_$(LINKTYPE)
TEST_FILE = test.pl
TEST_FILES = t/*.t
TESTDB_SW = -d

testdb :: testdb_$(LINKTYPE)

test :: $(TEST_TYPE) subdirs-test

subdirs-test ::
	$(NOECHO) $(NOOP)

subdirs-test ::
	$(NOECHO) cd Parser && $(MAKE) test $(PASTHRU)

subdirs-test ::
	$(NOECHO) cd Preproc && $(MAKE) test $(PASTHRU)


test_dynamic :: pure_all
	PERL_DL_NONLAZY=1 $(FULLPERLRUN) "-MExtUtils::Command::MM" "-e" "test_harness($(TEST_VERBOSE), '$(INST_LIB)', '$(INST_ARCHLIB)')" $(TEST_FILES)

testdb_dynamic :: pure_all
	PERL_DL_NONLAZY=1 $(FULLPERLRUN) $(TESTDB_SW) "-I$(INST_LIB)" "-I$(INST_ARCHLIB)" $(TEST_FILE)

test_ : test_dynamic

test_static :: pure_all $(MAP_TARGET)
	PERL_DL_NONLAZY=1 ./$(MAP_TARGET) "-MExtUtils::Command::MM" "-e" "test_harness($(TEST_VERBOSE), '$(INST_LIB)', '$(INST_ARCHLIB)')" $(TEST_FILES)

testdb_static :: pure_all $(MAP_TARGET)
	PERL_DL_NONLAZY=1 ./$(MAP_TARGET) $(TESTDB_SW) "-I$(INST_LIB)" "-I$(INST_ARCHLIB)" $(TEST_FILE)



# --- MakeMaker ppd section:
# Creates a PPD (Perl Package Description) for a binary distribution.
ppd :
	$(NOECHO) $(ECHO) '<SOFTPKG NAME="$(DISTNAME)" VERSION="$(VERSION)">' > $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    <ABSTRACT>Verilog language utilities and parsing</ABSTRACT>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    <AUTHOR>Wilson Snyder &lt;wsnyder@wsnyder.org&gt;</AUTHOR>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    <IMPLEMENTATION>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Data::Dumper" VERSION="1" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Digest::SHA" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE VERSION="1.34" NAME="Pod::Usage" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Test::" VERSION="1" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="Test::More" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE VERSION="1" NAME="Time::HiRes" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <REQUIRE NAME="warnings::" VERSION="1" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <ARCHITECTURE NAME="x86_64-linux-gnu-thread-multi-5.18" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '        <CODEBASE HREF="" />' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '    </IMPLEMENTATION>' >> $(DISTNAME).ppd
	$(NOECHO) $(ECHO) '</SOFTPKG>' >> $(DISTNAME).ppd


# --- MakeMaker pm_to_blib section:

pm_to_blib : $(FIRST_MAKEFILE) $(TO_INST_PM)
	$(NOECHO) $(ABSPERLRUN) -MExtUtils::Install -e 'pm_to_blib({@ARGV}, '\''$(INST_LIB)/auto'\'', q[$(PM_FILTER)], '\''$(PERM_DIR)'\'')' -- \
	  Netlist/File.pm $(INST_LIB)/Verilog/Netlist/File.pm \
	  Language.pm $(INST_LIB)/Verilog/Language.pm \
	  Netlist/Logger.pm $(INST_LIB)/Verilog/Netlist/Logger.pm \
	  Netlist/Subclass.pm $(INST_LIB)/Verilog/Netlist/Subclass.pm \
	  Std.pm $(INST_LIB)/Verilog/Std.pm \
	  Netlist/Defparam.pm $(INST_LIB)/Verilog/Netlist/Defparam.pm \
	  Getopt.pm $(INST_LIB)/Verilog/Getopt.pm \
	  EditFiles.pm $(INST_LIB)/Verilog/EditFiles.pm \
	  Netlist.pm $(INST_LIB)/Verilog/Netlist.pm \
	  Verilog-Perl.pod $(INST_LIB)/Verilog/Verilog-Perl.pod \
	  Netlist/Interface.pm $(INST_LIB)/Verilog/Netlist/Interface.pm \
	  Netlist/Port.pm $(INST_LIB)/Verilog/Netlist/Port.pm \
	  Netlist/ModPort.pm $(INST_LIB)/Verilog/Netlist/ModPort.pm \
	  Netlist/Net.pm $(INST_LIB)/Verilog/Netlist/Net.pm \
	  Netlist/Module.pm $(INST_LIB)/Verilog/Netlist/Module.pm \
	  Netlist/ContAssign.pm $(INST_LIB)/Verilog/Netlist/ContAssign.pm \
	  Netlist/Cell.pm $(INST_LIB)/Verilog/Netlist/Cell.pm \
	  Netlist/Pin.pm $(INST_LIB)/Verilog/Netlist/Pin.pm 
	$(NOECHO) $(TOUCH) pm_to_blib


# --- MakeMaker selfdocument section:


# --- MakeMaker postamble section:
OPTIMIZE = -O -g  

all:: README

README: Verilog-Perl.pod
	-$(RM_RF) $@
	pod2text --loose $< > $@

clean::
	-$(RM_RF) simv .vpassert test_dir *.tmp

dist: maintainer-copy distcheck README

## Maintainer use:
preexist:
	svnorcvs nexists $(DISTNAME)_$(VERSION_SYM)
	test -s README

tag:
	svnorcvs tag  $(DISTNAME)_$(VERSION_SYM)

maintainer-diff:
	svnorcvs diff $(DISTNAME)_$(VERSION_SYM)

maintainer-dist: preexist dist tag
	svnorcvs release $(DISTVNAME).tar.gz

maintainer-copy:

maintainer-clean:: distclean
	-$(RM_RF) README Makefile MANIFEST.bak $(MAKEFILE_OLD) */gen

## cppcheck
CPPCHECK = cppcheck
CPPCHECK_FLAGS = --enable=all --inline-suppr
CPPCHECK_CPP = $(wildcard */*.cpp)
CPPCHECK_DEP = $(subst .cpp,.cppcheck,$(CPPCHECK_CPP))

cppcheck: $(CPPCHECK_DEP)
%.cppcheck: %.cpp
	$(CPPCHECK) $(CPPCHECK_FLAGS) $<


# End.
