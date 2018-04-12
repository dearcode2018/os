/**
 * 描述: 
 * CommandDriver.java
 * @author	qye.zheng
 *  version 1.0
 */
package com.hua.driver;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.Reader;
import java.io.Writer;
import java.util.LinkedList;
import java.util.List;

import com.hua.bean.OpenProgram;
import com.hua.constant.CommandConstant;
import com.hua.constant.Constant;
import com.hua.util.CommandUtil;
import com.hua.util.IOUtil;
import com.hua.util.ProjectUtil;
import com.hua.util.StringUtil;


/**
 * 描述:  - 驱动器
 * @author  qye.zheng
 * CommandDriver
 */
public class CommandDriver
{
	// 应用程序路径描述文件(txt)
	private static final String PROGRAM_PATH = 
			ProjectUtil.getAbsolutePath("/doc/programPath.txt", true);
	
	/**
	 * 构造方法
	 * 描述: 
	 * @author qye.zheng
	 */
	private CommandDriver()
	{
	}
	
	/**
	 * 
	 * 描述: 输出bat文件
	 * 生成应用程序启动文件
	 * 输出编码符合ANSCII，否则中文乱码将导致路径
	 * 解析失败
	 * @author  qye.zheng
	 * @return
	 */
	public static final boolean outputBatFile()
	{
		boolean flag = false;
		InputStream inputStream = null;
		Reader reader = null;
		BufferedReader bufferedReader = null;
		OutputStream outputStream = null;
		Writer writer = null;
		try
		{
			inputStream = new FileInputStream(PROGRAM_PATH);
			reader = new InputStreamReader(inputStream);
			bufferedReader = new BufferedReader(reader);
			//
			final List<OpenProgram> openPrograms = new LinkedList<OpenProgram>();
			String line = null;
			OpenProgram openProgram = null;
			int index = -1;
			String name = null;
			String path = null;
			while (null != (line = bufferedReader.readLine()))
			{
				if (StringUtil.isEmpty(line) || 
						line.startsWith(CommandConstant.COMMENT_PREFIX))
				{
					// 忽略掉空行 或 注释
					continue;
				}
				index = line.indexOf(Constant.EQUAL_SIGN);
				name = line.substring(0, index);
				index++;
				path = line.substring(index);
				// 忽略掉路径为空的
				if (StringUtil.isEmpty(path))
				{
					continue;
				}
				/** 值处理 */
				// 去掉包围的双引号
				if (path.startsWith(Constant.DOUBLE_QUOTE))
				{
					// 
					path = path.substring(Constant.ONE, path.length() - 1);
				}
				// 路径处理
				path = CommandUtil.pathHandle(path);
				// 构造 打开应用程序对象
				openProgram = new OpenProgram();
				openProgram.setName(name);
				openProgram.setPath(path);
				openPrograms.add(openProgram);
			}
			// 输出到文件
			final String outputPath = ProjectUtil.getAbsolutePath("/doc/" + 
			CommandConstant.OPEN_PROGRAM_FILE_NAME, true);
			outputStream = new FileOutputStream(outputPath);
			// 注意输出文件的编码格式
			writer = new OutputStreamWriter(outputStream, Constant.CHART_SET_GB2312);
			// 输出文件头部
			writer.write("@title 打开应用程序");
			writer.write(Constant.LINE_BREAK);
			writer.write("@rem ########## begin  ##########");
			writer.write(Constant.LINE_BREAK);
			writer.write(Constant.LINE_BREAK);
			// 遍历2次，第一次遍历输出set，第二次输出start
			// 第一次遍历 输出set
			for (OpenProgram o : openPrograms)
			{
				writer.write(Constant.LINE_BREAK);
				writer.write(o.ouputSet());
				writer.write(Constant.LINE_BREAK);
			}
			writer.write(Constant.LINE_BREAK);
			// 第二次遍历 输出start
			for (OpenProgram o : openPrograms)
			{
				writer.write(Constant.LINE_BREAK);
				writer.write(o.ouputStart());
				writer.write(Constant.LINE_BREAK);
			}
			// 输出文件尾部
			writer.write(Constant.LINE_BREAK);
			writer.write("@rem start %%");
			writer.write(Constant.LINE_BREAK);
			writer.write("@rem exit");
			writer.write(Constant.LINE_BREAK);
			writer.write("@exit");
			writer.write(Constant.LINE_BREAK);
			writer.write("@rem ########## end of ##########");
			writer.write(Constant.LINE_BREAK);
			writer.flush();
			
			flag = true;
		} catch (Exception e)
		{
			e.printStackTrace();
		} finally
		{
			// 关闭流
			IOUtil.close(bufferedReader);
			IOUtil.close(reader);
			IOUtil.close(inputStream);
			
			IOUtil.close(writer);
			IOUtil.close(outputStream);
		}
		
		return flag;
	}
	
	/**
	 * 
	 * 描述: 
	 * @author  qye.zheng
	 * @return
	 */
	public static final boolean template()
	{
		boolean flag = false;
		try
		{
			
			flag = true;
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		
		return flag;
	}
	
}
