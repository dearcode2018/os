# ----- 信息 -----
# @filename Variable.sh
# @version 1.0
# @author qye.zheng
# @description 变量/类型

#!/bin/sh


######################  ######################


###################### shell 变量 ######################

# 1) shell 变量是一种弱类型变量，默认情况下，一个变量保存一个串.
# 2) 若要进行数学运算，必须使用一些命令 let / declare / expr / () 等
# 3) 只读变量 readyonly variableName  (final的变量)
# 4) 变量名: 大小写敏感
# 5) 变量赋值: 等号(=)周围不能有任何空白符
# 6) 清除变量: unset variableName
# 7) shell 中默认把变量当作字符串，可以用let命令使其进行数学运算 let age=${age}+1
# delcare -i age=22 声明变量age为integer类型，以后的运算，都把age的右值识别为算术表达式或数字
# 8) 变量命名: 字母或下划线开头，其他可以是字母、数字、下划线.

#
#
#

#
#
#
###################### 变量引用 ######################
# 1) 变量声明 variableName="value"  注意: 双引号是界定符.
# 2) 引用方式: $variableName 推荐写法: ${variableName}


#
#
###################### 字符串 ######################
#
# 3) 返回变量的字符串长度: ${#variableName}
# 4) 截取: ${variableName:startIndex}  ${variableName:startIndex:length}
# 5) ${variableName#string} 返回左边删除string后的字符串 - 短匹配
# 例如 var="http://127.0.0.1/index.html" ${var#*/} 返回 /127.0.0.1/index.html
# 6) ${variableName##string} 返回左边删除string后的字符串 - 长匹配
# 例如 var="http://127.0.0.1/index.html" ${var##*/} 返回 /index.html
# 7) ${var%string} 返回右边删除string后的字符串 - 短匹配
# 8) ${var%%string} 返回右边删除string后的字符串 - 长匹配
# 9) ${var:-newString} 若var为空值或未定义，则返回newString
# 10) ${var:=newString} 若var为空值或未定义，则返回newString，并把newString赋给var
# 11) ${var:+newString} 若var不为空，则返回newString
# 12) ${var:?newString} 若var为空或未定义，则将newString写入标准错误流，本语句失败
# 13) ${var/oldString/newString} 只替换一次 replace
# 14) ${var//oldString/newString} 替换所有 replaceAll
# 15) $(command) 返回命令执行后的输出结果
# 16) $((算术表达式)) 例如: $((20 + 3 * 4))
# 17) 
#
#
#

#declare [options] var=value
#options: -aAfFgilrtux  (i-整型，r-只读，)
# 声明为Integer类型
declare -i age=20
# 算术运算
age=${age}+1
echo $age

# 声明只读变量，final 类型
declare -r readOnly=10
echo $readOnly


###################### 数组 ######################
# 1) 数组初始化 方式1
# array[0]=1
# array[1]=50
# array[2]=20

# 2) 数组初始化 方式2 (元素用空格隔开)
# array=(1 50 20)
# 3) 访问数组元素 ${array[$i]} 访问下标为 $i的元素  ${array[*]} 返回数组所有元素组成的字符串
# 4) 数组长度 ${#array[*]}
# 5) ${array:startIndex:length} 截取开始下标指定长度的串
#
 #!/bin/bash
for ((i=0; i<100; i++))
do
	array[$i]=$i
done

for ((i=0; i<100; i++))
do
	echo ${array[$i]}
done
#

# 二维数组 (模拟实现)
for ((i=0;i<2;i++))
do (
	for ((j=0;j<3;j++))
	do 
	(
		# 输入
		#read man$i$j
		man$i$j =  $i + $j
	)
	done
)
done

# 循环输出
for ((i=0;i<2;i++))
do
(
	for ((j=0;j<3;j++))
	do
	(
		eval echo "\$man$i$j"
	)
	done
)
done


#
#

######################  ######################
# root@suse:~$ name=Barry
# root@suse:~$ $name=hello ($开头的命名，无法解析为赋值语句)
# Barry=hello: command not found

# 使用 eval 解决此类问题
# root@suse:~$ name=Barry
# root@suse:~$ eval $name=hello   (第一次扫描，识别 $name 替换为 Barry，第二次扫描识别为赋值语句，执行Barry=hello)
# root@suse:~$ echo $Barry    --> 输出 hello
#

#
#
#

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
#
#
#

#
#
#

#
#
#








