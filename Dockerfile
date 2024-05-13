FROM node:16
WORKDIR /usr/src/app
COPY package*.json ./

COPY . .

RUN yarn

EXPOSE 3000
ENTRYPOINT [ "yarn", "start" ]
