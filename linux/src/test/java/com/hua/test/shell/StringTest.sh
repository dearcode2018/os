# ----- 信息 -----
# @filename StringTest.sh
# @version 1.0
# @author qye.zheng
# @description 字符串 - 测试

#!/bin/sh


######################  ######################

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

str="welcome to guangzhou city!"

# length
echo length: ${#str}
# 
echo start 1 : ${str:1}

echo 1,3 : ${str:1:3}
str="http://127.0.0.1/index.html"
echo ${str#*/}
echo ${str##*/}

echo ${str%*/}
echo ${str%%*/}

# 删除变量
unset str
echo ${str:-newString}

str="http://127.0.0.1/index.html"
# 替换的 / 特殊字符时候，无须转义，按照字面需要直接书写即可
echo ${str////slash}
#echo ${str//./dot}

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









