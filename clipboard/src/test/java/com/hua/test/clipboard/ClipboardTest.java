/**
 * 描述: 
 * ClipboardTest.java
 * 
 * @author qye.zheng
 *  version 1.0
 */
package com.hua.test.clipboard;

// 静态导入
import static org.junit.Assert.assertArrayEquals;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNotSame;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertSame;
import static org.junit.Assert.assertThat;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

import java.awt.Image;
import java.awt.Toolkit;
import java.awt.datatransfer.Clipboard;
import java.awt.datatransfer.DataFlavor;
import java.awt.datatransfer.StringSelection;
import java.awt.datatransfer.Transferable;

import org.junit.Ignore;
import org.junit.Test;

import com.hua.test.BaseTest;



/**
 * 描述: 
 * 
 * @author qye.zheng
 * ClipboardTest
 */
public final class ClipboardTest extends BaseTest {

	
	/**
	 * 
	 * 描述: 
	 * @author qye.zheng
	 * 
	 */
	@Test
	public void testClipboard() {
		try {
			
			
		} catch (Exception e) {
			log.error("testClipboard =====> ", e);
		}
	}	
	
	/**
	 * 
	 * 描述: 从剪贴板中读取文本
	 * @author qye.zheng
	 * 
	 */
	@Test
	public void testGetTextFromClipboard() {
		try {
			Clipboard clipboard =Toolkit.getDefaultToolkit().getSystemClipboard();
			Transferable transferable = clipboard.getContents(null);
			String text = null;
			if (null != transferable)
			{
				// 检查内容是否是文本类型
				if (transferable.isDataFlavorSupported(DataFlavor.stringFlavor))
				{
					text = (String) transferable.getTransferData(DataFlavor.stringFlavor);
				}
			}
			log.warn("testGetTextFromClipboard =====> text = " + text);
		} catch (Exception e) {
			log.error("testGetTextFromClipboard =====> ", e);
		}
	}	
	
	/**
	 * 
	 * 描述: 将文本写到剪贴板
	 * @author qye.zheng
	 * 
	 */
	@Test
	public void testWriteTextToClipboard() {
		try {
			Clipboard clipboard =Toolkit.getDefaultToolkit().getSystemClipboard();
			String text = "哈哈，写到剪贴板";
			Transferable transferable = new StringSelection(text);
			clipboard.setContents(transferable, null);
			
		} catch (Exception e) {
			log.error("testWriteTextToClipboard =====> ", e);
		}
	}
	
	/**
	 * 
	 * 描述: 从剪切板中读取图片
	 * @author qye.zheng
	 * 
	 */
	@Test
	public void testGetImageFromClipboard() {
		try {
			Image image = null;
			Clipboard clipboard =Toolkit.getDefaultToolkit().getSystemClipboard();
			Transferable transferable = clipboard.getContents(null);
			if (null != transferable)
			{
				// 检查内容是否图片类型
				if (transferable.isDataFlavorSupported(DataFlavor.imageFlavor))
				{
					image = (Image) transferable.getTransferData(DataFlavor.imageFlavor);
					log.info("testGetImageFromClipboard =====> " + image.toString());
				}
			}
		} catch (Exception e) {
			log.error("testGetImageFromClipboard =====> ", e);
		}
	}
	
	/**
	 * 
	 * 描述: 将图片写到剪贴板
	 * @author qye.zheng
	 * 
	 */
	@Test
	public void testWriteImageToClipboard() {
		try {
			Clipboard clipboard =Toolkit.getDefaultToolkit().getSystemClipboard();
			Transferable transferable = clipboard.getContents(null);
			String text = null;
			
		} catch (Exception e) {
			log.error("testWriteImageToClipboard =====> ", e);
		}
	}
	
	/*
	 * 复制图片到剪切板。 
	 *  public static void setClipboardImage(final Image image) {  
        Transferable trans = new Transferable() {  
            public DataFlavor[] getTransferDataFlavors() {  
                return new DataFlavor[] { DataFlavor.imageFlavor };  
            }  
  
            public boolean isDataFlavorSupported(DataFlavor flavor) {  
                return DataFlavor.imageFlavor.equals(flavor);  
            }  
  
            public Object getTransferData(DataFlavor flavor)  
                    throws UnsupportedFlavorException, IOException {  
                if (isDataFlavorSupported(flavor))  
                    return image;  
                throw new UnsupportedFlavorException(flavor);  
            }  
  
        };  
        Toolkit.getDefaultToolkit().getSystemClipboard().setContents(trans,  
                null);  
    }  
	 */
	
	/**
	 * 
	 * 描述: 
	 * @author qye.zheng
	 * 
	 */
	@Test
	public void test() {
		try {
			
			
		} catch (Exception e) {
			log.error("test =====> ", e);
		}
	}
	
	/**
	 * 
	 * 描述: 
	 * @author qye.zheng
	 * 
	 */
	@Test
	public void testTemp() {
		try {
			
			
		} catch (Exception e) {
			log.error("testTemp=====> ", e);
		}
	}
	
	/**
	 * 
	 * 描述: 
	 * @author qye.zheng
	 * 
	 */
	@Test
	public void testCommon() {
		try {
			
			
		} catch (Exception e) {
			log.error("testCommon =====> ", e);
		}
	}
	
	/**
	 * 
	 * 描述: 
	 * @author qye.zheng
	 * 
	 */
	@Test
	public void testSimple() {
		try {
			
			
		} catch (Exception e) {
			log.error("testSimple =====> ", e);
		}
	}
	
	/**
	 * 
	 * 描述: 
	 * @author qye.zheng
	 * 
	 */
	@Test
	public void testBase() {
		try {
			
			
		} catch (Exception e) {
			log.error("testBase =====> ", e);
		}
	}
	
	/**
	 * 
	 * 描述: 解决ide静态导入消除问题 
	 * @author qye.zheng
	 * 
	 */
	@Ignore("解决ide静态导入消除问题 ")
	private void noUse() {
		String expected = null;
		String actual = null;
		Object[] expecteds = null;
		Object[] actuals = null;
		String message = null;
		
		assertEquals(expected, actual);
		assertEquals(message, expected, actual);
		assertNotEquals(expected, actual);
		assertNotEquals(message, expected, actual);
		
		assertArrayEquals(expecteds, actuals);
		assertArrayEquals(message, expecteds, actuals);
		
		assertFalse(true);
		assertTrue(true);
		assertFalse(message, true);
		assertTrue(message, true);
		
		assertSame(expecteds, actuals);
		assertNotSame(expecteds, actuals);
		assertSame(message, expecteds, actuals);
		assertNotSame(message, expecteds, actuals);
		
		assertNull(actuals);
		assertNotNull(actuals);
		assertNull(message, actuals);
		assertNotNull(message, actuals);
		
		assertThat(null, null);
		assertThat(null, null, null);
		
		fail();
		fail("Not yet implemented");
		
	}

}
