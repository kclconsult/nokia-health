FROM node:11

ENV user node

COPY package.json /home/$user/
COPY . /home/$user/

WORKDIR /home/$user

RUN chown $user --recursive .

USER $user

RUN cat requirements.txt | xargs npm install

RUN npm config set prefix "/home/$user/.npm-packages"
RUN npm install sequelize-cli -g
ENV PATH="/home/$user/.npm-packages/bin:${PATH}"

COPY ./bin/wait-for-it.sh wait-for-it.sh

ENV NODE_ENV production
EXPOSE 3000
CMD ["npm", "start"]
