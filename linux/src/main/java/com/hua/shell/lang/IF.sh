# ----- 信息 -----
# @filename IF.sh
# @version 1.0
# @author qye.zheng
# @description IF 语句

#!/bin/sh


###################### IF语句  ######################
# 
if [ statement ]; then
statement;
elif statement; then
statement;
else
statement;
fi
#
#

# 判断
# 1) [ ! -f "$file" ] --> 判断 $file 是否是一个文件
# [ ! -d "$file" ] --> 判断 $file 是否是一个目录
# [ ! -s "$file" ] --> 判断 $file 文件是否存在且非空
# 2) [ ! $v -gt | -ge | -lt | -le -eq ] -->  数值 判断$v 是否 > >= < <= ==  一个数值
# 3) [ ! -r | -w | -x "$file" ] -->  判断$file 是否可以可读/可写/可执行
# 4) [ ! "$a" = "$b" ] --> 判断 变量 a 和 b 是否相等
# [ "$a" != "$b" ] --> 判断 变量 a 和 b 是否不等
# 5) [ ! conditon1 -a | -o ! conditon1 ]  --> 判断conditon1 和 conditon2 是否 同时/或有一个成立  (and or 逻辑运算)
#
# if 和 [ 之间有空格，[]与判断条件之间有空格，]与;不能有空格
#
#注意
# 1) 条件部分 [] 中括号2边都有空格，其保持正常的空格间隔
# 2) = 赋值: 两边不能有空格；= if [  ] 中: 两边必须有空格
# 3) 逻辑非: !  逻辑与: -a 逻辑或: -o
#  
#

# if 语句 模板
if [  ]; then

elif [  ]; then

else

fi


#  $? : 表示上次脚本的退出码；0-执行成功，非0执行失败
# 判断上一次的脚本是否发执行成功
if [ $? -ne 0 ];then 
 # 上一次脚本执行不成功
 exit 0
fi
 

if $?=0 ; then
 # 上一次脚本执行成功
fi
 #
###################### 数值大小判断 ######################
#
a=3
b=4
if [ $a -eq $b ]; then
	echo "$a == $b"
elif [ $a -gt $b ]; then
	echo "${a} > ${b}"
elif [ $a -lt $b ]; then
	echo "$a < $b"
fi
#
#

#
#
#

#
#
#

######################  ######################
# 判断某个文件是否存在
set myFile=/home/zhengqianye/info.txt
if [ -f "$myFile" ]; then
	echo $myFile exists!
else
	echo $myFile not exists!
fi

set myFile=/home/zhengqianye/info2.txt
if [ -f "$myFile" ]; then
	echo $myFile exists!
else
	echo $myFile not exists!
fi

######################  ######################

######################  ######################
#
#
#

#
#
#

#
#
#

######################  ######################


######################  ######################


######################  ######################

######################  ######################
#
#
#

#
#
#

#
#
#

######################  ######################


######################  ######################


######################  ######################









