Build:

    $ git pull https://github.com/mathieuruellan/acestream_docker.git
    $ cd acestream_docker
    $ docker build -t mathieuruellan/acestream-docker .

Launch:

    $ docker  run -d --name=acestream  --net=host -ti mathieuruellan/acestream-docker

