##
## EPITECH PROJECT, 2023
## alexispacaud
## File description:
## makefile
##

APP_NAME=imageCompressor
BUILD_DIR=$(shell stack path --local-install-root)/bin

all: build copy

build:
	stack build

copy:
	cp $(BUILD_DIR)/imagecompressor-exe ./$(APP_NAME)

clean:
	stack clean
	rm -f $(APP_NAME)
