# ----- 信息 -----
# @filename String.sh
# @version 1.0
# @author qye.zheng
# @description 字符串

#!/bin/sh


######################  ######################


######################  ######################

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









