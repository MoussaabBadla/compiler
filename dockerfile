FROM alpine:3.14
RUN  apk update &  apk add build-base flex bison 

COPY . .


CMD ["make", "all"]
