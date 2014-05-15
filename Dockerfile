FROM dockerfile/ubuntu
MAINTAINER  Christopher Lyth <cjlyth@gmail.com>
RUN apt-get -qy install openssh-client

ONBUILD ADD . /root/.ssh
ONBUILD RUN chmod -R 600 /root/.ssh
ONBUILD RUN chmod 700 /root/.ssh

CMD ["ssh", "-V"]
ENTRYPOINT ["/usr/bin/env"]
