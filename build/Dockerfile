#使用Rocky Linux 8.9作为基础镜像
FROM rockylinux:8.9

USER root

#环境变量-表示这是一个容器环境
ENV container docker

#移除不必要的systemd服务-优化容器启动过程
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ "$i" == "systemd-tmpfiles-setup.service" ] || rm -f "$i"; done) && \
    rm -f /lib/systemd/system/multi-user.target.wants/* && \
    rm -f /etc/systemd/system/*.wants/* && \
    rm -f /lib/systemd/system/local-fs.target.wants/* && \
    rm -f /lib/systemd/system/sockets.target.wants/*udev* && \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl* && \
    rm -f /lib/systemd/system/basic.target.wants/* && \
    rm -f /lib/systemd/system/anaconda.target.wants/*

#安装EPEL和Remi仓库更新并清理缓存
RUN yum install -y epel-release && \
    rpm -ivh https://rpms.remirepo.net/enterprise/remi-release-8.rpm && \
    yum clean all

#拷贝YUM源配置文件到容器中并生成YUM缓存
COPY yum.repos.d /etc/yum.repos.d/
RUN yum makecache


#安装所需的软件包
RUN yum install -y redhat-lsb-core iproute wget curl bc gcc gcc-c++ genisoimage git gzip httpd lftp m4 make mod_ssl mtools \
mariadb-server mariadb-galera-server mariadb-10.3.39-1.module+el8.8.0+1452+2a7eab68.x86_64 net-tools nfs-utils openssl php php-bcmath php-cli php-common php-fpm php-gd php-json php-ldap \ 
php-mbstring php-mysqlnd php-process syslinux tar tftp-server unzip util-linux-user vsftpd wget xz-devel && \
yum clean all

#配置安装服务
COPY fogproject-1.5.10.tar.gz /fogproject-1.5.10.tar.gz
COPY install-fogproject.sh /install-fogproject.sh
RUN chmod +x /install-fogproject.sh

COPY fogproject-install.service /etc/systemd/system/fogproject-install.service
RUN chmod 644 /etc/systemd/system/fogproject-install.service
RUN systemctl enable fogproject-install.service

#设置工作目录和卷
WORKDIR /opt
VOLUME ["/sys/fs/cgroup", "/tftpboot", "/var/lib/mysql", "/opt", "/images"]

#设置启动脚本为容器的入口点
CMD ["/usr/sbin/init"]

