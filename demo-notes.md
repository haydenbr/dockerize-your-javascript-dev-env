# Demos

## Docker Intro

```bash

docker container run -it --name ubuntu-example ubuntu bash
# -i container reads from stdin
# -t pseudo terminal
ps # looks and feels like debian, but is it?
vim
ifconfig
man
touch bob.txt
echo "bob is cool" >> bob.txt # this was persisted to copy on write layer

docker container run -p 8080:80 --name web-server nginx
# publish ports. network traffic on port 8080 on host is channeled to port 80 in container

```

## Deps Example

```bash

# show there's no node_modules
yarn start
# search for TODO:example
# title: 'Docker is cool!', message: 'Hey, you should run your apps in containers!'
# watch the live reload!

```

### Notes

#### Benefits

- developers always using the exact same node_modules!
- no more "works on my machine" between developers
- yarn scripts: Docker is just underneath the hood

#### The image

- ENV: set env variables
- RUN: fewer the layers the better
- WORKDIR:
	- set current working directory
	- changes are made relative to this dir
	- defines working directory when container starts
- ADD/COPY: add files to image
- what is docker/package.json? Why would I do this?
- EXPOSE: doesn't do anything. metadata, documentation as code
- CMD:
	- default process with which to start container (PID 1)
	- overwrite by appending command and args to end of `docker run` or in compose file
	- CMD vs. ENTRYPOINT
- Observe: Things that change most towards end
- Observe: No source in the image


#### Compose file

- cli isn't practical
- compose abstracts things you can do with cli into a config file
- `docker-compose up`, which was my `yarn start`
- compose also let's you define multiple containers or "services"
- volumes: plug in source and config files (dev workflow)
- ports exposed for running app and dev server

#### bump.js

- new image built for every version
- explain flow
	- check if new version tag exists
	- update package.json
	- update any reference to version number
		- compose files
		- bitbucket pipelines
		- config files
	- commit and tag
	- docker build and push
	- git push
- push last because of CI
- small window for conflicts
- for dev only / for prod: build on build server

<!-- TODO: retest this workflow -->
#### benefits

add a dep?

```bash
yarn dep:add pirate-speak
```

```JavaScript
import { translate } from 'pirate-speak';

// ...

translate('Alert text');
```

old version? Bug in older release?

```bash
get checkout v0
# point out difference in deps
yarn start
```

CI Bonus: use already installed deps, half the build time

#### downsides

- no language support (depends on local node_modules)
- still need deps for workflow tasks
- future state: not need ANY deps installed
- not perfect: suggestions are welcome :)

### Full stack example

```bash
git clone
cd new-years
git submodule init
git submodule update
yarn start

# check it on the browser
# add some data

CTRL-C

yarn down
yarn start

# check the data is still there
# connect on mongo client
```

#### Dev conerns

- Debugging? I'm glad you asked
	- turn on debugger in vscode
	- open up get all controller and set break point
	- issue get request from postman
- Seed data?
	- seed script `prestart`
	- or image with seed data
- Seed Image
	- look at image
	- look in data/db

#### Compose files

- how are the containers able to talk to each other? I'm glad you asked
	- brdige networking provides automatic DNS resolution between containers
	- they have their own ip address on the network, but we can refer to them by name
- Persistence
	- containers are persistent, but ephemeral
	- expect containers to be thrown away
	- store important data outside of containers
- Docker volumes
	- we can plug in local directories
	- Docker managed volumes: mongo data

Client compose file: not that different. just added networks

#### Images

Client image

- multi-stage build
	- smallest images possible
	- node of the extra deps end up in final image
- source?
	- dev plug in source
	- prod include source
	- ship and run!
