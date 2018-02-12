#Base Image
FROM nginx:alpine
COPY . /usr/share/nginx/html
