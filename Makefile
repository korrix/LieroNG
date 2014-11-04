.PHONY: build doc run

default: build run

build:
	rm -r bin
	mkdir bin
	zip -r bin/LieroNG.love -x@.zipignore .

run:
	love bin/LieroNG.love

