# ----- 信息 -----
# @filename IFTest.sh
# @version 1.0
# @author qye.zheng
# @description IF 语句测试

#!/bin/bash


######################  ######################


## 文件路径
myFile="/home/zhengqianye/info.txt"
myFile="/home/zhengqianye/info2.txt"

if [ -f "$myFile" ]; then 
	echo $myFIle exists!
else
	 echo $myFIle not exists!
fi

# 逻辑 与或非 多个条件组合
#if [ (1 -eq 1) -a (3 -ne 4) -o ("a" -eq "c") ]; then
if [ 1 -eq 1 -a 3 -ne 4 -o "a" -eq "c" ]; then
	echo "逻辑 与或非 多个条件组合 成立"
else	
	echo "逻辑 与或非 多个条件组合 不成立"
fi

#set a=1
#set b=2

# 不需要用 set 来声明变量
# a=3
# b=3

# if [ $a -eq $b ]; then
	# echo "$a == $b"
# elif [ $a -gt $b ]; then
	# echo "${a} > ${b}"
# elif [ $a -lt $b ]; then
	# echo "$a < $b"
# fi

######################  ######################


######################  ######################


######################  ######################

######################  ######################


######################  ######################


######################  ######################


######################  ######################

######################  ######################


######################  ######################


######################  ######################


######################  ######################









