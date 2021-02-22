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
# expose is not needed in dev environment
# elastic beanstalk will look for expose instruction and map to this port (80)
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
## the default cmd will start nginx for us