/**
 * 描述: 
 * OpenProgram.java
 * @author	qye.zheng
 *  version 1.0
 */
package com.hua.bean;

/**
 * 描述: 打开应用程序
 * @author  qye.zheng
 * OpenProgram
 */
public final class OpenProgram
{
	/* 应用程序名称 */
	private String name;
	
	/* 应用程序路径 */
	private String path;
	
	/* 应用程序 注释 (预留) */
	private String comment;
	
	/**
	 * 构造方法
	 * 描述: 
	 * @author qye.zheng
	 */
	public OpenProgram()
	{
	}

	/**
	 * @return the name
	 */
	public final String getName()
	{
		return name;
	}

	/**
	 * @param name the name to set
	 */
	public final void setName(String name)
	{
		this.name = name;
	}

	/**
	 * @return the path
	 */
	public final String getPath()
	{
		return path;
	}

	/**
	 * @param path the path to set
	 */
	public final void setPath(String path)
	{
		this.path = path;
	}

	/**
	 * @return the comment
	 */
	public final String getComment()
	{
		return comment;
	}

	/**
	 * @param comment the comment to set
	 */
	public final void setComment(String comment)
	{
		this.comment = comment;
	}

	/**
	 * 
	 * 描述: 生成set声明
	 * @author qye.zheng
	 * @return
	 */
	public final String ouputSet()
	{
		/**
		 * 例如:
		 * set notepad=D:\"Program Files"\"Notepad++"\"notepad++.exe"
		 */
		return "set " + name + "=" + path;
	}
	
	/**
	 * 
	 * 描述: 生成start声明
	 * @author qye.zheng
	 * @return
	 */
	public final String ouputStart()
	{
		/**
		 * 例如:
		 *start %notepad%
		 */
		return "start " + "%" + name + "%";
	}
}
