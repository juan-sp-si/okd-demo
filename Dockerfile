FROM node:12.22.1-buster-slim
WORKDIR /usr/src/app
COPY package.json ./
RUN npm install
COPY . .
EXPOSE 8080
USER 1001
CMD [ "node", "server.js" ]
