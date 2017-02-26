NES-boilerplate
====================

This repository contains boilerplate clode for starting a new NES project.

The compiler is [CC65 compiler](http://www.cc65.org/index.php) available at ftp://ftp.musoftware.de/pub/uz/cc65/

Note for Debain/Ubuntu users: When installing with apt-get I have had problems getting the assembler to recognize negative numbers. This can be avoided by compiling and installing from source instead. Download the sources (cc65-sources-2.13.3.tar.bz2), extract and then cd into the directory using the terminal, then build with 'make -f make/gcc.mak' and finally install with 'sudo make -f make/gcc.mak install'.

Some of the code is partly based on a guide by Johan Fjeldtvedt, available [here](http://www.diskusjon.no/index.php?showtopic=519922). The guide is in Norwegian. 
