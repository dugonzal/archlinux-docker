# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    script.sh                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dugonzal <dugonzal@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/05/19 01:48:09 by dugonzal          #+#    #+#              #
#    Updated: 2023/05/19 01:48:10 by dugonzal         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/zsh

echo -n "Nombre de la imagen: "
read nameImage

echo -n "Nombre del contenedor: "
read nameContainer

if [[ $1 == "build" ]]; then
    docker build -t $nameImage .
elif [[ $1 == "test" ]]; then
    docker run -it --rm $nameImage
elif [[ $1 == "run" ]]; then
    docker run -it --rm --name $nameContainer -p 80:80 -v $(pwd):/workdir $nameImage
elif [[ $1 == "clean" ]]; then
    docker rmi $nameImage
elif [[ $1 == "fclean" ]]; then
    docker rmi $(docker images -q -f dangling=true)
    docker rmi $(docker images -q)
else
    echo "Opción inválida"
    echo "Uso: ./script.sh [build|test|run|clean|fclean]"
    exit 1
fi
