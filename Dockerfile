FROM nginx:alpine
COPY /dist/angular-project /usr/share/nginx/html
EXPOSE 80