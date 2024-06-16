# Use the official Nginx image as base
FROM nginx:latest

# Copy index.html and proportioning.html from local directory into the container at /usr/share/nginx/html
COPY index.html /usr/share/nginx/html
COPY proportioning.html /usr/share/nginx/html

# The default Nginx configuration file is copied over with our custom configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80 to allow outside access to our Nginx server
EXPOSE 80

# Start Nginx when the container launches
CMD ["nginx", "-g", "daemon off;"]
