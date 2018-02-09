FROM node:4.5.0
MAINTAINER Luchoster <luchoster@gmail.com>

RUN npm install -g coffee-script yo generator-hubot  &&  \
  useradd hubot -m

USER hubot

WORKDIR /home/hubot

ENV BOT_NAME "rocketbot"
ENV BOT_OWNER "No owner specified"
ENV BOT_DESC "Hubot with rocketbot adapter"

# ENV EXTERNAL_SCRIPTS=hubot-diagnostics,hubot-help,hubot-google-images,hubot-google-translate,hubot-pugme,hubot-maps,hubot-rules,hubot-shipit

RUN yo hubot --owner="$BOT_OWNER" --name="$BOT_NAME" --description="$BOT_DESC" --defaults && \
  npm install hubot-rocketchat

CMD node -e "console.log(JSON.stringify('$EXTERNAL_SCRIPTS'.split(',')))" > external-scripts.json && \
  npm install $(node -e "console.log('$EXTERNAL_SCRIPTS'.split(',').join(' '))") && \
  if [ ! -z "$EXTERNAL_DEPENDENCIES" ]; then npm install $(node -e "console.log('$EXTERNAL_DEPENDENCIES'.split(',').join(' '))"); fi && \
  bin/hubot -n $BOT_NAME -a rocketchat
