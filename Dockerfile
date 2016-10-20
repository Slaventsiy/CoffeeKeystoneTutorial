FROM node:6
RUN apt-get update; apt-get install -y nodejs-legacy
ADD package.json /modules/package.json
RUN cd /modules && npm install
COPY . /app
RUN ln -s /modules/node_modules /app/node_modules
WORKDIR /app
CMD ["/usr/local/bin/node", "/app/app.js"]