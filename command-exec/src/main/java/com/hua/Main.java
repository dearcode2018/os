/**
  * @filename Main.java
  * @description 
  * @version 1.0
  * @author qianye.zheng
 */
package com.hua;

import java.io.ByteArrayOutputStream;
import java.io.File;

import org.apache.commons.exec.CommandLine;
import org.apache.commons.exec.DefaultExecutor;
import org.apache.commons.exec.ExecuteWatchdog;
import org.apache.commons.exec.Executor;
import org.apache.commons.exec.PumpStreamHandler;

import com.hua.constant.Constant;
import com.hua.util.ClassPathUtil;

/**
 * @type Main
 * @description 
 * @author qianye.zheng
 */
public final class Main {
    
    /**
     * @description 
     * @param args
     * @author qianye.zheng
     */
    public static void main(String[] args) throws Exception {
        String cmd = null;
        cmd = "ipconfig /all";
        cmd = "pwd";
        //cmd = args[0];
        /*
         * 脚本放在jar中，无法运行，路径例如: /usr/local/shell/command-exec.jar!/BOOT-INF/classes!/script/run.sh
         * 因此，将脚本放在外面才是正确的做法
         * 
         */
        //String path = ClassPathUtil.getClassPath("/script/run.sh");
        //System.out.println(path);
        cmd = System.getProperty("user.dir") + File.separatorChar + "script/run.sh";
        CommandLine cmdLine = CommandLine.parse(cmd);
        Executor executor = new DefaultExecutor();
        executor.setExitValue(0);
        ByteArrayOutputStream baos= new ByteArrayOutputStream();
        PumpStreamHandler streamHandler = new PumpStreamHandler(baos);
        executor.setStreamHandler(streamHandler);
        // 执行监视器 - 看门狗，超时时间，单位: 毫秒
        long timeout = 500;
        ExecuteWatchdog watchdog = new ExecuteWatchdog(timeout);
        
        executor.setWatchdog(watchdog);
        // ShutdownHookProcessDestroyer
        //executor.setProcessDestroyer(null);
        executor.execute(cmdLine);
        byte[] data = baos.toByteArray();
        // windows os 环境下，须制定GB2312编码，linux应该不需要
        String result = new String(data, Constant.CHART_SET_GB2312);
       System.out.println(result);      
        
    }
    
}
