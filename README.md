## Fogproject相关站点

- [官方文档](https://docs.fogproject.org/en/latest/)

- [官方地址](https://fogproject.org/)

- [官方项目](https://github.com/FOGProject/)

  

## 通过Docker部署Fogproject

- 仅支持host网络模式
```shell
#主机要禁用rpcbind服务防止占用端口
systemctl stop rpcbind.socket
systemctl disable rpcbind.socket
```
- 并未开启dhcp相关选项的功能
- 文件介绍

```shell
[root@localhost ~]# tree fogproject-docker/
fogproject-docker/
├── build                          #容器构建目录 
│   ├── build.sh                   #构建脚本
│   ├── Dockerfile                 #Dockerfile
│   ├── fogproject-1.5.10.tar.gz   #官方安装工具脚本（去除了访问github的下载更换成离线文件）
│   ├── fogproject-install.service #容器安装Fogproject服务
│   ├── install-fogproject.sh      #容器安装Fogproject脚本
│   └── yum.repos.d                #国内源
├── docker-compose.yaml            #通过docker-compose启动容器
└── start.sh                       #通过docker run启动容器
```

- 使用docker-compose启动容器

```shell
#docker-compose.yaml文件内容示例
cat docker-compose.yaml 
version: '3.8'
services:
  fogproject:
    image: jackywn/fogproject
    container_name: fogproject
    network_mode: "host"
    privileged: true
    #挂载mysql、安装目录、站点目录、引导目录、镜像目录
    volumes:
      - /sys/fs/cgroup:/sys/fs/cgroup:ro
      - ./fog/mysql:/var/lib/mysql
      - ./fog/opt:/opt
      - ./fog/tftpboot:/tftpboot
      - ./fog/images:/images
      
#启动容器
cd fogproject-docker
docker-compose up -d

#查看详细日志
tail -f fog/opt/fogproject-1.5.10/bin/error_logs/fog_error_1.5.10.log  

#查看简要日志
tail -f fog/opt/fogproject-1.5.10/bin/error_logs/foginstall.log 
```

- 完整的安装日志

```shell
 * Option 067/filename is the bootfile: (e.g. undionly.kkpxe or snponly.efi)
 * Send OS Name, OS Version, and FOG Version: Yes

 * Installation Started

Done
 * Adjusting repository (can take a long time for cleanup).....OK
 * Preparing Package Manager...................................OK
 * Packages to be installed:

	bc curl gcc gcc-c++ genisoimage git gzip httpd lftp m4 make mariadb mariadb-server mod_ssl mtools net-tools nfs-utils openssl php php-bcmath php-cli php-common php-fpm php-gd php-json php-ldap php-mbstring php-mysqlnd php-process syslinux tar tftp-server unzip util-linux-user vsftpd wget xz-devel 

 * Skipping package:   bc......................................(Already Installed)
 * Skipping package:   curl....................................(Already Installed)
 * Skipping package:   gcc.....................................(Already Installed)
 * Skipping package:   gcc-c++.................................(Already Installed)
 * Skipping package:   genisoimage.............................(Already Installed)
 * Skipping package:   git.....................................(Already Installed)
 * Skipping package:   gzip....................................(Already Installed)
 * Skipping package:   httpd...................................(Already Installed)
 * Skipping package:   lftp....................................(Already Installed)
 * Skipping package:   m4......................................(Already Installed)
 * Skipping package:   make....................................(Already Installed)
 * Skipping package:   mariadb.................................(Already Installed)
 * Skipping package:   mariadb-server..........................(Already Installed)
 * Skipping package:   mod_ssl.................................(Already Installed)
 * Skipping package:   mtools..................................(Already Installed)
 * Skipping package:   net-tools...............................(Already Installed)
 * Skipping package:   nfs-utils...............................(Already Installed)
 * Skipping package:   openssl.................................(Already Installed)
 * Skipping package:   php.....................................(Already Installed)
 * Skipping package:   php-bcmath..............................(Already Installed)
 * Skipping package:   php-cli.................................(Already Installed)
 * Skipping package:   php-common..............................(Already Installed)
 * Skipping package:   php-fpm.................................(Already Installed)
 * Skipping package:   php-gd..................................(Already Installed)
 * Skipping package:   php-json................................(Already Installed)
 * Skipping package:   php-ldap................................(Already Installed)
 * Skipping package:   php-mbstring............................(Already Installed)
 * Skipping package:   php-mysqlnd.............................(Already Installed)
 * Skipping package:   php-process.............................(Already Installed)
 * Skipping package:   syslinux................................(Already Installed)
 * Skipping package:   tar.....................................(Already Installed)
 * Skipping package:   tftp-server.............................(Already Installed)
 * Skipping package:   unzip...................................(Already Installed)
 * Skipping package:   util-linux-user.........................(Already Installed)
 * Skipping package:   vsftpd..................................(Already Installed)
 * Skipping package:   wget....................................(Already Installed)
 * Skipping package:   xz-devel................................(Already Installed)
 * Updating packages as needed.................................OK

 * Confirming package installation

 * Checking package: bc........................................OK
 * Checking package: curl......................................OK
 * Checking package: gcc.......................................OK
 * Checking package: gcc-c++...................................OK
 * Checking package: genisoimage...............................OK
 * Checking package: git.......................................OK
 * Checking package: gzip......................................OK
 * Checking package: httpd.....................................OK
 * Checking package: lftp......................................OK
 * Checking package: m4........................................OK
 * Checking package: make......................................OK
 * Checking package: mariadb...................................OK
 * Checking package: mariadb-server............................OK
 * Checking package: mod_ssl...................................OK
 * Checking package: mtools....................................OK
 * Checking package: net-tools.................................OK
 * Checking package: nfs-utils.................................OK
 * Checking package: openssl...................................OK
 * Checking package: php.......................................OK
 * Checking package: php-bcmath................................OK
 * Checking package: php-cli...................................OK
 * Checking package: php-common................................OK
 * Checking package: php-fpm...................................OK
 * Checking package: php-gd....................................OK
 * Checking package: php-json..................................OK
 * Checking package: php-ldap..................................OK
 * Checking package: php-mbstring..............................OK
 * Checking package: php-mysqlnd...............................OK
 * Checking package: php-process...............................OK
 * Checking package: syslinux..................................OK
 * Checking package: tar.......................................OK
 * Checking package: tftp-server...............................OK
 * Checking package: unzip.....................................OK
 * Checking package: util-linux-user...........................OK
 * Checking package: vsftpd....................................OK
 * Checking package: wget......................................OK
 * Checking package: xz-devel..................................OK

 * Configuring services

 * Setting up fogproject user..................................OK
 * Locking fogproject as a system account......................OK
 * Setting up fogproject password..............................OK
 * Stopping FOGMulticastManager.service Service................OK
 * Stopping FOGImageReplicator.service Service.................OK
 * Stopping FOGSnapinReplicator.service Service................OK
 * Stopping FOGScheduler.service Service.......................OK
 * Stopping FOGPingHosts.service Service.......................OK
 * Stopping FOGSnapinHash.service Service......................OK
 * Stopping FOGImageSize.service Service.......................OK
 * Setting up and starting MySQL...............................OK
 * Setting up MySQL user and database..........................Skipped
 * Backing up user reports.....................................Done
 * Stopping web service........................................OK
 * Setting up Apache and PHP files.............................OK
 * Testing and removing symbolic links if found................OK
 * Backing up old data.........................................OK
 * Copying new files to web folder.............................OK
 * Creating config file........................................OK
 * Creating redirection index file.............................OK
 * Downloading kernel, init and fog-client binaries............Done
 * Copying binaries to destination paths.......................OK
 * Enabling apache and fpm services on boot....................OK
 * Creating SSL Certificate....................................OK
 * Creating auth pub key and cert..............................OK
 * Resetting SSL Permissions...................................OK
 * Setting up Apache virtual host (no SSL).....................OK
 * Starting and checking status of web services................OK
 * Changing permissions on apache log files....................OK
 * Backing up database.........................................Done
 * Updating Database...........................................OK
 * Update fogstorage database password.........................OK
 * Granting access to fogstorage database user.................Skipped
 * Setting up storage..........................................OK
 * Setting up and starting DHCP Server.........................Skipped
 * Configuring default iPXE file...............................OK
 * Setting up and starting TFTP Server.........................OK
 * Setting up and starting VSFTP Server........................OK
 * Setting up FOG Snapins......................................OK
 * Setting up UDPCast..........................................OK
 * Configuring UDPCast.........................................OK
 * Building UDPCast............................................OK
 * Installing UDPCast..........................................OK
 * Installing FOG System Scripts...............................OK

 * Configuring FOG System Services

 * Setting permissions on FOGMulticastManager.service script...OK
 * Enabling FOGMulticastManager.service Service................OK
 * Setting permissions on FOGImageReplicator.service script....OK
 * Enabling FOGImageReplicator.service Service.................OK
 * Setting permissions on FOGSnapinReplicator.service script...OK
 * Enabling FOGSnapinReplicator.service Service................OK
 * Setting permissions on FOGScheduler.service script..........OK
 * Enabling FOGScheduler.service Service.......................OK
 * Setting permissions on FOGPingHosts.service script..........OK
 * Enabling FOGPingHosts.service Service.......................OK
 * Setting permissions on FOGSnapinHash.service script.........OK
 * Enabling FOGSnapinHash.service Service......................OK
 * Setting permissions on FOGImageSize.service script..........OK
 * Enabling FOGImageSize.service Service.......................OK
 * Setting up FOG Services.....................................OK
 * Starting FOGMulticastManager.service Service................OK
 * Starting FOGImageReplicator.service Service.................OK
 * Starting FOGSnapinReplicator.service Service................OK
 * Starting FOGScheduler.service Service.......................OK
 * Starting FOGPingHosts.service Service.......................OK
 * Starting FOGSnapinHash.service Service......................OK
 * Starting FOGImageSize.service Service.......................OK
 * Setting up exports file.....................................OK
 * Setting up and starting RPCBind.............................OK
 * Setting up and starting NFS Server..........................OK
 * Linking FOG Logs to Linux Logs..............................OK
 * Linking FOG Service config /etc.............................OK
 * Ensuring node username and passwords match..................Done
 * Setting up FOG External Reporting...........................Done

 * Setup complete

   You can now login to the FOG Management Portal using
   the information listed below.  The login information
   is only if this is the first install.

   This can be done by opening a web browser and going to:

   http://10.10.0.243/fog/management   #通过本机IP地址可以访问

   Default User Information            #访问的用户名和密码
   Username: fog
   Password: password

 * Changed configurations:

   The FOG installer changed configuration files and created the
   following backup files from your original files:
   * /etc/vsftpd/vsftpd.conf <=> /etc/vsftpd/vsftpd.conf.1713950767
   * /etc/exports <=> /etc/exports.1713950767     #此时服务已经部署成功
```



## 使用dnsmasq代理DHCP

- 安装dnsmasq

```
yum install dnsmasq -y
```

- 配置文件

```shell
vim /etc/dnsmasq.d/fog.conf
#不作为DNS服务器
port=0

#记录关于DHCP事务的大量额外信息
log-dhcp

#设置通过FTP可用的文件的根目录
tftp-root=/tftpboot

#默认引导文件名
dhcp-boot=undionly.kpxe,,10.10.0.243

#禁用将DHCP服务器名称和文件名字段作为额外选项空间的重复使用（这样做是为了避免混淆一些旧的或损坏的DHCP客户端）
dhcp-no-override

#检查供应商类字符串并匹配文本以设置标签
dhcp-vendorclass=BIOS,PXEClient:Arch:00000
dhcp-vendorclass=UEFI32,PXEClient:Arch:00006
dhcp-vendorclass=UEFI,PXEClient:Arch:00007
dhcp-vendorclass=UEFI64,PXEClient:Arch:00009

#根据供应商类匹配标签设置引导文件名
dhcp-boot=net:UEFI32,i386-efi/ipxe.efi,,10.10.0.243
dhcp-boot=net:UEFI,ipxe.efi,,10.10.0.243
dhcp-boot=net:UEFI64,ipxe.efi,,10.10.0.243

#PXE菜单（第一部分是显示给用户的文本，第二部分是超时时间单位为秒）
pxe-prompt="Booting FOG Client", 1

#The known types are x86PC, PC98, IA64_EFI, Alpha, Arc_x86,
#Intel_Lean_Client, IA32_EFI, BC_EFI, Xscale_EFI and X86-64_EFI
#This option is first and will be the default if there is no input from the user.
pxe-service=X86PC, "Boot to FOG", undionly.kpxe
pxe-service=X86-64_EFI, "Boot to FOG UEFI", ipxe.efi
pxe-service=BC_EFI, "Boot to FOG UEFI PXE-BC", ipxe.efi

#定义DHCP服务器应用于PXE引导监听地址
dhcp-range=10.10.0.243,proxy

#这将忽略MAC地址为00:11:22:33:44:55的客户端的DHCP请求
#dhcp-host=00:50:56:a0:87:3e,set:ignorePXE

#可以可以通过一个mac地址表来忽略
#conf-file=/etc/dnsmasq.d/mac/ignore-mac.conf
#dhcp-ignore=tag:ignorePXE
```

- 启动服务

```shell
systemctl enable --now dnsmasq.service
```

