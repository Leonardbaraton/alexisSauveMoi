##
## EPITECH PROJECT, 2025
## wolframe
## File description:
## First rush of the pool
##


APP_NAME=wolfram
BUILD_DIR=$(shell stack path --local-install-root)/bin

all: build copy

build:
	stack build

copy:
	cp $(BUILD_DIR)/Wolfram-exe ./$(APP_NAME)

clean:
	stack clean
	rm -f ./$(APP_NAME)

fclean: clean
		rm -rf .stack-work

re: fclean all
