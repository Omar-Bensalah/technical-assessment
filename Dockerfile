# Stage 1

FROM node:16-alpine as build

RUN mkdir -p /app

WORKDIR /app

COPY ./technical-assessment/package.json /app

RUN npm install

COPY ./technical-assessment/. /app

RUN npm run build --prod


# Stage 2

FROM nginx:1.17.1-alpine as service

COPY --from=build /app/dist/technical-assessment /usr/share/nginx/html