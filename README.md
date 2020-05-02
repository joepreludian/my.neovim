# Jon's opinionated IDE for Python projects

Welcome to my opinionated neovim configuration;

## Motivation
The main reason for creating this Dockerfile it was because the development of application using containers. Suppose that you install the requirements and use the docker-compose for development;

How can you use the autocomplete on vim? These dependencies should be visible on the host machine. There is two ways to see the dependencies visible;

1. Install the dependencies both on local machine and inside container; enable virtualenv and use your IDE;
2. Run my opinionated nvim with fully working autocomplete ;)

## What I did?
The idea is pretty simple. I installed neovim plus my customizations (you can see all the settings [on my repo](https://github.com/joepreludian/my.vim)) and the ability to work the autocomplete is because I added a configuration on container's python to look for packages at `/app_libs` folder. So you just need to mount this folder pointing to your packages; When using containers you don't need to create a virtualenv for it; so you can map your site-packages directly into my container;

Keep in mind that you should use it only in your development environment;

## Installing

I will suppose that you work with docker-compose; So I will copy and paste an example that I use on my daily work.

```
---
version: "3.7"

services:
  database:
    image: 'docker.io/postgres:11'
  environment:
    POSTGRES_PASSWORD: 302010wiproite
    POSTGRES_DB: wiproite
    POSTGRES_USER: postgres
  volumes:
    - "db_data:/var/lib/postgresql/data"
  web:
    build:
      context: .
      dockerfile: _devops/Dockerfile-django
    volumes:
      - .:/app
      - python_libs:/usr/local/lib/python3.7/site-packages
    command: sh run_dev.sh
    ports:
      - 8000:8000
    environment:
      DB_HOST: database
      DB_USER: postgres
      DB_NAME: wiproite
      DB_PASSWORD: 302010wiproite
      IS_PRODUCTION: 'no'
  ide:
    image: docker.io/joepreludian/neovim
    volumes:
      - .:/app
      - python_libs:/app_libs
  volumes:
    db_data:
    python_libs:
```

Look at the service called "ide". So after you performing you regular `docker-compose up -d` command, you can run the ide by running;

    $ docker-compose exec ide nvim

And happy codding. =)

## Making your own neovim configs;

Fork this repo and use your own configs. I've tried to keep as simple as possible;

## Do you need help?

Create an issue on this repo; I will try to look at it.
