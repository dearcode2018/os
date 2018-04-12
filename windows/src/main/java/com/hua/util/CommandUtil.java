/**
 * CommandUtil.java
 * @author  qye.zheng
 * 	version 1.0
 */
package com.hua.util;

import com.hua.constant.Constant;
import com.hua.util.StringUtil;

/**
 * CommandUtil
 * 描述: Windows 命令 - 工具类
 * @author  qye.zheng
 */
public final class CommandUtil
{

	/**
	 * 构造方法
	 * 描述: 私有 - 禁止实例化
	 * @author  qye.zheng
	 */
	private CommandUtil()
	{
	}
	
	/**
	 * 
	 * 描述: 路径处理
	 * 处理效果:(\后面的值用双引号围起来)
	 * C:\"Program Files"\"TENCENT"\"QQ"\"Bin"\"QQ.exe"
	 * @author qye.zheng
	 * @param path
	 * @return
	 */
	public static final String pathHandle(final String path)
	{
		/*
		 * 思路
		 * 以 \ 为参照 进行拆分，忽略结果数组的第一个元素
		 */
		String result = null;
		if (!StringUtil.isEmpty(path))
		{
			final StringBuilder builder = StringUtil.getBuilder(256);
			// 以 反斜杠为正则，需要转义
			final String regex = "\\\\";
			// 根据 \ 拆分
			final String[] splits = path.split(regex);
			// 添加第一个元素
			builder.append(splits[0]);
			// 从 1 开始
			for (int i = Constant.ONE; i < splits.length; i++)
			{
				// 加上双引号
				splits[i] =Constant.BACK_SLASH + Constant.DOUBLE_QUOTE + splits[i] + Constant.DOUBLE_QUOTE;
				builder.append(splits[i]);
			}
			// 生成结果
			result = builder.toString();
		}
		
		return result;
	}

}
