FROM debian
MAINTAINER Mathieu Ruellan
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install wget python2.7 libpython2.7 python-pkg-resources python-m2crypto python-apsw python-setuptools --assume-yes
RUN wget http://dl.acestream.org/debian/7/acestream_3.0.2_debian_7.4_x86_64.tar.gz && \
tar zxvf acestream_3.0.2_debian_7.4_x86_64.tar.gz && \
mv acestream_3.0.2_debian_7.4_x86_64 acestream
ADD /launch.sh /launch.sh
CMD bash /launch.sh
