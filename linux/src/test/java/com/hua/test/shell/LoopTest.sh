# ----- 信息 -----
# @filename LoopTest.sh
# @version 1.0
# @author qye.zheng
# @description FOR 循环测试

#!/bin/sh


###################### for 循环 ######################

for (( i=0; i<10; i++)) do
(
	echo $i + ", "
) done

for i in 0 1 2 3 4 5 6 7 8 9; do
(
	echo $i + ", "
) done


###################### while 循环 ######################
declare -i i=0
while [ $i -le 10 ]; do
(
	echo $i + ", "
	i=$i+1
) done

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








