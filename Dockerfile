# Stage 1
FROM node:8 as react-build
WORKDIR ./grupo1-front/
COPY . ./
RUN yarn
RUN yarn build

# Stage 2 - the production environment
FROM nginx:alpine
COPY ./grupo1-front/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=react-build /builddir/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
