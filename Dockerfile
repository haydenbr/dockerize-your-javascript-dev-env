FROM node:8.11.1-alpine

RUN mkdir /opt/app
RUN	apk add --update \
    bash \
    lcms2-dev \
    libpng-dev \
    gcc \
    g++ \
    make \
    autoconf \
    automake \
  	&& rm -rf /var/cache/apk/*
WORKDIR /opt/app

COPY package.json package.json
RUN yarn && yarn cache clean
COPY src src

EXPOSE 3000

ENTRYPOINT [ "npm", "run", "serve" ]
