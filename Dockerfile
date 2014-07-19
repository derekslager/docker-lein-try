FROM derekslager/openjdk-7

MAINTAINER Derek Slager <derekslager@gmail.com>

# https://github.com/dotcloud/docker/issues/6345
RUN ln -s -f /bin/true /usr/bin/chfn
RUN adduser --home /home/lein --disabled-password --gecos "" lein

ENV HOME /home/lein

ADD .lein /home/lein/.lein

RUN chown -R lein:lein /home/lein

USER lein

RUN mkdir /home/lein/bin
RUN wget -O /home/lein/bin/lein https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
RUN chmod a+x /home/lein/bin/lein

ENV PATH /home/lein/bin:$PATH

RUN lein

CMD []
ENTRYPOINT ["/home/lein/bin/lein", "try"]
