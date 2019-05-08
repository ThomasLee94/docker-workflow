# Naming image for multi-stage building
# Phase 1
FROM node:alpine as builder

WORKDIR '/app'

COPY package*.json .

RUN npm install

COPY . .

RUN npm run build

# Phase 2
FROM nginx 

# -- means from a different phase
COPY --from=builder /app/build /usr/share/nginx/html
