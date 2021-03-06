FROM ubuntu:16.04

#编译mysql
RUN groupadd awd \
    && useradd -g awd -s "/usr/sbin/nologin" awd \
    && apt-get update \
    && apt-get install wget vim  tzdata build-essential libncurses5-dev libfreetype6-dev  pkg-config cmake libxml2-dev openssl libssl-dev libcurl4-gnutls-dev curl libjpeg-dev make libpng-dev libmcrypt-dev libreadline6 libreadline6-dev -y \
    && mkdir -p /usr/local/boost /opt/mysql/data /www  /opt/log \
    && wget http://www.sourceforge.net/projects/boost/files/boost/1.59.0/boost_1_59_0.tar.gz -P /tmp \
    && tar -zxvf /tmp/boost_1_59_0.tar.gz -C /usr/local/boost \
    && wget https://cdn.mysql.com//Downloads/MySQL-5.7/mysql-boost-5.7.23.tar.gz -P /tmp \
    && tar -zxvf /tmp/mysql-boost-5.7.23.tar.gz -C /tmp \
    && cd /tmp/mysql-5.7.23 \
    && cmake -DCMAKE_INSTALL_PREFIX=/opt/mysql -DMYSQL_DATADIR=/opt/mysql/data -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DWITH_BOOST=/usr/local/boost  \
    && make \
    && make install \
    && chown awd:awd -R /opt/mysql /www \
    && cd /opt/mysql/bin \
    && ./mysqld --initialize-insecure --user=awd --basedir=/opt/mysql --datadir=/opt/mysql/data \
    && wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.40.tar.gz -P /tmp \
    && tar -zxvf /tmp/pcre-8.40.tar.gz -C /tmp \
    && cd /tmp/pcre-8.40 \
    && ./configure \
    && make \
    && make install \
    && wget http://nginx.org/download/nginx-1.13.6.tar.gz -P /tmp \
    && tar -zxvf /tmp/nginx-1.13.6.tar.gz -C /tmp \
    && cd /tmp/nginx-1.13.6 \
    && ./configure --prefix=/usr/local/nginx --conf-path=/usr/local/nginx/conf/nginx.conf  --with-pcre=/tmp/pcre-8.40 --user=awd --group=awd \
    && make \
    && make install \
    && wget http://tw2.php.net/distributions/php-5.6.38.tar.bz2 -P /tmp \
    && tar -xjf /tmp/php-5.6.38.tar.bz2 -C /tmp \
    && cd /tmp/php-5.6.38 \
    && ./configure --prefix=/usr/local/php --with-libdir=lib64 --with-config-file-path=/usr/local/php/etc --enable-fpm --with-fpm-user=awd --with-fpm-group=awd --with-mysqli --with-pdo-mysql --with-iconv-dir --with-freetype-dir --with-jpeg-dir --with-png-dir --with-zlib --with-libxml-dir=/usr --enable-xml --disable-rpath --enable-bcmath --enable-shmop --enable-sysvsem --enable-inline-optimization --with-curl --enable-mbregex --enable-mbstring --with-mcrypt --enable-ftp --with-gd --enable-gd-native-ttf --with-openssl --with-mhash --enable-pcntl --enable-sockets --with-xmlrpc --enable-zip --enable-soap --without-pear --with-gettext --disable-fileinfo --enable-maintainer-zts \
    && make \
    && make install \
    && cp /usr/local/php/etc/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf \
    && cp /tmp/php-5.6.38/php.ini-production /usr/local/php/etc/php.ini \
    && sed -i "s/^;date.timezone =$/date.timezone = \"Asia\/Shanghai\"/" /usr/local/php/etc/php.ini \
    && cd /tmp \
    && rm -rf * \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && ln -s /opt/mysql/bin/* /usr/local/bin/ \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shangha" > /etc/timezone


COPY nginx.conf /usr/local/nginx/conf/nginx.conf

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod a+x /usr/local/bin/docker-entrypoint.sh  && ln -s /usr/local/bin/docker-entrypoint.sh /entrypoint.sh # backwards compat
ENTRYPOINT ["docker-entrypoint.sh"]
