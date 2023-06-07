NAME     		= libftprintf.a
LIBFT_PATH		= ./libft
LIBFT_A			= ./libft/libft.a
LIBFT_OBJECTS	= $(LIBFT_PATH)/*.o
EXEC_BIN_NAME	= a.out

MANDATORY_DIR	= .
CFLAGS   		= -Wall -Wextra -Werror
CFLAGS_DEBUG	= $(CFLAGS) -g -fsanitize=address,undefined
INCLUDE_DIR	 	= $(MANDATORY_DIR)/includes $(LIBFT_PATH)
INCLUDE_OPTION	= $(addprefix -I ,$(INCLUDE_DIR))
INCLUDE_FILES	= $(addsuffix /*.h,$(INCLUDE_DIR))
SRC_FILES    	= $(wildcard $(MANDATORY_DIR)/src/**/*.c) $(wildcard $(MANDATORY_DIR)/src/*.c) $(wildcard $(MANDATORY_DIR)/src/**/**/*.c)
SRC_OBJECTS  	= $(SRC_FILES:.c=.o)

BONUS_DIR				= $(MANDATORY_DIR)
BONUS_INCLUDES	 		= $(INCLUDE_DIR)
BONUS_INCLUDE_OPTION	= $(INCLUDE_OPTION)
BONUS_INCLUDE_FILES		= $(INCLUDE_FILES)
BONUS_SRC_FILES    		= $(SRC_FILES)
BONUS_SRC_OBJECTS  		= $(SRC_OBJECTS)

RM	= rm -f
CC	= cc

all: $(NAME)

$(NAME): $(SRC_OBJECTS) $(LIBFT_OBJECTS)
	ar rc $(NAME) $(SRC_OBJECTS) $(LIBFT_OBJECTS)

bonus: all

$(LIBFT_OBJECTS):
	make -C $(LIBFT_PATH)

%_bonus.o: %_bonus.c
	$(CC) $(BONUS_INCLUDE_OPTION) $(CFLAGS) -c $< -o $@

%.o: %.c
	$(CC) $(INCLUDE_OPTION) $(CFLAGS) -c $< -o $@

clean:
	$(RM) $(SRC_OBJECTS)
	$(RM) $(BONUS_SRC_OBJECTS)
	make -C $(LIBFT_PATH) clean

fclean: clean
	$(RM) $(NAME)
	make -C $(LIBFT_PATH) fclean

re: fclean all

setup:
	$(RM) compile_commands.json
	compiledb make
	compiledb make bonus

main: $(SRC_FILES) $(LIBFT_A)
	$(CC) $(INCLUDE_OPTION) $(CFLAGS) -o $(EXEC_BIN_NAME) $^ $(LIBFT_A)
	./$(EXEC_BIN_NAME)

debug: $(SRC_FILES) $(LIBFT_A)
	$(CC) $(INCLUDE_OPTION) $(CFLAGS_DEBUG) -o $(EXEC_BIN_NAME) $^ $(LIBFT_A)
	./$(EXEC_BIN_NAME)

bmain: $(BONUS_SRC_FILES) $(LIBFT_A)
	$(CC) $(BONUS_INCLUDE_OPTION) $(CFLAGS) -o $(EXEC_BIN_NAME) $^
	./$(EXEC_BIN_NAME)

bdebug: $(BONUS_SRC_FILES) $(LIBFT_A)
	$(CC) $(BONUS_INCLUDE_OPTION) $(CFLAGS_DEBUG) -o $(EXEC_BIN_NAME) $^
	./$(EXEC_BIN_NAME)

norm:
	norminette $(SRCS_FILES) $(INCLUDE_FILES) $(BONUS_SRC_FILES) $(BONUS_INCLUDE_FILES)

.PHONY: all main debug setup clean fclean re norm
