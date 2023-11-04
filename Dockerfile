
FROM node:14 AS builder


WORKDIR /app

# Copy the package.json and package-lock.json files to the container
COPY package*.json ./

# Install the project dependencies
RUN npm install

# Copy the entire project to the container
COPY . .

# Build the Angular app in production mode
RUN npm run build --prod


# Use the official Nginx image as the base image for serving the Angular app
FROM nginx:latest

# Copy the built Angular app from the builder stage to the NGINX web root directory
COPY --from=builder /app/dist/ /usr/share/nginx/html/

# Expose port 80 for the NGINX web server
EXPOSE 80

# Start NGINX when the container starts
CMD ["nginx", "-g", "daemon off;"]
