## Building a computer based on 6502 microprocessor

> This build is inspired by Ben Eater's [project](https://eater.net/6502).

## Prerequisites

1. Python
2. Minipro - [download here](https://gitlab.com/DavidGriffith/minipro).

## 2 ways for programming EEPROM

### 1 - Using assembly language (vasm)

> This is the preferred way

Commands:

1. Write code in assembly ([vasm](http://sun.hasenbraten.de/vasm/index.php?view=main)). Ex: blink.s
2. To assemble run: `./tools/vasm6502_oldstyle -Fbin -dotdir src/blink.s` - this creates output file `a.out` in the current directory.
3. Load to EEPROM `minipro -p AT28C256 -w a.out` - more info on minipro can be
   found [here](https://gitlab.com/DavidGriffith/minipro).

### 2 - Loading machine code to EEPROM:

Commands:

1. Modify machine code inside makerom.py
2. Run `python src/makerom.py` - this generates output file `rom.bin` in the current folder.
3. Load to EEPROM `minipro -p AT28C256 -w rom.bin` - more info on minipro can be found [here](https://gitlab.com/DavidGriffith/minipro).

### Other useful commands

`hexdump -C rom.bin`

`echo "obase=10; ibase=16; 8000" | bc`
