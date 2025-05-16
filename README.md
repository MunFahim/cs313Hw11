# Data to Ascii Hex | Assembly

Author: Muntasir Fahim

## How to Compile
 First download ```fahimhw11.asm``` and assemble :
```cmd
$ nasm -f elf32 -g -F dwarf -o outputFileName.o fahimhw11.asm
```
>outputFileName.o : `you can choose your own file name, but make to use ".o" to end it`

 Then Link and Load :
```cmd
$ ld -m elf_i386 -o programName outputFileName.o
```
>programName : once again, you can choose your own programName but make sure they are consistent

## Changing Input Data
 To change input data : open -> ```fahimhw11.asm``` -> change data -> recompile
```cmd
1|...
2| input: db 0x83,0x6A,0x88,0xDE,0x9A,0xC3,0x54,0x9A  ; change data in line 2 to your desired data
3|...
```


