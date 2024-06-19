#!/bin/bash
chown -R mysql:mysql /var/lib/mysql

#检查安装目录是否存在
if [ ! -d "/opt/fogproject-1.5.10" ]; then
    wget --no-check-certificate -P /opt https://drive.swireb.cn/d/Linux/Docker/FOGProject/fogproject-1.5.10.tar.gz
    tar -xvzf /opt/fogproject-1.5.10.tar.gz -C /opt/
    rm -f /opt/fogproject-1.5.10.tar.gz
    cd /opt/fogproject-1.5.10/bin/
    bash installfog.sh --autoaccept

fi
cd /opt/fogproject-1.5.10/bin/
bash installfog.sh --autoaccept

#相关的服务
#httpd.service
#php-fpm.service
#fog-tftp.socket
#vsftpd.service
#FOGMulticastManager.service
#FOGImageReplicator.service
#FOGSnapinReplicator.service
#FOGScheduler.service
#FOGPingHosts.service
#FOGSnapinHash.service
#FOGImageSize.service
#rpcbind.service
#nfs-server.service
#mysql-server.service

