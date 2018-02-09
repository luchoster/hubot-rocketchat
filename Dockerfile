FROM node:4.5.0
MAINTAINER Luchoster <luchoster@gmail.com>

RUN npm install -g coffee-script yo generator-hubot  &&  \
  useradd hubot -m

USER hubot

WORKDIR /home/hubot

ENV BOT_NAME "watson"
ENV BOT_OWNER "No owner specified"
ENV BOT_DESC "Hubot with rocketbot adapter"

# ENV EXTERNAL_SCRIPTS=

RUN yo hubot --owner="$BOT_OWNER" --name="$BOT_NAME" --description="$BOT_DESC" --defaults && \
  npm install hubot-rocketchat

CMD if [ ! -z "$EXTERNAL_DEPENDENCIES" ]; then npm install $(node -e "console.log('$EXTERNAL_DEPENDENCIES'.split(',').join(' '))"); fi && \
  bin/hubot -n $BOT_NAME -a rocketchat
