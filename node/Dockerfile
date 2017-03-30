FROM jmfirth/webpack:7-slim

ENV HOME=/workspace

WORKDIR $HOME/
# COPY package.json npm-shrinkwrap.json $HOME
COPY ./package.json $HOME/
COPY ./docker-up-image.sh /root
RUN 	apt-get update && \
	apt-get install -y man htop

#RUN  yarn global add rimraf npm-cache
#RUN npm-cache install -c /tmp/npm-cache

RUN npm install --cache-min 999999999 --cache /node-cache

VOLUME ["/workspace", "/workspace/node_modules", "/node-cache", "/var/lib/apt/lists/"]
EXPOSE 80
CMD ["/root/docker-up-image.sh"]
