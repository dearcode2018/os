# ----- 信息 -----
# @filename Function.sh
# @version 1.0
# @author qye.zheng
# @description 函数

#!/bin/sh


###################### 函数定义 ######################

# function 函数名称(参数列表) {函数体}  $1 $2 分表表示函数的参数，$* 表示参数列表
# function 关键字可以省略，规范起见，还是带上关键字function
function functionName() 
{
	# 定义局部变量
	local localVar=xx;
}

######################  ######################
# 1) 所有函数在使用前必须定义，意味着函数必须放在脚本开始部分，直至shell解释器首次发现它，才可以使用
# 2) 函数调用: functionName    直接使用名称即可，不用带上()
# 3) 使用 return 返回；若不使用return或return后不带返回值，则函数的最后一条语句作为返回值，返回值范围: [0, 255]
# 4) 
#
#

# 函数调用
# 1) 通过 $() 执行命令来调用函数，参数用空格隔开 example: retValue=$(fun $var1 $var2 $var3 ...)
# 2) 直接通过 = 来接收$() 函数的返回为空，可以通过 $? 来获取函数的返回值，$? 获取的是上一次命令的返回值
# 
#
#
#


######################  ######################
#

#
#
# 函数示例1
# 判断某个文件是否存在
function fileExists()
{
	if [ -f "$1" ]; then
		echo $1 exists!
		return 1;
	else
		echo $1 not exists!;
		return 0;
	fi
}

set myFile="/home/zhengqianye/info.txt"
# 调用函数判断文件是否存在
$(fileExists $myFile)
# 通过 $? 获取$()执行后的返回值，从而获取函数的返回值
echo $?
#

# 函数示例2
function add()
{
	return $(($1+$2));
}

a=10
b=32;
## 调用方式1
add a b
## 调用方式2
#$(add a b)
## 获取返回值
echo "result = $?"

#
#


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


######################  ######################


######################  ######################








