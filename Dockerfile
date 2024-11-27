# Stage 1: Build the React app
FROM node:18 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json (if available)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application source code
COPY . .

# Build the React app
RUN npm run build

# Stage 2: Serve the app using a lightweight web server
FROM nginx:stable-alpine

# Copy the built React app from the previous stage to NGINX's web root
COPY --from=build /app/build /usr/share/nginx/html

# Copy custom NGINX configuration, if necessary
# Uncomment the following line if you have a custom nginx.conf
# COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80 to the outside world
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]