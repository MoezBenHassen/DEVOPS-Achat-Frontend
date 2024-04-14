FROM node:12.18.3-alpine as build

WORKDIR /dist/src/app

RUN npm cache clean --force

COPY . .
RUN npm install --force
RUN npm run build --prod

FROM nginx:latest as ngi

COPY --from=build /dist/src/app/dist/crudtuto-Front /usr/share/nginx/html
COPY /nginx.conf /etc/nginx/conf.d/default.conf


EXPOSE 4200