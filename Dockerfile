FROM node:10
RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app
WORKDIR /home/node/app
COPY package*.json ./
RUN npm install
COPY . .
USER node
ENV newtoken=""
ENTRYPOINT node app.js ${newtoken}
