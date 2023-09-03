# define the build directory
build_directory = ./build
debug_directory = ./debug
stm8_mcu = stm8l151k6

build:
# check if build directory exists, if not create it

	@if [ ! -d ${build_directory} ]; then \
		mkdir ${build_directory}; \
	fi

	@sdcc -V -mstm8 -o ${build_directory}/main.ihx main.c

flash:
	@stm8flash -c stlinkv2 -p ${stm8_mcu} -w ${build_directory}/main.ihx

debug:
	@if [ ! -d ${debug_directory} ]; then \
		mkdir ${debug_directory}; \
	fi

	@sdcc -V -mstm8 -o ${debug_directory}/main.elf --debug --out-fmt-elf main.c

openocd:
	@openocd -f /usr/share/openocd/scripts/interface/st-link.cfg -f /usr/share/openocd/scripts/target/stm8l.cfg -c "init" -c "reset halt"

clean:
	@rm -rf ${build_directory}
	@rm -rf ${debug_directory}