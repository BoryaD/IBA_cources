Task 1:
    Result of ps -a:

        CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                      PORTS               NAMES
        cb23ce4537b6        nginx               "/docker-entrypoint.…"   3 minutes ago       Up 3 minutes                80/tcp              romantic_ritchie
        c663a6831e97        nginx               "/docker-entrypoint.…"   3 minutes ago       Exited (0) 2 minutes ago                        distracted_solomon
        7b3647134be4        nginx               "/docker-entrypoint.…"   3 minutes ago       Exited (0) 2 minutes ago                        boring_carson


Task 2:
    Result of ps -a:

        CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES

    Result of docker images:

        REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE


Task 3:
    Secret message is:
        "Docker is easy"

    Commands:
        docker run -it devopsdockeruh/exec_bash_exercise

        docker exec  nostalgic_khorana tail -f ./logs.txt


Task 4:
<!-- Question: Why cntrl+c don't work while running container without "-ti" -->
    Dockerfile:

        FROM devopsdockeruh/overwrite_cmd_exercise

        CMD ["-c"]

    Build command:
        docker build -t docker-sequence .


Task 5:
    Command:
        docker run -itd --name test --mount type=bind,source=/home/ec2-user/app/logs.txt,target=/usr/app/logs.txt devopsdockeruh/first_volume_exercise


Task 6:
    Command:
        docker run -d --name test -p 8080:80 devopsdockeruh/ports_exercise

Task 7:
    Dockerfile:
        FROM ubuntu:16.04

        RUN apt-get update
        RUN apt-get install -y git
        RUN apt-get install -y curl
        RUN git clone https://github.com/docker-hy/frontend-example-docker
        WORKDIR /frontend-example-docker
        RUN curl -sL https://deb.nodesource.com/setup_10.x |     bash
        RUN apt-get install -y nodejs
        # RUN apt-get install -y npm
        # RUN npm install -g n
        # RUN n latest
        RUN npm install
        # RUN npm install -g serve
        EXPOSE 5000
        # CMD serve -s -l 5000 dist
        CMD npm start
Task 8:
    Dockerfile:
        FROM openjdk:8

        RUN apt-get update
        RUN apt-get install -y git
        RUN git clone https://github.com/docker-hy/spring-example-project
        WORKDIR /spring-example-project
        RUN ./mvnw package
        EXPOSE 8080

        CMD java -jar ./target/docker-example-1.1.3.jar
