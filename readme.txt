======================
NodeJS Package Manager
======================
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

======
Docker
======
# Build Docker image with tag njs
docker build -t njs .

# Run Docker image, when container gets stopped, it will be removed
docker run --rm --name nodejsapp -d -p 3000:3000 njs

# Check how may CPU units Docker container is using
docker stats

# Stop Docker container using name
docker container stop nodejsapp

# Login to a shell of a Docker container if there is a shell available
docker exec -it <image> sh
docker run --rm --name linux -it alpine:latest sh

=======
Jenkins
=======
## Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock
# Edit /etc/sudoers
jenkins ALL=(ALL) NOPASSWD: ALL
-Or-
# Add jenkins user to Docker group
ll /var/run/ |grep docker
drwx------.  8 root   root     180 May  6 17:57 docker
-rw-r--r--.  1 root   root       3 May  6 12:59 docker.pid
srw-rw----.  1 root   docker     0 May  6 12:59 docker.sock
chmod o=rw /var/run/docker.sock
ll /var/run/ |grep docker
drwx------.  8 root   root     180 May  6 17:57 docker
-rw-r--r--.  1 root   root       3 May  6 12:59 docker.pid
srw-rw-rw-.  1 root   docker     0 May  6 12:59 docker.sock
getent group |egrep 'docker|jenkins'
docker:x:993:hector
dockerroot:x:992:
jenkins:x:991:
sudo usermod -a -G docker jenkins
getent group |egrep 'docker|jenkins'
docker:x:993:hector,jenkins
dockerroot:x:992:
jenkins:x:991:

================================================
Git - Deployments from STAGING to *master branch
================================================
# * * * Conflicts should be resolved downstream by developers * * *
## Show all local and remote tracking branches
git branch -a

## Sync local master with remote tracking orign/master
git checkout master
git pull

## Checkout STAGING branch
git checkout STAGING

## Merge *master changes into STAGING
git merge master

# Show Local & Remote merge status
git branch --merged HEAD
git branch --merged STAGING
git branch --merged origin/STAGING
git branch --merged <sha>

## Show last 5 commits upto HEAD, in STAGING to grab the commit's to deploy
git log --oneline -5

# Show a commit's changes
git show --color-words <sha>

# Compare commits - continguous commits or range of commits
git diff <older-commit-sha>..HEAD --color-words

## Cherry Pick commits from STAGING to *master branch
git checkout master
git cherry-pick -e <sha-of-commit-we-want-from-STAGING-branch>

# If we want a range of commits
# One new SHA will be create for this commit range
git cherry-pick <shaX>..<shaZ>