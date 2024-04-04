## vtwrap

## (auto translated original README with minor corrections)
This program is a terminal wrapper that translates VT52 Esc-sequences into VT100-compatible, allowing you to run old programs that only support VT52 mode. The program is designed to [work with] the local encoding KOI8-R (when emulating CM7209 or 15IE).

The program has been tested on OpenBSD and Linux (requires pmake package).
It should also work on NetBSD and FreeBSD (possibly with a few tweaks).

Program usage:

```
vtwrap [-s] [-t тип]

-s	- clears the 8th bit of the character
-t type	- selects the type of emulated terminal:
		none	- no emulation, made for functionality,
			      which was too trivial to add to the program ;)
		vt52	- emulated DEC VT52 terminal
		cm7209	- emulates a Polish VT52 compatible terminal
			      СМ7209 with uppercase Russian letters instead of lowercase
			      English ones
		15ie	- emulated Elektronika 15IE (in VT52 mode)
```

After starting the program, a copy of the shell is launched from which you can work already as with VT52.

Disclaimer: publishing this code to keep it available since it is no longer available from the original location.

### Compiling
```
$ gcc -g -O2 -o vtwrap *.c -lutil
```

### Source
https://web.archive.org/web/20170130034315/http://pdp-11.org.ru/~form/openbsd/files/misc/vtwrap.tar.gz

## Original README

Данная программа представляет собой терминальный врапер, транслирующий
VT52 Esc-последовательности в VT100-совместимые, позволояющий запускать
старые программы, поддерживающие только режим VT52. Программа расчитана
на локальную кодировку KOI8-R (при эмуляции СМ7209 или 15ИЭ).

Программа проверена в OpenBSD и Linux (требуется пакет pmake).
Должна также работать в NetBSD и FreeBSD (возможно с небольшими переделками).

Использование программы:

```
vtwrap [-s] [-t тип]

-s	- заставляет очищать 8-ой бит символа
-t тип	- выбирает тип эмулируемого терминала:
		none	- эмуляция отсутствует, сделано для функционала,
			  который было лень добавлять в программу ;)
		vt52	- эмулируется DEC VT52 терминал
		cm7209	- эмулируется польский VT52-совместимый терминал
			  СМ7209 с большими русскими буквами вместо маленьких
			  английских
		15ie	- эмулируется Электроника 15ИЭ (в режиме VT52)
```

После запуска программы запускается копия shell из которого можно работать
уже как с VT52.

