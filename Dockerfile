# FROM node:22.13.1-alpine
# RUN npm install -g netlify-cli
FROM nginx:1.27-alpine
COPY build /usr/share/nginx/html