FROM soflabs/spark:2.1-hadoop-2.7

# Zeppelin
ENV ZEPPELIN_VERSION 0.7.0
ENV ZEPPELIN_PACKAGE zeppelin-${ZEPPELIN_VERSION}-bin-all
ENV ZEPPELIN_HOME /opt/zeppelin-${ZEPPELIN_VERSION}
ENV ZEPPELIN_PORT 8080
ENV ZEPPELIN_CONF_DIR $ZEPPELIN_HOME/conf
ENV ZEPPELIN_NOTEBOOK_DIR $ZEPPELIN_HOME/notebook
ENV PATH $PATH:${ZEPPELIN_HOME}/bin

RUN set -ex \
 && curl -sL --retry 3 \
   "http://apache.rediris.es/zeppelin/zeppelin-${ZEPPELIN_VERSION}/${ZEPPELIN_PACKAGE}.tgz" \
   | gunzip \
   | tar -x -C /opt/ \
 && mv /opt/${ZEPPELIN_PACKAGE} $ZEPPELIN_HOME \
 && mkdir -p $ZEPPELIN_HOME/logs \
 && mkdir -p $ZEPPELIN_HOME/run \
 && $ZEPPELIN_HOME/bin/install-interpreter.sh -a

 ##&& cp $ZEPPELIN_HOME/conf/shiro.ini.template $ZEPPELIN_HOME/conf/shiro.ini \
 ##&& cp $ZEPPELIN_HOME/conf/zeppelin-site.xml.template $ZEPPELIN_HOME/conf/zeppelin-site.xml \

ADD about.json $ZEPPELIN_NOTEBOOK_DIR/2BTRWA9EV/note.json
WORKDIR $ZEPPELIN_HOME
CMD ["bin/zeppelin.sh"]
