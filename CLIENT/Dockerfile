# build stage
FROM node:lts-alpine as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install && npm update 
COPY . .
RUN npm run build

# production stage
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html/cms
EXPOSE 80
VOLUME /usr/share/nginx/html/cms/config
CMD ["nginx", "-g", "daemon off;"]
