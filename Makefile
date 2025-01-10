##
## EPITECH PROJECT, 2023
## Makefile
## File description:
## makefile
##

MAIN_FILE = Main.hs

EXECUTABLE = doop

GHC_OPTS = -Wall

$(EXECUTABLE): $(MAIN_FILE)
	@echo "Compilation de $(MAIN_FILE)..."
	ghc $(GHC_OPTS) -o $(EXECUTABLE) $(MAIN_FILE)

fclean:
	@echo "Vroum Vroum je nettoye..."
	rm -f $(EXECUTABLE) *.hi *.o

re:	fclean all

all: $(EXECUTABLE)