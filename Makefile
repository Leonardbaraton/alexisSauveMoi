APP_NAME=wolfram
BUILD_DIR=$(shell stack path --local-install-root)/bin

all: build copy

build:
	stack build

copy:
	cp $(BUILD_DIR)/Wolfram-exe ./$(APP_NAME)

fclean:
	stack clean
	rm -f ./$(APP_NAME)

re: fclean all