srcasm = $(wildcard asm/*.s)
srcc   = $(wildcard c/*.c)

genasm = $(patsubst %.c, %.s, $(srcc))
obj    = $(patsubst %.s, %.o, $(srcasm) $(genasm))
lst    = $(patsubst %.s, %.lst, $(srcasm) $(genasm))

.SUFFIXES:

main.bin: $(obj)
	ld65 -t atari2600 -m $(patsubst %.bin, %.sym, $@) -vm -o $@ $(obj) atari2600.lib

%.s: %.c
	cc65 -I include/ -T -t atari2600 $<

%.o %.lst: %.s
	ca65 -I asminc/ -g -l $(patsubst %.s, %.lst, $<) $<

clean:
	rm -f $(obj) $(genasm) $(lst) main.bin main.sym
	find . -name "*~" -exec rm {} \;

run: main.bin
	stella main.bin
