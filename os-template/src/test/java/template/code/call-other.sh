# ----- 信息 -----
# @filename call-other.sh
# @version 1.0
# @author qianye.zheng
# @description  启动器 (启动/停止，无参-执行重启)

# 解决远程ssh执行脚本失败问题
source /etc/profile

# 进入脚本所在目录
cd `dirname $0`

# 变量定义
# 脚本的路径
declare -r SHELL_PATH=

# 变量定义
if [[ -z $1 ]]; then
  # 默认重启
  command="restart"
else
  # start | status | restart | stop
  command=$1
fi

sh ${SHELL_PATH} $command

exit 0