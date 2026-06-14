# syntax=docker/dockerfile:1

# ---- Build stage: compile index.html with Vite ----
FROM node:20-alpine AS build
WORKDIR /app

# Install dependencies first so this layer is cached between content changes
COPY package.json ./
RUN npm install

# Copy the rest of the project (index.html, vite.config.js, public/, ...) and build
COPY . .
RUN npm run build

# ---- Serve stage: serve the built site with Vite ----
FROM node:20-alpine
WORKDIR /app
ENV NODE_ENV=production

# Bring over only what `vite preview` needs to run
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/package.json ./package.json
COPY --from=build /app/vite.config.js ./vite.config.js
COPY --from=build /app/dist ./dist

EXPOSE 4173
CMD ["npm", "run", "preview"]
