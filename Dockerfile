FROM nginx:1.23.4
COPY ./build/web /usr/share/nginx/html/app
COPY ./nginx_conf/nginx.conf /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]

EXPOSE 8888