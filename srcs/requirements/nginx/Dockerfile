# Set base image
FROM alpine:3.17

# Update apk and install mariadb package
RUN apk update && apk add nginx

# If this
COPY conf/openssl/jalvarad.42.fr.crt /etc/nginx/certs/server.crt
COPY conf/openssl/jalvarad.42.fr.key /etc/nginx/certs/server.key

# Copy default.conf
COPY conf/default.conf /etc/nginx/http.d/

CMD ["nginx", "-g", "daemon off;"]