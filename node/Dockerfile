FROM jmfirth/webpack:7-slim

ENV HOME=/workspace

# COPY package.json npm-shrinkwrap.json $HOME/chat/
COPY ./package.json $HOME/
COPY ./docker-up-image.sh /root
WORKDIR $HOME/
RUN 	apt-get update && \
	apt-get install -y man htop

#RUN  yarn global add rimraf npm-cache
#RUN npm-cache install -c /tmp/npm-cache

RUN npm install --cache-min 999999999

VOLUME ["/workspace", "/workspace/node_modules"]
EXPOSE 80
CMD ["/root/docker-up-image.sh"]
