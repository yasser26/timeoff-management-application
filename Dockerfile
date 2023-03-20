# Docker parent image - Node v18
FROM node:18-buster-slim

# Packages updates and installation of needed
# dependencies from local build process
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    make \
    node-gyp \
    python3 \
    sqlite3 \
  && rm -rf /var/lib/apt/lists/*

# Setting WORDIR and then copy packages json files
WORKDIR /app
COPY package.json package-lock.json  /app/

# Installing dependencies 
RUN npm install -g npm && npm install

COPY . .

ENV NODE_ENV=development

# Run app
CMD npm start

EXPOSE 3000
