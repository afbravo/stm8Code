# STM8L15xx6 Coding

This repository contains code for the stm8l151. The purpose is to demonstrate the capabilities
of the dev board developed under the stm8l151k6t6_board repository. In here you will find:

- Examples
- Library
- Template

### Examples

Contains 5 examples that demonstrate the capabilities of the board. Each example is located in its own directory. The examples are:

- LED: This example simply turns on the LED on the board.
- BTN: This example turns on the LED when the button is pressed.
- Blink: This example blinks the LED on the board using the internal timer.
- Clocks: This example demonstrates the use of the different clocks available on the board.
- UART: This example demonstrates the use of the UART peripheral.

### Library

Contains a modified version of the STM8 SPL. The modification were made to be compatible with the SDCC compiler.
For documentation see the library itself.

### Template

Contains a template project that can be used to start a new project. It contains the Makefile.

# Compiling the project

AS I mainly use Linux for my developement, I use the [SDCC](http://sdcc.sourceforge.net/) compiler. It is a free and open source compiler
or 8-bit microcontrollers. It is available for Linux, Windows and Mac OS X. It is also available as a package for most Linux distributions.

ST Microelectronics suggests to use the Cocmic C compiler for the stm8. However, since its not easily supported for linux, I decided to avoid it.
This becomes troublesome when using the STM8 SPL which required some modifications to work with SDCC.

Please follow the instructions on the [SDCC](http://sdcc.sourceforge.net/) website to install it on your system.

## How to compile project

You can natively compile the project by running the following command:

```bash

sdcc -mstm8 <source_file.c>

```

However, to make things easier, I have created a Makefile which will compile the project and generate the hex file. To compile the project, run the following command:

```bash

make

```

To clean the project, run the following command:

```bash

make clean

```

# Flashing the board

To flash the board, I use the ST-Link V2 programmer. It's a easy to use programmer that provides the SWIM interface to program the STM8. It is also supported by the OpenOCD project.
However, using the opensource approached, I've decided to use the stm8flash tool. It is a simple tool that allows to flash (and more) the STM8 using the ST-Link V2 programmer.

To install stm8flash, follow the instructions on the [stm8flash](https://www.google.com).

## How to flash the board

Since when we compile, the output file is in .ihx format (intel hex) we can easily flash the board as it is supported by stm8flash. To flash the board, run the following command
inside the project directory:

```bash

stm8flash -c stlinkv2 -p stm8l151k6 -w <project_name>.ihx

```

We used stlinkv2 as the programmer, stm8l151k6 as the target and the -w flag to write the ihx file to the board. If you are using a different programmer or different stm8 version,
please refer to the stm8flash documentation.

# Debugging

To Do
