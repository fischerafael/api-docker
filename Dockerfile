# 1: build
FROM node:18 AS builder

WORKDIR /app

# install deps
COPY package*.json ./
RUN npm install

# copy source code
COPY . . 

# compile TypeScript to JavaScript
RUN npm run build


# 2: prod
FROM node:18

WORKDIR /app

# copies the package.json and package-lock.json from the builder stage
COPY --from=builder /app/package*.json ./
RUN npm install --omit=dev

# copies the compiled JavaScript files from the builder stage
COPY --from=builder /app/dist ./dist

# start the application
CMD ["node", "dist/index.js"]