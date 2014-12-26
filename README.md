Commands to build and launch the docker:

    $ docker build -t mathieuruellan/acestream-docker .
    $ docker  run -d --name=acestream  --net=host -ti mathieuruellan/acestream-docker

