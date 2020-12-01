# ----- 信息 -----
# @filename run.sh
# @version 1.0
# @author qianye.zheng
# @description  自身脚本启动

# 解决远程ssh执行脚本失败问题
source /etc/profile

# 进入脚本所在目录
cd `dirname $0`

# 变量定义

pwd

ls -lt


exit 0