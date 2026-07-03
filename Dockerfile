# Stage 1: Build React app
FROM node:26-slim AS build

WORKDIR /app

COPY package*.json ./
RUN npm install --production

COPY . .
RUN npm run build

# Stage 2: Serve with Nginx
FROM nginx:1.27-alpine

# Copy built React files into Nginx html directory
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Default Nginx command
CMD ["nginx", "-g", "daemon off;"]

