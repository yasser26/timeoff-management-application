FROM node:18-buster-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    make \
    node-gyp \
    python3 \
    sqlite3 \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY package.json package-lock.json  /app/

RUN npm install -g npm && npm install

COPY . .

ENV NODE_ENV=development

CMD npm start

EXPOSE 3000
