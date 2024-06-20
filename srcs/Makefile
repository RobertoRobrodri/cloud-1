# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jalvarad <jalvarad@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/06/03 13:30:42 by jalvarad          #+#    #+#              #
#    Updated: 2023/06/15 11:03:54 by jalvarad         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


SERVER_NAME=jalvarad.42.fr
# Directory where SSL certificates are located
SSL_DIR=requirements/nginx/conf/openssl

# SSL certificates
SSL_CERTS=$(SSL_DIR)/$(SERVER_NAME).crt $(SSL_DIR)/$(SERVER_NAME).key

all: ssl up

# Check if SSL certificates exist, create them if they don't
ssl: $(SSL_CERTS)

$(SSL_DIR)/%.crt $(SSL_DIR)/%.key:
	cd requirements/nginx/conf/openssl && chmod 777 ssl.sh && ./ssl.sh $(SERVER_NAME)

# Build the Docker Compose services
build:
	docker compose -f docker-compose.yml build --no-cache

# Start the Docker Compose services
up:
	mkdir -p ./data/mariadb
	mkdir -p ./data/wordpress
	docker compose -f docker-compose.yml up -d

# Stop the Docker Compose services
stop:
	docker compose -f docker-compose.yml stop

# Restart the Docker Compose services
restart:
	docker compose -f docker-compose.yml restart

# Destroy the Docker Compose services
destroy:
	docker compose -f docker-compose.yml down --rmi all

# Clean up Docker
clean:
	docker compose -f docker-compose.yml down --rmi all
	docker volume rm mariadb wordpress
	docker system prune -f
	rm -rf data

.PHONY: all up down ssl build start destroy stop restart clean