# section for the phase installing all deps and the build
FROM node:alpine as builder 

WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build
## build output will be under /app/build

# section for the run phase
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
## the default cmd will start nginx for uns