.PHONY: ${BIN} clean


CC=gcc
CFLAGS = -std=c11 -g -Wall
CFLAGS += -Ilib/glfw/include -Ilib/glad/include
LDFLAGS = lib/glfw/src/libglfw3.a lib/glad/src/glad.o
LDFLAGS += -ldl

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


libs:
	cd lib/glfw && cmake . && make
	cd lib/glad/ && $(CC) -o src/glad.o -Iinclude -c src/glad.c

run: all
	$(BIN)

$(BIN): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -o $@ $(LDFLAGS) 


$(OBJ_DIR)/%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm $(OBJ_DIR)/*.o $(BIN_DIR)/* 
