# ----- 信息 -----
# @filename Command.sh
# @version 1.0
# @author qye.zheng
# @description 常用命令

#!/bin/sh


#常用命令
# 查看命令历史记录
history
# 查看最近几个
history 数字
# 指定要执行命令的编号
!历史命令编号

# 显示变量
#（Linux是大小写敏感：变量名称一定要大写，否则无法识别）
echo $SHELL
echo $PATH
# 显示当前登录的用户名
echo $USER

# 变更目录 change directory
# . 当前目录，.. 上一级目录，- 上次访问目录， ~ 用户主目录(Home)
cd

# 用户主目录 ，~ 可以省略
cd ~

# 返回进入此目录之前所在的目录
cd -

# 返回上级目录
cd ..
# 返回上2级目录
cd ../..
# 把上个命令的参数作为cd参数使用
cd !$

# 搜索

# 软件安装
yum -y install 包名

# 卸载
yum -remove

# 软件装卸
#rpm [软件包管理器-通用命令] redhat package manager
rpm -vh

# 进程
# 查看包含xx的进程 process status
ps -ef | grep xx
# 查看不包含xx的进程 grep: Globally a Regular Expression and Print
ps -ef | grep -v xx

# ===== begin 用户管理 =====
#切换用户
# 切换到新用户, 环境不变 switch user
su <username>
# 切换用户新用户, 改变环境
su - <user-name>

# 修改文件属性 change mode
chmod +[r|w|x] <filename>

# ===== end of 用户管理 =====

#文件操作
# ===== begin 文件管理 =====
# 输出当前工作目录 print working directory
pwd


# 创建目录 make directory
# -p parent 创建多级目录
mkdir -p xx

# -m 目标属性，rwx(用3位二进制分别表示 读-4、写-2、执行-1，读写执行: 7，读写: 6，读执行: 5，执行: 1)
# mkdir -m 777 3位数 分别表示 属主、同组、其他用户的rwx权限，例如: 属主读写执行，同组用户可读和执行，其他用户无权限访问 --> 750 (rwxr-x---)

# cp copy 文件复制
# 强制覆盖(无提示)
cp -rf
# -r recursive 递归处理，将指定目录下的所有文件与子目录一并处理
cp -r 

# 移动文件
# 覆盖询问
mv -i f1,f2,... dest_dir

# 重命名，name2在当前目录不存在，则为重命名，存在则name1移到name2下
mv name1 name2
# 移动
mv dir ./dir2

# rm remove 删除文件/目录，对于链接文件，只是删除链接，原文件保持不变
rm 
# -f force 强制删除
rm -f
# -r recursive 递归删除
# -v verbose 显示指令的详细执行过程
-v

# pushd push directory 将目录压入命令堆栈
pushd 目录

# 删除指定目录 +n 从左到右，从0开始
pushd +0

# 删除指定目录 -n 从右到左，从0开始
pushd  -0

# 解压 文件
unzip xx.zip

# 压缩文件
zip

# 解压 tar.gz 文件
tar -zxvf xx.tar.gz


# 拆分文件
split
# -b 按照多个kb来拆，-d 使用数字作为拆分后的文件名后缀 例如 x00 x01 x02 ...
split -b 100k -d xx.txt

# 文件压缩与解压
# zip 压缩/打包文件为 *.zip
zip

# -r 递归压缩 
zip -r xx.zip 要压缩的文件/目录路径

# unzip 解压 *.zip文件
unzip 

# gzip 压缩文件为 *.gzip
gzip -r 要压缩的文件

# xx.zip --> xx.zip.gz
gzip -r xx.zip

# xx.tar --> xx.tar.gz
gzip -r xx.tar

# 把目录下的所有文件压缩为*.gz文件
gzip -r 目录

# 解压 gunzip 文件
gunzip 

#tar 将多个文件/目录进行打包
tar 

# 解压指定文件 -x从备份文件中还原(extract)文件
tar -zxvf xx.tar.gz

# -c建立备份文件，以gzip压缩
tar -zcvf xx.tar.gz 目标文件/目录

# zipinfo 查看 *.zip 压缩文件信息
zipinfo xx,zip

# 软链接 源目录已经存在，新建一个虚拟目录
ln -s 源目录 虚拟目录

# 例如，将当前 jdk 最新版本(jdk1.8.0_172)指向一个虚拟目录(java)
ln -s jdk1.8.0_172 java

# ===== end of 文件管理 =====

#网络操作

#任务调度

# 启动服务
service xx start
service xx stop
service xx restart
# 查看某个服务的状态
service xx status

# 查看网络状态
service network status
# 重启网络 (通常修改主机名、ip地址等信息需要重启网络)
service network restart

###################### ls: list ######################
# ls : list 显示目标列表，ls命令的输出信息可以进行彩色加亮显示，以区分不同类型的文件
# 语法格式: ls (选项) (参数: 目录 | 文件)
# -a 显示所有档案及目录，ls默认将档案名或目录名以 . 开头的视为隐藏，不会列出
ls -a

# -A 显示除隐藏文件 . 或 .. 以外的所有文件列表
ls - A

# -C 多列显示输出结果，默认选项

# -1 单列输出结果 1列
ls -1

# -l 以长格式显示目录下的内容列表
ls -l

# -m 水平输出文件/目录，用逗号隔开
ls -m

# -R recursive 递归显示
ls - R


# -s size 显示文件和目录的大小，以区块为单位

# -t time 以文件/目录修改时间排序
ls -t

# -k 以KB(千字节)为单位显示文件大小
ls -k

# -h 列出可读文件和目录详细信息， 以KB、MB 显示文件大小，并输出总大小
ls -h


###################### grep 搜索 ######################
# 在指定文件搜索，返回一个包含"match_pattern"的文本行
grep match_pattern file
# 在多个文件中搜索
grep match_pattern file1 file2 ...

###################### 内核监测 ######################
# 实时动态地查看系统的整体运行状况
top

# 显示系统未使用/已使用的内存/缓冲区数目
free 
# 以 字节 Byte 为单位显示内存使用情况
free -b
# 以 KB MB 为单位显示内存使用情况
free -k
free -m
# 间隔秒数，持续观察内存使用情况
free -s 5
###################### 系统用户 ######################

# 显示当前登录用户名
logname

# 创建工作组
groupadd
# -g 设置工作组id，

# 删除工作组
groupdel

# 修改工作组
groupmod
# -g 设置工作组id，-n 设置工作组名称
# groupmod -n newGroupName oldGroupName

# 创建用户，创建一个用户同时自动创建一个和用户名相同的工作组，直到显式给用户划分工作组
useradd 
# 选项: -c 备注, -d 登录目录，-m 自动创建登录目录，-g 所属群组，-M 不自动创建登录目录

# 删除用户
userdel
# -f 强制删除，-r 一并删除与用户相关的所有文件
userdel -rf xx 

# 修改用户
usermod
# -l 修改用户登录帐号
usermod -l

# 设置密码
passwd
# -d 删除密码，-f 强制执行，-l 锁住密码，-u 解锁密码

# 查看用户所属的组 显式格式 用户:组
groups 用户名


###################### 系统管理 ######################
# chsh
# 查看系统安装了哪些shell
chsh -l

# 查看当前用户使用的shell
echo $SHELL

# 修改帐号使用的shell
chsh -s 

# id 显示用户id/用户组id/

###################### 网络管理 ######################
# curl 文件上传/下载
# curl可以用来作接口调试
# url用双引号包围起来，避免url中含有空格特殊字符串
curl -X 方法 "url" -H '头部'

# GET 方法
curl -X GET "url" -H 'key1:value1' -H 'key2:value2';

# POST方法
curl -X POST "url" -H 'key1:value1' -H 'key2:value2';

# 设置cookie
curl "url" --cookie "key1=value1;key2=value2"

# wget 下载文件
wget url
# -b 后台方式运行
wget -b url

# 查看ip
ifconfig

#

###################### 显示工具 ######################
# date 日期
# 格式 %Y-%m-%d %H:%M:%S
date +"%Y-%m-%d %H:%M:%S"

# 当前主机 数字化标志
hostid

######################  ######################

######################  ######################


######################  ######################


######################  ######################


######################  ######################


















