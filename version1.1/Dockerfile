FROM digitalemil/myrepo:centos72
COPY lib/opt/node694 /opt/node694
RUN ln -s /opt/node694 /opt/node
ENV PATH=/opt/node/bin:${PATH}

ENTRYPOINT /opt/node/bin/node $MESOS_SANDBOX/bin/www

EXPOSE 3000
