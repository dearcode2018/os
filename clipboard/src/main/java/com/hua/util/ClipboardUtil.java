/**
 * ClipboardUtil.java
 * @author  qye.zheng
 * 	version 1.0
 */
package com.hua.util;

import java.awt.Toolkit;
import java.awt.datatransfer.Clipboard;
import java.awt.datatransfer.DataFlavor;
import java.awt.datatransfer.StringSelection;
import java.awt.datatransfer.Transferable;

/**
 * ClipboardUtil
 * 描述: 剪贴板-工具
 * @author  qye.zheng
 */
public final class ClipboardUtil
{

	/**
	 * 构造方法
	 * 描述: 
	 * @author  qye.zheng
	 */
	private ClipboardUtil()
	{
	}
	
	/**
	 * 
	 * @description 从剪贴板中读取文本
	 * @return
	 * @author qianye.zheng
	 */
	public static final String getText()
	{
		final Clipboard clipboard =Toolkit.getDefaultToolkit().getSystemClipboard();
		final Transferable transferable = clipboard.getContents(null);
		String text = null;
		if (null != transferable)
		{
			// 检查内容是否是文本类型
			if (transferable.isDataFlavorSupported(DataFlavor.stringFlavor))
			{
				try
				{
					text = (String) transferable.getTransferData(DataFlavor.stringFlavor);
				} catch (Exception e)
				{
					e.printStackTrace();
				}
			}
		}
		
		return text;
	}
	
	/**
	 * 
	 * @description 将文本写到剪贴板
	 * @param text 文本
	 * @author qianye.zheng
	 */
	public static final void writeText(final String text)
	{
		final Clipboard clipboard =Toolkit.getDefaultToolkit().getSystemClipboard();
		final Transferable transferable = new StringSelection(text);
		clipboard.setContents(transferable, null);
	}
	

}
