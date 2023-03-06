# Stage 1: Build and compile the frontend (Sass files) with Node.js.
FROM node:18.14.1 as build-stage
WORKDIR /app
COPY package*.json /app/
RUN npm install
COPY ./ /app/
RUN npm run compile:sass

# Stage 2: Have the compiled app ready for production with Nginx.
FROM nginx:1.22.1
COPY --from=build-stage /app/src/ /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
