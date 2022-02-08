FROM node:14.16.1

RUN mkdir -p /usr/src/app
ENV PORT 3000

WORKDIR /usr/src/app

COPY package.json /usr/src/app

RUN yarn install --production

COPY . /usr/src/app

RUN yarn run build

EXPOSE 3000
CMD [ "yarn", "start" ]