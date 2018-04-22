FROM node:8.11.1-alpine

RUN mkdir /app && \
	apk update && \
	apk add make
WORKDIR /app

COPY package.json package.json
RUN yarn && yarn cache clean
COPY src src

EXPOSE 3000

ENTRYPOINT [ "npm", "run", "serve" ]
