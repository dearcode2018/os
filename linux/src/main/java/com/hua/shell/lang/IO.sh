# ----- 信息 -----
# @filename IO.sh
# @version 1.0
# @author qye.zheng
# @description 输入/输出流

#!/bin/sh


###################### 输入 ######################
# 1) read
# read 从标准输入中读取一行，
#
#

1.read 命令介绍：
read 命令从标准输入中读取一行，并把输入行的每个字段的值指定给 shell 变量，用 IFS（内部字段分隔符）变量中的字符作为分隔符。VariableName （变量名）参数指定给每一个字段的值，由　VariableName （变量名）参数指定的以此类推，直到最后一个字段。
2.read 读参赋值：
2.1.read 不跟变量：
在执行read命令行时可以不指定变量参数.如果不指定变量，那么read命令会将接收到的数据放置在环境变量 $REPLY 中。
read -p "Enter Numbers"
123456 ##任意输入数字后回车
echo $REPLY
123456
2.2.read 一个或多个变量：
read后面的变量var可以只有一个，也可以有多个，这时如果输入多个数据，则第一个数据给第一个变量，第二个数据给第二个变量，如果输入数据个数过多，则最后所有的值都给第一个变量。
#!/bin/bash
two()
{
read -p "Input 2 Vars: " v1 v2
echo $v1
echo $v2
}
two
3.read 命令常用参数：
3.1.输入提示
read -p "提示语句:"
屏幕打印出一行提示语句。
3.2.命令计数
read -n字符个数
设置read命令计数输入的字符。当输入的字符数目达到预定数目时，自动退出，并将输入的数据赋值给变量。
#!/bin/bash
read -n1 -p "Do you want to continue [Y/N]?" answer
case $answer in
Y|y)
      echo "fine ,continue";;
N|n)
      echo "ok,good bye";;
*)
     echo "error choice";;
esac
exit 0
该例子使用了-n选项，后接数值1，指示read命令只要接受到一个字符就退出。只要按下一个字符进行回答，read命令立即接受输入并将其传给变量。无需按回车键。
3.3.计时输入
read -t 等待时间
使用read命令存在着潜在危险。脚本很可能会停下来一直等待用户的输入。如果无论是否输入数据脚本都必须继续执行，那么可以使用-t选项指定一个计时器。-t选项指定read命令等待输入的秒数。当计时满时，read命令返回一个非零退出状态;
#!/bin/bash
if read -t 5 -p "please enter your name:" name
then
    echo "hello $name ,welcome to my script"
else
    echo "sorry,too slow"
fi
exit 0
3.4.关闭回显
read -s
-s选项能够使read命令中输入的数据不显示在监视器上（实际上，数据是显示的，只是read命令将文本颜色设置成与背景相同的颜色）。
#!/bin/bash
read  -s  -p "Enter your password:" pass
echo "your password is $pass"
exit 0
屏幕不回显输入的字符

#
#
###################### 输出 ######################

# 
# 1) printf 内容

# 2) echo 信息
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








