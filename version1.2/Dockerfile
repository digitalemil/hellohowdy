FROM digitalemil/myrepo:centos72
COPY ../version1.1/lib/opt/node694 /opt/node694
COPY . /opt/app
RUN ln -s /opt/node694 /opt/node
ENV PATH=/opt/node/bin:${PATH}

ENTRYPOINT /opt/node/bin/node /opt/app/bin/www

