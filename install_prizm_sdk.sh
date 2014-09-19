#!/bin/sh
# Simple, customizable install script for the Prizm SDK on unix-like operating systems.
# Written by Mighty Moose <mightymoosemn@gmail.com>
# Loosely based off of Levak's arm toolchain install script, found here: http://hackspire.unsads.com/wiki/index.php/C_and_assembly_development_introduction_on_Linux

TARGET=sh3eb-elf #This is the closest to the Prizm's processor
SRC="/usr/src"
PREFIX="/usr/local/cross" #Or "/path/to/your/directory" - default is "/usr/local/cross"
PARALLEL="" #Make this option "-j" if you have multiple processors, RAM to spare, and want nothing to do for an hour
SDKDIR="/home/$SUDO_USER" #Default is to install the SDK (libfxcg) to the user's home directory, but you can make this what ever you want

#USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)

#You will need the GMP, MPFR, and MPC development libraries to compile GCC.  Also, MKG3A requires libpng and its development libraries as well as cmake.  Install any other dependencies this script spits out at you if it fails.

BINUTILS=binutils-2.22 # http://www.gnu.org/software/binutils/
GCC=gcc-4.6.3 # http://gcc.gnu.org/
MKG3A=mkg3a-0.2a #https://bitbucket.org/tari/mkg3a/downloads/mkg3a-0.2a.tar.gz

chmod a+rw $SRC
mkdir $PREFIX $SRC/$MKG3A $SRC/build-binutils $SRC/build-gcc
cd $SRC

#Note: the rm -rf's in the following sections are not "strictly" necessary, but if you would like to clean up source files and archives after installation, then you should uncomment them.

#Part 1: Get, extract, build, and install BINUTILS

#If build fails at this next part, install necessary dependencies with your package manager of choice, then rerun this script

(wget -c http://ftpmirror.gnu.org/binutils/$BINUTILS.tar.bz2 && tar -xvjf $BINUTILS.tar.bz2 && cd $SRC/build-binutils && ../$BINUTILS/./configure --target=$TARGET --prefix=$PREFIX --disable-nls && make $PARALLEL && make install && cd .. && rm -r build-binutils) || exit 1

export PATH=$PATH:$PREFIX/bin #This is CRUCIAL. Do NOT remove this or build will FAIL!

##rm -rf $BINUTILS $BINUTILS.tar.bz2

#Part 2: Get, extract, build, and install GCC

#Once again, if build fails at the following part, install necessary dependencies and restart this script

(cd $SRC && wget -c http://ftpmirror.gnu.org/gcc/$GCC/$GCC.tar.bz2 && tar -xvjf $GCC.tar.bz2 && cd build-gcc && ../$GCC/./configure --target=$TARGET --prefix=$PREFIX --disable-nls --enable-languages=c,c++ --without-headers && make $PARALLEL all-gcc && make install-gcc && make $PARALLEL all-target-libgcc && make install-target-libgcc && cd .. && rm -r build-gcc) || exit 1

##rm -rf $GCC $GCC.tar.bz2

#Part 3: Get, extract, build, and install MKG3A

(cd $SRC && wget -c https://bitbucket.org/tari/mkg3a/downloads/mkg3a-0.2a.tar.gz && tar -xvzf $MKG3A.tar.gz && cd $MKG3A && cmake . && make $PARALLEL && make install && cd .. && rm -r $MKG3A) || exit 1

##rm -rf $MKG3A $MKG3A.tar.gz

#Part 4: Build and install latest LIBFXCG

(cd $SDKDIR && mkdir PrizmSDK && chmod a+rw PrizmSDK && sudo -u $SUDO_USER git clone https://github.com/Jonimoose/libfxcg.git PrizmSDK && cd PrizmSDK && make $PARALLEL && cd toolchain && cp prizm_rules prizm_rules.bak && head -17 prizm_rules.bak > prizm_rules && echo "PREFIX	:=	$PREFIX/bin/sh3eb-elf-" >> prizm_rules && tail -59 prizm_rules.bak >> prizm_rules) || exit 1

##rm prizm_rules.bak
