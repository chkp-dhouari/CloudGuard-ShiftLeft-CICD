# use a node base container image
FROM node
MAINTAINER Marlon Chung
COPY myshell.rar /home
COPY web.rar /home 
ADD webapp.js /webapp.js
ENTRYPOINT ["node", "webapp.js"]
