# Use node image as base
FROM node:18.17.1-alpine AS build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the entire project to the working directory
COPY . .

# Build the Angular app for production
RUN npm run build --prod

# Use nginx image as the base for the final image
FROM nginx:alpine

# Copy the built Angular app from the previous stage to nginx directory
# COPY ./conf/default.conf /etc/nginx/conf.d/default.conf
RUN rm -rf /usr/share/nginx/html
# COPY --from=builder /app/dist/ /usr/share/nginx/html    
COPY --from=build /app/dist/ /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start nginx when the container starts
CMD ["nginx", "-g", "daemon off;"]
