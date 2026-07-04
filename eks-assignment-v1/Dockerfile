FROM nginx:1.27-alpine

WORKDIR /usr/share/nginx/html

COPY index.html ./
COPY favicon.ico ./
COPY js/ ./js/
COPY style/ ./style/
COPY meta/ ./meta/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
