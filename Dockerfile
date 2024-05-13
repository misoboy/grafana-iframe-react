FROM node:16
RUN npm install -g yarn
WORKDIR /usr/src/app
COPY package*.json ./

COPY . .

RUN yarn

EXPOSE 4200
CMD [ "yarn", "start" ]
