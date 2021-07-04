.PHONY: ${BIN} clean


CC=gcc
CFLAGS=-std=c11 -g -Wall
SRC=src
OBJ_DIR=obj
BIN_DIR=bin
SRCS=$(wildcard $(SRC)/*.c) \
	 $(wildcard $(SRC)/pb/*.c)

C_PATHS=$(dir $(SRCS))
C_FILES:=$(notdir $(SRCS))
OBJS=$(addprefix $(OBJ_DIR)/, $(C_FILES:.c=.o))

$(shell mkdir $(OBJ_DIR)>/dev/null 2>&1)
$(shell mkdir $(BIN_DIR)>/dev/null 2>&1)


BIN=$(BIN_DIR)/main

vpath %.c $(C_PATHS)

all: $(BIN) 

$(BIN): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -o $@ 


$(OBJ_DIR)/%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm $(OBJ_DIR)/*.o $(BIN_DIR)/* 
