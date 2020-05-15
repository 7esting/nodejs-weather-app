## Update npm and Node.js
sudo yum install nodejs-6.17.1-1.el7.x86_64
sudo npm cache clean -f
sudo npm install -g n
sudo n stable

## Create Node.js project
npx express-generator
npm install
## Installing modules
npm install <module-name>

## Run Node.js application
npm run start

npm start

npm app.js

# Delete package-lock.json and recreate
run `npm audit fix` to fix them, or `npm audit` for details
npm i --package-lock-only
npm audit fix
npm audit

## Build docker image with tag <your username>/node-web-app
docker build -t <your username>/node-web-app


