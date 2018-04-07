FROM openresty/openresty:alpine

LABEL maintainer="Dylan Reimerink <97.dylan@gmail.com>"

ADD lua /usr/local/openresty/lualib/resty
ADD timeCFunc.so /usr/lib/libtimeCFunc.so
ADD nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80