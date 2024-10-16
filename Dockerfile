# Stage 1: Build the React app
FROM node:18 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and package-lock.json files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the React app for production
RUN npm run build

# Stage 2: Serve the app using a lightweight web server
FROM nginx:alpine

# Copy the build output from the previous stage to the Nginx HTML folder
COPY --from=build /app/build /usr/share/nginx/html

# Expose the default port Nginx listens on
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
