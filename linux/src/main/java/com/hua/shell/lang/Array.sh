# ----- 信息 -----
# @filename Array.sh
# @version 1.0
# @author qye.zheng
# @description 数组

#!/bin/sh


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







