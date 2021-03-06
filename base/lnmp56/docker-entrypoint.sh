#!/bin/bash
set -e
    /usr/local/php/sbin/php-fpm
    chmod -R 777 /var/lib/mysql
    /etc/init.d/mysql start
    #/opt/mysql/bin/mysqld_safe   --user=awd --secure-file-priv='' --general-log-file="/opt/mysql/mysql-sql.log" &
    sleep 5s
    for f in /docker-entrypoint-initdb.d/*; do
            case "$f" in
                    *.sh)  echo "[Entrypoint] running $f"; . "$f" ;;
                    *.sql) echo "[Entrypoint] running $f"; mysql -u root -pshadow  < "$f" && echo ;;
                    *)     echo "[Entrypoint] ignoring $f" ;;
            esac
            echo
    done

   /usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf
   /usr/bin/supervisord --nodaemon -c /etc/supervisor/supervisord.conf
