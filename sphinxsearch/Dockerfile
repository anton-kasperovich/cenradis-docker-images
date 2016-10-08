FROM centos:6

# environment variables
ENV SPHINX_VERSION=2.2.11-release
ENV SPHINX_LOG_DIR=/var/sphinx/log
ENV SPHINX_INDEX_DIR=/var/sphinx/idx

# add public key
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6

# install dependencies
RUN yum install -y -q wget \
    tar \
    autoconf \
    automake \
    libtool \
    gcc-c++ \
    expat-devel && \
    yum clean all

# download sphinxsearch source and extract it
RUN wget -nv -O - http://sphinxsearch.com/files/sphinx-${SPHINX_VERSION}.tar.gz | tar zx

# compile and install sphinxsearch
RUN cd sphinx-${SPHINX_VERSION} && \
    ./configure --enable-id64 \
        --with-libexpat \
        --with-iconv \
        --without-mysql \
        --without-pgsql \
        --without-unixodbc && \
    make && \
    make install

# clean up
RUN rm -rf sphinx-${SPHINX_VERSION}/

# expose ports
EXPOSE 9312 9306

# prepare directories
RUN mkdir -p ${SPHINX_INDEX_DIR} && \
    mkdir -p ${SPHINX_LOG_DIR}

# create user and add him into group
RUN groupadd -r sphinx && \
    useradd -r -g sphinx sphinx && \
    chown -R sphinx:sphinx /var/sphinx ${SPHINX_INDEX_DIR} ${SPHINX_LOG_DIR}

# expose directories
VOLUME ["${SPHINX_INDEX_DIR}", "${SPHINX_LOG_DIR}"]

# scripts
COPY searchd.sh /usr/local/bin/
COPY indexall.sh /usr/local/bin/
RUN chmod a+x /usr/local/bin/searchd.sh /usr/local/bin/indexall.sh

# change user on custom one
USER sphinx

CMD ["/usr/local/bin/indexall.sh"]
