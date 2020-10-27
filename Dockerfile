FROM node:14

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm install
# If you are building your code for production
# RUN npm ci --only=production

# Bundle app source
COPY . .

## START: aws ecs testing only, may be removed when done
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    jq \
    curl \
    && rm -r /var/lib/apt/lists/*


#
RUN export ECS_METADATA_URI=':51678/v1/metadata' \
    && export CONTAINER_IP=$(/sbin/ip route|awk '/default/ { print $3 }') \
    && export ECS_CLUSTER_METADATA=$CONTAINER_IP$ECS_METADATA_URI 

ADD bootstrap.sh bootstrap.sh
RUN chmod +x bootstrap.sh
RUN bash bootstrap.sh
## END: aws ecs testing

EXPOSE 3000
#CMD nmp start
CMD [ "node", "server.js" ]
