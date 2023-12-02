# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gbrunet <gbrunet@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/11/15 21:35:49 by gbrunet           #+#    #+#              #
#    Updated: 2023/12/02 08:06:21 by gbrunet          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = fdf

CC = cc

CFLAGS = -Wall -Wextra -Werror -I$(X11)

LIBFT = libft

MINILIBX = minilibx-linux

X11 = /usr/X11/include

X11LIB = $(X11)/../lib

INCLUDES = includes

SRC_DIR = sources/

BONUS_DIR = bonus/

OBJ_DIR = objects/

OBJ_BONUS_DIR = objects/bonus/

SRC_FILES = fdf errors interactions \
		color_helper color_converter image_helper \
		math_helper math_helper_2 \
		draw_line_AA draw_map \
		rotate translate scale \
		hooks mlx \
		file parser
SRC_FILES_BONUS = fdf errors interactions ui\
		color_helper color_converter image_helper \
		math_helper math_helper_2 \
		draw_line_AA draw_map draw_parallel \
		rotate translate scale \
		hooks mlx \
		file parser

SRC = $(addprefix $(SRC_DIR), $(addsuffix .c, $(SRC_FILES)))

SRC_B = $(addprefix $(BONUS_DIR), $(addsuffix _bonus.c, $(SRC_FILES_BONUS))) 

OBJ = $(addprefix $(OBJ_DIR), $(addsuffix .o, $(SRC_FILES)))

OBJ_B = $(addprefix $(OBJ_BONUS_DIR), $(addsuffix _bonus.o, $(SRC_FILES_BONUS)))

$(OBJ_DIR)%.o: $(SRC_DIR)%.c
	mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) $(INCLUDE) -c $< -o $@
	
$(OBJ_BONUS_DIR)%.o: $(BONUS_DIR)%.c
	mkdir -p $(OBJ_BONUS_DIR)
	$(CC) $(CFLAGS) $(INCLUDE) -c $< -o $@

MLX = -lmlx -L $(MINILIBX) -lXext -lX11 -lm

.PHONY : all clean fclean re bonus norme

all : $(NAME)

lib :
	make -C $(LIBFT)
	make -C $(MINILIBX)


$(NAME) : lib $(OBJ)
	$(CC) $(CFLAGS) $(OBJ) -o $(NAME) -L $(X11LIB) $(MLX) -lft -L ./libft

clean :
	make clean -C $(LIBFT)
	make clean -C $(MINILIBX)
	$(RM) -rf $(OBJ_DIR)

fclean : clean
	make fclean -C $(LIBFT)
	$(RM) $(NAME)

re : fclean all

bonus : lib $(OBJ_B)
	$(CC) $(CFLAGS) $(OBJ_B) -o $(NAME) $(MLX) -L $(X11LIB) -lft -L ./libft

norme :
	@norminette $(SRC) $(LIBFT) $(SRC_B) | grep -v Norme -B1 || true
	@norminette $(INCLUDES) -R CheckDefine | grep -v Norme -B1 || true

