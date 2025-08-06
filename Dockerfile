FROM node:18 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install


FROM node:18
WORKDIR /app
COPY --from=builder /app/package*.json ./
RUN npm install --omit=dev
COPY --from=builder /app/dist ./dist
CMD ["node", "dist/index.js"]