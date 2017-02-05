This is a simple Atari (VCS) 2600 framework based on the cc65 compiler
(and ca65 assembler). It allows developing demos or applications for
the Atari 2600 by mixing C and assembly code.

Prerequisite
------------

* Linux (any distribution should do)
* cc65 is required to compile the code.
* Stella is required to run the generated binary

Installing cc65
---------------

    $ git clone https://github.com/cc65/cc65.git
    $ cd cc65
    $ make
    $ prefix=${HOME} make install
    $ echo "export CC65_HOME=${HOME}/share/cc65" >> ~/.bashrc

Installing Stella
-----------------

Stella is packaged by most Linux distributions (Tested with Fedora and
Ubuntu). Otherwise, it can be downloaded from [Stella website][4]

Compiling & Running your code
-----------------------------

    $ make  # This compiles the code with cc65 and generated main.bin
    $ make run  # Runs main.bin in Stella

Writing a VCS demo / app
------------------------

There are mainly 2 files that need to be updated:

* `c/main.c` contains the main loop and the inter-frame logic (for
  instance updating some useful variables).

* `asm/kernal.s` contains what is called the "kernal" (or kernel) in
  the Atari 2600 terminology. It is the code that is responsible for
  drawing a single frame. It is called 50 times per second for a PAL
  setup (60 times per second for NTSC).

Other resources
---------------

* [Stella programmer's Guide][1]
* [cc65 Documentation][2]
* [6502 instructions set][3]

[1]: http://atarihq.com/danb/files/stella.pdf
[2]: http://cc65.github.io/doc/
[3]: http://www.6502.org/tutorials/6502opcodes.html
[4]: https://stella-emu.github.io/
