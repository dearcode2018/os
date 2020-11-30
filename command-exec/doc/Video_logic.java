package com.cc.ovp.logic;

import java.io.File;
import java.io.IOException;
import java.io.StringWriter;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.jsp.JspWriter;

import org.apache.commons.exec.CommandLine;
import org.apache.commons.exec.DefaultExecutor;
import org.apache.commons.exec.ExecuteException;
import org.apache.commons.exec.ExecuteWatchdog;
import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.time.DurationFormatUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.JSONArray;
import org.json.JSONObject;

import com.cc.ovp.OVPContext;
import com.cc.ovp.dao.Cata_db;
import com.cc.ovp.dao.Clipboard_db;
import com.cc.ovp.dao.DBHelper_db;
import com.cc.ovp.dao.Data_db;
import com.cc.ovp.dao.UserConfig;
import com.cc.ovp.dao.UserConfigDao;
import com.cc.ovp.dao.VideoConfigDao;
import com.cc.ovp.dao.Video_db;
import com.cc.ovp.dao.Video_log_db;
import com.cc.ovp.dao.Video_pool_db;
import com.cc.ovp.domain.CataProfile;
import com.cc.ovp.domain.PlayProfile;
import com.cc.ovp.domain.Space;
import com.cc.ovp.domain.VideoLog;
import com.cc.ovp.ds.DFSClient;
import com.cc.ovp.enumeration.StorageType;
import com.cc.ovp.service.AuditService;
import com.cc.ovp.service.CataProfileService;
import com.cc.ovp.service.MongoSearchService;
import com.cc.ovp.service.PlayProfileService;
import com.cc.ovp.service.ProgressService;
import com.cc.ovp.service.SpaceService;
import com.cc.ovp.service.StorageTypeService;
import com.cc.ovp.service.VideoLogService;
import com.cc.ovp.service.encode.EncodeTaskService;
import com.cc.ovp.util.Config;
import com.cc.ovp.util.Constants;
import com.cc.ovp.util.DateUtil;
import com.cc.ovp.util.DeveloperUtils;
import com.cc.ovp.util.DingRobot;
import com.cc.ovp.util.Ext;
import com.cc.ovp.util.IPUtil;
import com.cc.ovp.util.Imagick;
import com.cc.ovp.util.JsonUtil;
import com.cc.ovp.util.LogicUtil;
import com.cc.ovp.util.MD5Util;
import com.cc.ovp.util.Pager;
import com.cc.ovp.util.Permiss;
import com.cc.ovp.util.Redis2Utils;
import com.cc.ovp.util.UploadService;
import com.cc.ovp.util.Util;
import com.cc.ovp.util.VideoApi;
import com.cc.ovp.util.VideoStatus;
import com.cc.ovp.web.video.thread.backUrlThread;
import com.cc.usercenter.domain.CcUser;
import com.cc.usercenter.domain.ChildrenUser;
import com.cc.usercenter.service.CcUserService;
import com.cc.usercenter.service.CcuserjoinitemService;
import com.cc.usercenter.service.ChildUserService;
import com.vdurmont.emoji.EmojiParser;

import ayou.system.Command;
import ayou.util.DOC;
import ayou.util.EncryptUtil;
import ayou.util.FileUtil;
import ayou.util.IntUtil;
import ayou.util.ParamUtil;
import ayou.util.ServerUtil;
import ayou.util.StringUtil;
import net.polyv.oss.ali.enumeration.AliOssBucket;
import net.polyv.oss.ali.service.AliOssService;
import net.polyv.vod.config.SpecialCDNConfig;

public class Video_logic {
    
    private static final Log logger = LogFactory.getLog(Video_logic.class);
    
    static int cover_images_count = 6;
    
    private StorageTypeService storageTypeService = (StorageTypeService) OVPContext.getBean("storageTypeService");
    private CcUserService customerService = (CcUserService) OVPContext.getBean("ccUserService");
    private SpaceService spaceService = (SpaceService) OVPContext.getBean("spaceService");
    private VideoLogService videoLogSevice = (VideoLogService) OVPContext.getBean("videoLogService");
    private PlayProfileService playprofileService = (PlayProfileService) OVPContext.getBean("playprofileService");
    private MongoSearchService mongoSearchService = (MongoSearchService) OVPContext.getBean("mongoSearchService");
    private ProgressService progressService = (ProgressService) OVPContext.getBean("ProgressService");
    private AliOssService aliOssService = (AliOssService) OVPContext.getBean("aliOssService");
    private EncodeTaskService encodeTaskService = (EncodeTaskService) OVPContext.getBean("encodeTaskService");
    
    private VideoConfigDao videoConfigDao = (VideoConfigDao) OVPContext.getBean("videoConfigDao");
    
    private UserConfigDao userConfigDao = (UserConfigDao) OVPContext.getBean("userConfigDao");
    
    private ChildUserService childUserService = (ChildUserService) OVPContext.getBean("childUserService");
    
    private CataProfileService cataProfileService = (CataProfileService) OVPContext.getBean("cataProfileService");
    private CcUserService ccUserService = (CcUserService) OVPContext.getBean("ccUserService");
    
    private CcuserjoinitemService ccuserjoinitemService = (CcuserjoinitemService) OVPContext
            .getBean("ccuserjoinitemService");
    
    private SpecialCDNConfig specialCDNConfig = (SpecialCDNConfig) OVPContext.getBean("specialCDNConfig");;
    
    private AuditService auditService = (AuditService) OVPContext.getBean("auditService");
    
    public static String getmdcode(String ip, String agent) {
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH");
        String datestr = df.format(new Date());
        
        return MD5Util.getMD5String(datestr + "feix2012");
    }
    
    // 存logo,头图
    public static String savefile(String file, String result, String userid, String parth) throws IOException {
        String upload_filename_tmp = file;
        String hostid = userid.substring(0, 1);
        
        String mulu = Config.get("htmlPath") + "html/" + parth + "/" + hostid + "/" + userid + "/";
        String file_hash = UUID.randomUUID().toString();
        
        if (parth.equals("head/img")) {
            file_hash = "pt_" + System.currentTimeMillis();
        } else if (parth == "head/video") {
            file_hash = "pt_" + System.currentTimeMillis();
        } else if (parth.equals("logo")) {
            file_hash = "logo_" + userid + System.currentTimeMillis();
        } else if (parth.equals("water")) {
            file_hash = "water_" + userid + System.currentTimeMillis();
        }
        
        if (!FileUtil.exists(mulu)) {
            FileUtil.mkdir(mulu);
        }
        String source_file = mulu + file_hash + result;
        String source_file0 = mulu + "tmp/" + file_hash + result;
        
        // 从临时文件复制到正式文件
        FileUtil.copy(upload_filename_tmp, source_file0, true);
        
        Imagick ickImagick = new Imagick();
        // // 片头不缩小图片
        if (parth.equals("logo")) {
            FileUtil.copy(source_file0, source_file, true);
        } else {
            FileUtil.copy(source_file0, source_file, true);
        }
        // 不压缩
        int success = UploadService.uploadFile(new File(source_file), source_file, "image/jpeg", true);
        String bakmulu = "/html/" + parth + "/" + hostid + "/" + userid + "/" + file_hash + result;
        if (success == VideoStatus.video_uphdfs_ok) {
            IPUtil.delCacheFile(bakmulu);
        }
        return bakmulu;
    }
    
    public static String saveWaterPic(String file, String result, String userid, String parth) throws IOException {
        String upload_filename_tmp = file;
        String hostid = userid.substring(0, 1);
        
        String mulu = Config.get("htmlPath") + "html/" + parth + "/" + hostid + "/" + userid + "/";
        String file_hash = UUID.randomUUID().toString();
        
        file_hash = "water_" + userid + System.currentTimeMillis();
        
        if (!FileUtil.exists(mulu)) {
            FileUtil.mkdir(mulu);
        }
        String source_file0 = mulu + "tmp/" + file_hash + result;
        String water_source_file1 = mulu + file_hash + "_1" + result;
        String water_source_file2 = mulu + file_hash + "_2" + result;
        String water_source_file3 = mulu + file_hash + "_3" + result;
        // 从临时文件复制到正式文件
        FileUtil.copy(upload_filename_tmp, source_file0, true);
        
        FileUtil.copy(source_file0, water_source_file1, true);
        
        UploadService.uploadFile(new File(water_source_file1), water_source_file1, "image/png", true);
        
        FileUtil.copy(source_file0, water_source_file2, true);
        
        UploadService.uploadFile(new File(water_source_file2), water_source_file2, "image/png", true);
        
        FileUtil.copy(source_file0, water_source_file3, true);
        
        UploadService.uploadFile(new File(water_source_file3), water_source_file3, "image/png", true);
        
        return "/html/" + parth + "/" + hostid + "/" + userid + "/" + file_hash;
    }
    
    public static String getExtVideoLockKey(String videoPoolId) {
        return "EXT_LOCK_" + videoPoolId;
    }
    
    // 存视频首图
    public static String savefile2(String file, String result, String userid, String parth) {
        String bakmulu = "";
        try {
            String upload_filename_tmp = file;
            String hostid = userid.substring(0, 1);
            String mulu = Config.get("htmlPath") + parth + "/" + hostid + "/" + userid + "/first_image/";
            UUID id = UUID.randomUUID();
            String file_hash = id.toString();
            if (!FileUtil.exists(mulu)) {
                FileUtil.mkdir(mulu);
            }
            String source_file = mulu + file_hash + result;
            // 从临时文件复制到正式文件
            FileUtil.copy(upload_filename_tmp, source_file, false);
            
            String smallsaveUrl = mulu + file_hash + "_s" + result;
            String bigsaveUrl = mulu + file_hash + "_b" + result;
            Imagick i = new Imagick();
            i.scale(source_file, smallsaveUrl, 120, 90);
            // i.scale(source_file, bigsaveUrl, 640, 480);
            FileUtil.copy(source_file, bigsaveUrl, true);
            
            UploadService.uploadFile(new File(smallsaveUrl), smallsaveUrl, "image/jpeg", true);
            UploadService.uploadFile(new File(bigsaveUrl), bigsaveUrl, "image/jpeg", true);
            bakmulu = userid + "/first_image/" + file_hash;
        } catch (Exception e) {
            // TODO: handle exception
        }
        return bakmulu;
    }
    
    public static void saveMp3(String vid, String file, String userid) {
        try {
            String upload_filename_tmp = file;
            if (!FileUtil.exists(upload_filename_tmp) || FileUtil.getFileSize(upload_filename_tmp) == 0) {
                return;
            }
            String hostid = userid.substring(0, 1);
            String mulu = Config.get("htmlPath") + "video_image/" + hostid + "/" + userid + "/mp3/";
            
            if (!FileUtil.exists(mulu)) {
                FileUtil.mkdir(mulu);
            }
            String source_file = mulu + vid + ".mp3";
            // 从临时文件复制到正式文件
            FileUtil.copy(upload_filename_tmp, source_file, false);
            
            String smallsaveUrl = mulu + vid + ".mp3";
            
            UploadService.uploadFile(new File(smallsaveUrl), smallsaveUrl, "audio/x-m4p", true);
            
        } catch (Exception e) {
            logger.error("vid="+vid+", file="+file+", userid="+userid, e);
        }
    }
    
    // 存视频字幕
    public static String saveSRT(String file, String result, String userid, String parth) {
        String bakmulu = "";
        try {
            String upload_filename_tmp = file;
            String hostid = userid.substring(0, 1);
            String mulu = Config.get("htmlPath") + parth + "/" + hostid + "/" + userid + "/srt/";
            UUID id = UUID.randomUUID();
            String file_hash = id.toString();
            if (!FileUtil.exists(mulu)) {
                FileUtil.mkdir(mulu);
            }
            String source_file = mulu + file_hash + result;
            // 从临时文件复制到正式文件
            FileUtil.copy(upload_filename_tmp, source_file, false);
            
            String smallsaveUrl = mulu + file_hash + result;
            
            UploadService.uploadFile(new File(smallsaveUrl), smallsaveUrl, "text/vnd.rn-realtext", true);
            
            bakmulu = userid + "/srt/" + file_hash;
        } catch (Exception e) {
            logger.error("file="+file+", result="+result+", userid="+userid+", parth="+parth, e);
        }
        return bakmulu;
    }
    
    public static boolean saveFirstImage(String fileUrl, String fileName, String userid, String videoid) {
        String result = StringUtil.getExt(fileName);
        
        if (".gif".equals(result) || ".jpg".equals(result) || ".bmp".equals(result) || ".png".equals(result)) {
            // 更新 ext
            String hostid = userid.substring(0, 1);
            String mulu = savefile2(fileUrl, result, userid, "video_image");
            String firstImage = mulu + "_s" + result;
            String firstImageBig = mulu + "_b" + result;
            
            LinkedHashMap<String, Object> map = new LinkedHashMap<String, Object>();
            map.put("first_image", firstImage);
            map.put("first_image_b", firstImageBig);
            Video_pool_db vpdb = new Video_pool_db(hostid);
            vpdb.updateExt(videoid, map);
            
            DBHelper_db db = new DBHelper_db();
            db.addvideoRecentFirstImage(LogicUtil.vidFromVideoPoolId(videoid), firstImageBig, firstImage, userid);
            try {
                Redis2Utils.del("cacheImage" + videoid + "_" + hostid + "0");
                Redis2Utils.del("cacheImage" + videoid + "_" + hostid + "1");
            } catch (Exception e) {
                logger.error(e.getMessage(), e);
            }
            
            LogicUtil.cleanVXML(videoid);
            return true;
        } else {
            return false;
        }
        
    }
    
    public static boolean saveWebSRT(String title, String fileUrl, String fileName, String userid, String videoid) {
        String result = StringUtil.getExt(fileName);
        
        if (".srt".equals(result) || ".SRT".equals(result)) {
            String hostid = userid.substring(0, 1);
            Video_pool_db vpdb = new Video_pool_db(hostid);
            DOC video_pool = vpdb.getOne(videoid);
            String srt = video_pool.get("video_srt");
            
            String mulu = saveSRT(fileUrl, result, userid, "video_srt");
            srt = title + "," + mulu + result + ";" + srt;
            String[] srtlist = srt.split(";");
            // 最多三个
            if (srtlist.length > 3) {
                StringBuffer sb = new StringBuffer();
                for (int i = 0; i < 3; i++) {
                    sb.append(srtlist[i] + ";");
                }
                srt = sb.toString();
                
            }
            // 最多加3个字幕
            
            vpdb.updateExt(videoid, "video_srt", srt);
            logger.info("upload srt file for " + videoid + " mulu:" + mulu);
            LogicUtil.reloadRedisVideoJson(videoid);
            return true;
        } else {
            return false;
        }
        
    }
    
    public static boolean deleteWebSRT(String userid, String videoid, int id) {
        
        String hostid = userid.substring(0, 1);
        Video_pool_db vpdb = new Video_pool_db(hostid);
        DOC video_pool = vpdb.getOne(videoid);
        
        String srt = video_pool.get("video_srt");
        
        String[] srtlist = srt.split(";");
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < srtlist.length; i++) {
            if (i != id - 1) {
                sb.append(srtlist[i] + ";");
            }
        }
        
        vpdb.updateExt(videoid, "video_srt", sb.toString());
        return true;
        
    }
    
    /**
     * 保存上传文件
     */
    public void saveFile(String upload_file, String source_file, String upload_filename, String upload_fileext) {
        FileUtil.copy(new File(upload_file), source_file, true);
        logger.info("copy file " + upload_file + " to " + source_file);
        UploadService.uploadFile(source_file, source_file, "video/flv", true);
        
        logger.info(
                ":::saveFile:::::Hdfs::::::::::::::::::" + source_file + " 目标文件是否存在:" + new File(source_file).exists());
    }
    
    /**
     * 上传视频源文件到 DFS 或者 OSS
     * @param storageType 存储类型
     * @param groupName 组名，仅当上传到 DFS 时使用，为空则自动获取分组
     * @param localfile 本地文件路径，例如 /data/htmlfile/abc.mp4
     * @param fileName 目标路径，例如 /data/htmlfile/e/video_source/e6b23c6f51/2/e6b23c6f51350f106556806a576b1942.mp4
     * @return 1表示成功，其它值表示失败
     */
    public int uploadFile(StorageType storageType, String groupName, String localfile, String fileName) {
        if (StorageType.DFS.equals(storageType)) {
            return UploadService.uploadFile(groupName, localfile, fileName, "video/flv", true);
        }
        
        // 上传到 OSS 时，根据目标路径，判断使用哪个桶
        // 普通视频的 http 路径例如 video_source/e6b23c6f51/2/e6b23c6f51350f106556806a576b1942.mp4
        // 源文件播放的视频，http 路径例如 mp4/e6b23c6f51/5/e6b23c6f5129353b997a17a402c221a5_1.mp4
        String userId = StringUtils.substringAfterLast(fileName, "/").substring(0, 10);
        boolean isSource = fileName.contains("video_source");
        AliOssBucket bucket;
        String httpPath;
        if (isSource) {
            // 如果用户做了定制，则用定制的桶
            AliOssBucket userSrcBucket = AliOssBucket.getInstance(specialCDNConfig.getSrcBucket(userId));
            bucket = userSrcBucket != null ? userSrcBucket : AliOssBucket.VOD_VIDEO_SRC;
            httpPath = fileName.substring(fileName.indexOf("video_source/"));
        } else {
            AliOssBucket userMpvBucket = AliOssBucket.getInstance(specialCDNConfig.getMpvBucket(userId));
            bucket = userMpvBucket != null ? userMpvBucket : AliOssBucket.VOD_VIDEO_MPV;
            httpPath = "mp4/" + fileName.substring(fileName.indexOf("video_target/") + "video_target/".length());
        }
        return aliOssService.opsForUpload().upload(bucket, localfile, httpPath) == null ?
                VideoStatus.video_uphdfs_fail : 1;
    }
    
    /**
     * 只使用脚本复制文件 不上传到fastDFS
     */
    public void onlySaveFile_one(String upload_file, String source_file, String upload_filename,
            String upload_fileext) {
        // FIXME 脚本里先创建文件夹，再删除的方式，若遇到权限，文件占用等问题，在程序上没有任何感知
        String command = "/bin/bash " + Config.get("svndir") + "/WEB-INF/sh/video_copy.sh " + upload_file + " "
                + source_file;
        
        Command.run(command, null);
        logger.info(" ::::::command copy file==" + command);
        File uploadFile = new File(upload_file);
        File sourceFile = new File(source_file);
    
        logger.info(":::saveFile:::::::::::::::::::::::" + source_file + " exists:" + sourceFile.exists() + " isDir:" + sourceFile.isDirectory() + " " + upload_file + " exists:" + uploadFile.exists() + " isDir:" + uploadFile.isDirectory());
        
    }
    
    /*
     * upload需要转码的接口
     */
    public String upload(ParamUtil pu, JspWriter out, final String hostid, String userid) throws Exception {
        final String upload_file = pu.getSourceString("Filedata");
        
        String upload_filename = pu.getSourceString("Filedata.filename");
        // 额外参数
        String state = pu.getSourceString("state");
        
        // web后端上传，用表单用文件名当标题的key
        String title = pu.getSourceString(upload_filename);
        logger.info("upload info:" + userid + " filename:" + title);
        if (!StringUtil.isFine(title)) {
            // 客户端指定上传文件的文件名编码
            String filenameCharset = pu.getString("fcharset");
            
            if (StringUtil.isFine(filenameCharset)) {
                try {
                    logger.info("change charset for uploadify: " + filenameCharset);
                    title = new String(upload_filename.getBytes(filenameCharset), "UTF-8");
                } catch (Exception e) {
                    logger.error("filenameCharset exception: " + e.getMessage(), e);
                }
                // 将文件名转成UTF-8
                
            } else {
                title = upload_filename;
            }
        }
        // api方式传递过来的情况，附带title参数
        String apiTitle = pu.getString("title");
        
        if (StringUtil.isFine(apiTitle)) {
            title = apiTitle;
        }
        // 最后修正
        if (!StringUtil.isFine(title)) {
            title = upload_filename;
        }
        
        String upload_fileext = StringUtil.getExt(upload_filename);
        String tag = pu.getString("tag", "");
        String desc = pu.getSourceString("desc");
        if (!StringUtil.isFine(desc)) {
            desc = pu.getSourceString("describ");
            if (!StringUtil.isFine(desc)) {
                desc = "";
            }
        }
        tag = tag.replaceAll("，", ",");
        long cataid = pu.getLong("cataid");
        
        //// 子账号
        String childusername = "";
        String uploadIp = pu.getIP();
        String childuserid = "";
        // HttpSession session=pu.getRequest().getSession();
        if (pu.getString("childuserid") != null) {
            childusername = pu.getString("childusername");
            childuserid = pu.getString("childuserid");
        }
        
        // 获取转码后返回链接
        String callbackurl = pu.getString("callbackurl");
        // 修改文件名
        String video_hash = pu.getString("videohash");
        if (!StringUtil.isFine(video_hash)) {
            video_hash = MD5Util.getMD5String("" + System.currentTimeMillis(), userid);
            
        }
        
        final String filename = LogicUtil.getVideoPublicFilePath(video_hash, userid);// video_hash.charAt(video_hash.length()
        
        String source_file = LogicUtil.getSourceFilePath(filename + upload_fileext, hostid);// 获得文件名
        // 从临时文件复制到正式文件
        if (!"nocopy".equals(pu.getString("nocopy"))) {
            onlySaveFile_one(upload_file, source_file, video_hash, upload_fileext);
            
        }
        long fileSize = FileUtil.getFileSize(source_file);
        
        String fileMd5 = pu.getString("fileMd5");
        if (StringUtil.isFine(fileMd5)) {
            String uploadFileMd5 = MD5Util.md5sum(source_file);
            logger.info("userid:" + userid + " uploadFile:" + title + " upload_file:" + source_file + " uploadFileMd5:"
                    + uploadFileMd5 + " userFileMd5:" + fileMd5);
            if (!fileMd5.equalsIgnoreCase(uploadFileMd5)) {
                return null;
            }
        }
        
        String source = "";
        if (StringUtil.isFine(pu.getString("source"))) {
            source = pu.getString("source");
        }
        logger.info("source:" + source);
        // keepsource参数保留原文件播放，不做编码
        uploadToDB(childuserid, childusername, uploadIp, source, hostid, userid, source_file, video_hash, filename,
                upload_fileext, fileSize, title, tag, desc, callbackurl, cataid, pu.getString("watermark"), pu.getString("watermarkLocation"),
                pu.getString("luping"), "1".equals(pu.getString("keepsource")), state, false, true);
        
        try {
            mongoSearchService.insertFromVideo(video_hash, hostid);
        } catch (Exception e) {
            logger.error("编码工作全部完成，推到搜索接口时发生异常", e);
        }
        return video_hash;
    }
    
    private void runCmd(String cmd) {
        try {
            CommandLine cmdLine = CommandLine.parse(cmd);
            DefaultExecutor executor = new DefaultExecutor();
            executor.setExitValue(0);
            ExecuteWatchdog watchdog = new ExecuteWatchdog(3600 * 1000);
            executor.setWatchdog(watchdog);
            int exitValue = executor.execute(cmdLine);
            
        } catch (ExecuteException e) {
            // TODO Auto-generated catch block
            logger.error("cmd="+cmd, e);
        } catch (IOException e) {
            // TODO Auto-generated catch block
            logger.error("cmd="+cmd, e);
        }
    }
    
    public int uploadToDB(String childuserid, String childusername, String uploadIp, String source, final String hostid, final String userid, final String source_file, final String video_hash, String filename, String upload_fileext, long fileSize, String title, String tag, String describ, String callbackurl, long cataid, String watermark, String watermarkLocation, String luping, boolean keepsource, String state, boolean fromLive, boolean imageQueue) {
        return uploadToDB(childuserid, childusername, uploadIp, source, hostid, userid, source_file, video_hash,
                filename, upload_fileext, fileSize, title, tag, describ, callbackurl, cataid, watermark, watermarkLocation, luping,
                keepsource, state, fromLive, null, imageQueue, 0, false);
    }
    
    public int uploadToDB(String childuserid, String childusername, String uploadIp, String source, final String hostid, final String userid, final String source_file, final String video_hash, String filename, String upload_fileext, long fileSize, String title, String tag, String describ, String callbackurl, long cataid, String watermark, String watermarkLocation, String luping, boolean keepsource, String state, boolean fromLive, boolean imageQueue, int VideoErrorCode, boolean change_video) {
        return uploadToDB(childuserid, childusername, uploadIp, source, hostid, userid, source_file, video_hash,
                filename, upload_fileext, fileSize, title, tag, describ, callbackurl, cataid, watermark, watermarkLocation, luping,
                keepsource, state, fromLive, null, imageQueue, VideoErrorCode, change_video);
    }
    
    /**
     * 上传视频后的相关处理：分析视频信息，上传文件到DFS或OSS，插入数据库记录到 video_pool_*, video_log
     * @param upload_fileext 源文件的后缀，例如 .mp4 / .avi
     * @param watermarkLocation
     */
    public int uploadToDB(String childuserid, String childusername, String uploadIp, String source, final String hostid, final String userid, 
            final String source_file, final String video_hash, String filename, String upload_fileext, long fileSize, String title, String tag, 
            String describ, String callbackurl, long cataid, String watermark, String watermarkLocation, String luping, boolean keepsource, 
            String state, boolean fromLive, String[] videoPoolIds, boolean imageQueue, final int VideoErrorCode, boolean change_video) {
        
        PlayProfile playProfile = playprofileService.getById(userid);
        DOC playext = new DOC();
        if (playProfile != null) {
            playext = com.cc.ovp.util.Ext.parseJson(playProfile.getExt());
        }
        
        if (StringUtil.isFine(title) && title.length() > 200) {
            title = title.substring(0, 200);
        }
        
        Video_pool_db vpdb = new Video_pool_db(hostid);
        
        String concatVideoPoolIds = "";
        
        boolean concatMode = false;
        // 合并视频采用多个视频的最大分辨率
        int concatWidth = 0;
        long concatFilesize = 0;
        int concatOriginal_tot_fr = 0;
        String concatDefinition = "";
        String concatOriginal_encoding = "";
        // 采用多个视频的最小码率
        int concatBr = 0;
        int concatAb = 0;
        // 总时长
        double concatPlaytime = 0;
        DOC concatExt = null;
        // 合并模式
        if (videoPoolIds != null && (videoPoolIds.length == 2 || videoPoolIds.length == 3)) {
            concatMode = true;
            for (int i = 0; i < videoPoolIds.length; i++) {
                logger.info(videoPoolIds[i]);
                DOC videoPool = vpdb.getOne(videoPoolIds[i]);
                
                if (videoPool == null) {
                    // 视频不存在无法合并
                    return -1;
                }
                if (concatExt == null) {
                    concatExt = new DOC();
                }
                String original_definition = videoPool.get("original_definition");
                int width = Integer.parseInt(original_definition.split("x")[0]);
                
                if (width > concatWidth) {
                    concatWidth = videoPool.geti("width");
                    concatDefinition = videoPool.get("original_definition");
                }
                if (concatBr == 0) {
                    concatBr = videoPool.geti("original_br");
                } else if (videoPool.geti("original_br") < concatBr) {
                    concatBr = videoPool.geti("original_br");
                }
                
                if (concatAb == 0) {
                    concatAb = videoPool.geti("original_ab");
                } else if (videoPool.geti("original_ab") < concatAb) {
                    concatAb = videoPool.geti("original_ab");
                }
                concatPlaytime += videoPool.getd("playtime");
                concatOriginal_tot_fr += videoPool.getd("original_tot_fr");
                if (i == 0) {
                    concatVideoPoolIds = videoPoolIds[i];
                } else {
                    concatVideoPoolIds = concatVideoPoolIds + "," + videoPoolIds[i];
                }
                if (!StringUtil.isFine(concatOriginal_encoding)) {
                    concatOriginal_encoding = videoPool.get("original_encoding");
                }
                concatFilesize += videoPool.getl("source_filesize");
                
            }
            
            concatExt.put("original_definition", concatDefinition);
            concatExt.put("original_br", concatBr + "");
            concatExt.put("original_ab", concatAb + "");
            concatExt.put("playtime", concatPlaytime + "");
            concatExt.put("source_filesize", concatFilesize + "");
            concatExt.put("original_tot_fr", concatOriginal_tot_fr + "");
            concatExt.put("original_encoding", concatOriginal_encoding);
            
            String durationString = DurationFormatUtils.formatDuration(Math.round(concatPlaytime) * 1000, "HH:mm:ss",
                    true);
            concatExt.put("original_duration", durationString);
            
            logger.info("concatVideoPoolIds:" + concatVideoPoolIds);
            logger.info("concatFilesize:" + concatFilesize);
            logger.info("concatBr:" + concatBr);
            logger.info("concatDefinition:" + concatDefinition);
            logger.info("concatPlaytime:" + concatPlaytime);
            logger.info("durationString:" + durationString);
            
        }
        // 保存到数据库
        DBHelper_db helper = new DBHelper_db();
        
        DOC ext = new DOC();
        int status = VideoStatus.video_trans_waite;
        
        // 处理失败时源文件的保存在oss上的路径，如 unknown_videos/baf4ad57f6c33e0df3e619f8ec9fb94d.mp4
        String unknownVideoPath = "unknown_videos/" + video_hash + upload_fileext;
        try {
            if (concatMode) {
                // 合并模式通过concatExt带入参数
                keepsource = false;
                fileSize = concatFilesize;
                concatExt.put("concatMode", "1"); // 合并标记
                
                ext = getVideoInfo(playext, concatExt, source_file, video_hash, cataid, hostid, filename,
                        upload_fileext, userid, fileSize, keepsource);
                
                // 合并模式md5用vid计算
                String md5checksum = EncryptUtil.getMD5(concatVideoPoolIds);
                ext.put("md5checksum", md5checksum);
                
            } else {
                ext = getVideoInfo(playext, source_file, video_hash, cataid, hostid, filename, upload_fileext, userid,
                        fileSize, keepsource);
                
                // 分析视频失败
                if (ext == null) {
                    
                    if (FileUtil.getFileSize(source_file) == 0) {
                        logger.info(
                                ">>>>>>>源文件大小为0>>>>>>>>http://v.polyv.cn/uc/services/getrealpath?path=" + source_file);
                        status = VideoStatus.sourcefilesize0;
                    } else {
                        logger.info(">>>>>>>ffmpeg分析源文件出错>>>>>>>>http://v.polyv.cn/uc/services/getrealpath?path="
                                + source_file);
                        status = VideoStatus.video_source_fail;
                    }
                    // upload to unknown_videos
                    helper.addvideoCallbackQueue(video_hash, 0, "invalidVideo", "");
                    aliOssService.opsForUpload().uploadArchive(AliOssBucket.POLYV_UPLOAD, source_file, unknownVideoPath);
                    return status;
                }
                
                logger.info("display_aspect_ratio:" + ext.get("display_aspect_ratio"));
                
                if (StringUtil.isFine(ext.get("new_source_file"))) {
                    String new_source_file = ext.get("new_source_file");
                    FileUtil.copy(new_source_file, source_file, true);
                    FileUtil.unlink(new_source_file);
                    logger.info("move to new source ... unlink .." + new_source_file);
                    ext.remove("new_source_file");
                }
                
                if (fromLive) {
                    ext.put("fromLive", 1 + "");
                } else {
                    ext.put("fromLive", 0 + "");
                }
                
                logger.info(video_hash + " file exits:" + new File(source_file).exists());
                String md5checksum = EncryptUtil.md5sumForFile(source_file);
                ext.put("md5checksum", md5checksum);
            }
            
            ext.put("type", "1");
    
            // 处理存储类型
            StorageType storageType = storageTypeService.getStorageTypeUpload(video_hash);
            ext.put("storage_type", storageType.getType());
            if (StorageType.OSS.equals(storageType)) { // 如果仅传到 OSS ，则将该视频的全部分组都设为 group0
                int levelCount = ext.get("out_br").split(",").length;
                for (int i = 1; i <= levelCount; i++) {
                    ext.put("level_group_" + i, "group0");
                }
            }
            
            int upret = 0; // 上传文件结果
            if (!keepsource) {
                keepsource = "1".equals(ext.get("keepsource")) || "1".equals(ext.get("mp3keepsource"));
            }
            
            String groupName = playext.get("groupname");
            
            if (keepsource) {
                
                // 留意，只要是 keepsource 为 true，无论以下哪种情况，保存到 dfs_name 的 src 都是基本相同的（只有后缀名的处理稍有不同，其它都一样）
                String target = filename + "_" + 1 + upload_fileext;
                String basefileurl = LogicUtil.getTargetFilePath(target, hostid);
                ext.put("keepsource", "1");
                
                // 保留原文件播放，并且转封装mp4
                if ("1".equals(ext.get("keepsource_mp4")) && !upload_fileext.equals(".mp4") && VideoErrorCode == 0) {
                    upload_fileext = ".mp4";
                    String target2 = filename + "_" + 1 + upload_fileext;
                    basefileurl = LogicUtil.getTargetFilePath(target2, hostid);
                    
                    String mp4tempfile = "/data/videotemp/formp4_" + video_hash + ".mp4";
                    
                    String ffmpegstring = "/data/ffmpeg.3.0.2/bin/ffmpeg3 -i " + source_file
                            + " -vcodec copy -acodec copy -y " + mp4tempfile;
                    String extqtfast = "/data/ffmpeg/bin/qtfaststart " + mp4tempfile + " " + basefileurl;
                    
                    String dir = basefileurl.substring(0, basefileurl.lastIndexOf("/") + 1);
                    if (!FileUtil.exists(dir)) {
                        FileUtil.mkdir(dir);
                    }
                    
                    runCmd(ffmpegstring);
                    runCmd(extqtfast);
                    
                    logger.info("keep source and convert to mp4:" + ffmpegstring);
                    if (!FileUtil.exists(basefileurl)) {
                        FileUtil.copy(mp4tempfile, basefileurl, true);
                    }
                    upret = uploadFile(storageType, groupName, basefileurl, basefileurl);
                    
                    // 保留源文件播放，并且扩展名是mp4，需要做流化处理
                } else if (upload_fileext.equals(".mp4") && VideoErrorCode == 0) {
                    
                    // 如果已经faststart过的视频，不会把视频拷贝过去。这时候如果视频已经存在，就无法判断，所以在流化之前先删除
                    FileUtil.unlink(basefileurl);
                    
                    String extqtfast = "/data/ffmpeg/bin/qtfaststart " + source_file + " " + basefileurl;
                    
                    String dir = basefileurl.substring(0, basefileurl.lastIndexOf("/") + 1);
                    if (!FileUtil.exists(dir)) {
                        FileUtil.mkdir(dir);
                    }
                    runCmd(extqtfast);
                    
                    logger.info("keep source and qtfaststart mp4:" + extqtfast);
                    if (!FileUtil.exists(basefileurl)) {
                        FileUtil.copy(source_file, basefileurl, true);
                    }
                    upret = uploadFile(storageType, groupName, basefileurl, basefileurl);
                    
                } else {
                    upret = uploadFile(storageType, groupName, source_file, basefileurl);
                    
                }
                // 修改输出扩展名为原文件扩展名
                String swflink1 = ext.get("swf_link1");
                swflink1 = swflink1.substring(0, swflink1.length() - 4) + upload_fileext;
                ext.put("swf_link1", swflink1);
                ext.put("mp4_link1", swflink1);
                
                // keep source的视频，非加密
                ext.put("seed", 0);//
    
                // 上传完成，删除faststart过的本地视频文件
                FileUtil.unlink(basefileurl);
                logger.info("delete faststart file:" + basefileurl);
            } else {
                // 非保留源文件播放的普通视频
                if (!concatMode) {
                    upret = uploadFile(storageType, groupName, source_file, source_file);
                    logger.info(source_file + " upload dfs return:" + upret);
                    // 0来自fastdfs，42为 polyv 上传错误
                    if (upret == 0 || upret == 42) {
                        DingRobot.send(" file:" + source_file + " upload to fastdfs failed, file exits? "
                                + new File(source_file).exists());
                        // 上传失败，备份文件
                        aliOssService.opsForUpload().uploadArchive(AliOssBucket.POLYV_UPLOAD, source_file, unknownVideoPath);
                        return VideoStatus.video_uphdfs_fail;
                    }
                }
                
            }
            // 如果上传成功删除源文件
            if (upret != VideoStatus.video_uphdfs_fail) {
                FileUtil.unlink(source_file);
                logger.info("delete source file:" + source_file);
            }
            
        } catch (Exception e1) {
            helper.addvideoCallbackQueue(video_hash, 0, "invalidVideo", "");
            // upload to unknown_videos
            logger.info("moving " + source_file + " to " + "/data/unknown_videos/" + video_hash + upload_fileext);
            
            // 异常时有可能已经上传过一次了,做一次检查
            aliOssService.opsForUpload().uploadArchive(AliOssBucket.POLYV_UPLOAD, source_file, unknownVideoPath);
            status = VideoStatus.video_source_fail;
            logger.info(
                    "===============================================exception by get videoinf=========================");
            logger.error(String.format("%s exception", video_hash), e1);
        }
        ext.put("callbackurl", callbackurl);
        ext.put("state", state);
        helper.addvideoCallbackQueue(video_hash, 0, "upload", "");
        //// 子账号
        String field1 = "";
        // api可能通过source参数带来子账号
        String cuserid = "";
        if (StringUtil.isFine(source)) {
            cuserid = source;
            
        } else {
            cuserid = childuserid;
        }
        if (StringUtil.isFine(cuserid)) {
            ChildrenUser childuser = childUserService.findOneChildUser(cuserid);
            if (childuser != null) {
                // field1用作childuserid
                field1 = childuser.getChilduserid();
                ext.put("childusername", childuser.getChildusername());
                ext.put("childuserid", cuserid);
            } else {
                // 如果来自API
                ext.put("childusername", source);
            }
        }
        
        logger.info("childuserid:" + childuserid + " source:" + source);
        ext.put("uploadIp", uploadIp);
        ext.put("source_filesize", "" + fileSize);
        if (StringUtil.isFine(watermark)) {
            ext.put("watermark", watermark);
        }
        // 控制自定义水印的位置
        if (StringUtil.isFine(watermarkLocation)) {
            logger.info(String.format("%s watermarkLocation %s", video_hash, watermarkLocation));
            // 1：左上角；2：右上角；3：左下角；4：右下角；0:不显示
            String[] validLocations = {"0","1", "2", "3", "4"};
            if (ArrayUtils.contains(validLocations, watermarkLocation)) {
                ext.put("watermarklocation", watermarkLocation);
            }
        }
        ext.put("luping", ("1".equals(ext.get("luping")) || "1".equals(luping)) ? "1" : "0");
        long ptime = System.currentTimeMillis();
        long lmodify = ptime;
        
        String hlsLevel = ext.get("hlsLevel");
        String previewDurationStr = ext.get("previewDuration");
        int previewDuration;
        byte isHlsDefault = (byte) 1;
        byte previewSettingLevel = (byte) 0;
        UserConfig userConfig = null;
        if (VideoErrorCode != 0) {
            ext.put("duration", "00:00:00");
        }
        
        if(StringUtil.isFine(hlsLevel)) {
            isHlsDefault = (byte) 0;
        }else {
            userConfig = userConfigDao.getUserConfig(userid);
            hlsLevel = userConfig.getHlsLevel();
        }
        
        if(StringUtil.isFine(previewDurationStr)) {
            previewSettingLevel = (byte) 1;
            previewDuration = Integer.parseInt(previewDurationStr);
        }else {
            previewDuration = userConfig!=null? userConfig.getPreviewDuration(): userConfigDao.getUserConfig(userid).getPreviewDuration();
        }
        // 需要配置移动端加密选项
        videoConfigDao.setVideoConfig(video_hash, userid, hlsLevel, previewDuration, previewSettingLevel, isHlsDefault);
        
        try {
            
            Space space = new Space();
            space.setDiskspace(fileSize);
            space.setUserid(userid);
            String indate = DateUtil.getCurrDate("yyyy-MM-dd");
            space.setIndate(indate);
            spaceService.updateSpace(space);
            
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }
    
        String publish_url = "";
        if (change_video) {
            ext.put("videoChanged", "1");
            DOC oldVideo = vpdb.getOne(video_hash);
            if (oldVideo != null) {
                // 保留外链
                publish_url = oldVideo.get("publish_url");
                
                // 如果为替换视频，保留ppt,字幕，子视频信息
                ext.putValueIfNotNull("ppt", oldVideo.geto("ppt"));
                ext.putValueIfNotNull("video_srt", oldVideo.geto("video_srt"));
                ext.putValueIfNotNull("subvideo", oldVideo.geto("subvideo"));
                
                // 保留视频设置的密码，预览，访客和授权
                ext.putValueIfNotNull("password", oldVideo.geto("password"));
                ext.putValueIfNotNull("qid", oldVideo.geto("qid"));
                ext.putValueIfNotNull("playauth", oldVideo.geto("playauth"));
                ext.putValueIfNotNull("previewDuration", oldVideo.geto("previewDuration"));
            }
        }
        if (keepsource) {
            // 源文件播放，处理开始
            int videostatus = VideoStatus.video_appr_waite; // 原视频播放，短视频使用场景，先出后审
            try {
                if (publishKeepSourceNow(userid)) {
                    videostatus = VideoStatus.video_publish_ok2;
                }
                
            } catch (Exception e) {
                logger.error(e.getMessage(), e);
            }
            
            videostatus = VideoErrorCode != 0 ? VideoErrorCode : videostatus;
            // 避免数据库超长出错
            if (StringUtil.isFine(describ) && describ.length() >= 1000) {
                describ = describ.substring(0, 1000);
            }
            
            vpdb.rinsert(video_hash, 1, "1", userid, EmojiParser.removeAllEmojis(title),
                    EmojiParser.removeAllEmojis(describ), publish_url, Ext.setJson(ext), tag, userid, lmodify, ptime, 0, 0,
                    videostatus, field1, "", 0, fileSize);
            updateUserSpace(userid);
            // 修改当前目录，并重新计算目录视频数量
            this.setCata(cataid, hostid, video_hash);
            
            if (VideoErrorCode != 0) {
                return 0;
            }
    
            videoLogSevice.insertLog(video_hash, 1, userid, ext.get("resolution"), title, "0", ext.get("first_image"),
                    ext.get("swf_link1"), "0", "0", ptime, ptime, "1", videostatus, videostatus, ext.get("isVip"), "",
                    "", VideoLog.TABLENAME_VALUE);
            
            vpdb.insertToBak(video_hash, "all");
            
            try {
                mongoSearchService.insertFromVideo(video_hash, hostid);
            } catch (Exception e) {
            }
            // 源文件播放，不需要编码，所以要截一张首图。进入截图队列
            if (imageQueue) {
                helper.addvideoImageQueue(video_hash);
            }
            
            // 根据需要额外截图审核
            if (ext.geti("isAudio", 0) == 0) {
                auditService.auditVideoIfNecessary(video_hash);
            }
            return 0;// 不往下执行
            // 源文件播放，处理结束
        } else {
            // 普通视频处理开始（非源文件播放）
            // 入库可能碰到ext并发访问问题，增加cached锁控制
            int exp = 5 * 1000; // 5秒过期
            long timeout = 60L; // 60 seconds超时
            boolean runStatus = false;
            String key = Video_logic.getExtVideoLockKey(video_hash);
            for (int i = 0; i < 10; i++) {
                String value = Redis2Utils.lock(key, exp);
                if (null != value) {
                    runStatus = vpdb.rinsert(video_hash, 1, "1", userid, EmojiParser.removeAllEmojis(title),
                            EmojiParser.removeAllEmojis(describ), publish_url, Ext.setJson(ext), tag, userid, lmodify, ptime, 0,
                            0, status, field1, "", 0, fileSize);
                    updateUserSpace(userid);
                    
                    try {
                        Redis2Utils.unlock(key, value);
                    } catch (Exception e) {
                        logger.error(e.getMessage(), e);
                    }
                    break;
                } else {
                    try {
                        Thread.sleep(1000);
                    } catch (InterruptedException e) {
                        logger.error(e.getMessage(), e);
                    }
                }
            }
            if (!runStatus) {
                LogicUtil.sendMail("update video extInfo failed",
                        "videoPoolId:" + video_hash + " ext:" + Ext.setJson(ext));
                return 0;
            }
            // 插入成功，重算分类，设置分类要在编码之前，避免分类模板有问题
            this.setCata(cataid, hostid, video_hash);
            
            // 普通视频先截一张首图，以优化首图生成时间，http://pm.igeeker.org/browse/LIVE-12295
            // 合并模式，要编码后才有文件，这里不做处理
            // 源文件转HLS也是在这个地方先截一张首图
            if (ext.geti("isAudio", 0) == 0 && !concatMode) {
                helper.addvideoImageQueue(video_hash);
                // 根据需要额外截图审核
                auditService.auditVideoIfNecessary(video_hash);
            }
            // 普通视频处理（非源文件播放）结束
        }
        
        if (ext == null || ext.size() == 0) {
            // 源视频分析失败
            videoLogSevice.insertLog(video_hash, 1, userid, "", EmojiParser.removeAllEmojis(title), "0", "", "", "0",
                    "0", ptime, ptime, "1", VideoStatus.video_trans_ing, status, ext.get("isVip"),"","",
                    VideoLog.TABLENAME_VALUE);
            String logtxt = null;
            if (FileUtil.getFileSize(source_file) == 0) {
                logtxt = "源视频大小为0:" + source_file;
            } else {
                logtxt = "源视频分析失败 ffmpeg -i " + source_file;
            }
            videoLogSevice.setException(userid, video_hash, logtxt, ptime, 1);
        } else {
            if (keepsource) {
                return 0;// 不往下执行
            }
            // 通过ext传递合并vid
            String videoLogExt = "";
            if (concatMode) {
                videoLogExt = concatVideoPoolIds;
            }
            
            
            boolean isTwoPass = "1".equals(playext.get("twopass"));
            
            boolean isGPUTask = LogicUtil.isGPUTask(ext, playext);
            String field1_videolog = "";
            logger.info("rotate:" + ext.get("rotate"));
            //m3u8可能存在DISCONTINUITY标签，需要force_dts_monotonicity选项
            // 设置了2pass的用户，是否考虑不采用gpu编码？  gpu暂不支持rotate旋转的视频:"Impossible to convert between the formats supported by the filter 'transpose' and the filter 'auto_scaler_0'"
            if(isGPUTask && !concatMode && !source_file.endsWith("m3u8") && "".equals(ext.get("rotate"))) {
                field1_videolog = VideoLog.TASK_TYPE_GPU;
                logger.info("is gpu task");
            }
            
            String out_br = ext.get("out_br");
            String my_br = ext.get("my_br");
            int waitStatus = VideoStatus.video_trans_waite;
            int coding = VideoStatus.video_trans_ing;// 首次转码coding=VideoStatus.video_trans_ing,再次转码coding=25或者26
            // 如果是替换视频，标记为重编。编码会对重编的情况进行视频和图片的CDN清理
            if (change_video) {
                coding = VideoStatus.video_deal_again1;
            }
            if (DeveloperUtils.isTesting(userid)) {
                waitStatus = VideoStatus.beta_trans_waite;
            }
            
            if (StringUtil.isFine(out_br)) {
                String[] brs = out_br.split(",");
                for (int i = 1; i < brs.length + 1; i++) {
                    // TODO GPU 一直没有开10x、流畅的编码线程，这个处理貌似可以去掉？
                    String field1_status = field1_videolog;
                    //two pass用户，流畅码率质量无法达到要求，暂时不用gpu来处理
                    if(isTwoPass && i==1) {
                        field1_status = "";
                    }
                    videoLogSevice.insertLog(video_hash, i, userid, ext.get("resolution"),
                            EmojiParser.removeAllEmojis(title), videoLogExt, ext.get("first_image"),
                            ext.get("swf_link" + i), "0", "0", ptime, ptime, my_br, coding,
                            waitStatus, ext.get("isVip"), field1_status,"",VideoLog.TABLENAME_VALUE);
                    
                    if ("Y".equals(ext.get("15x"))) {
                        videoLogSevice.insertLog(video_hash, i, userid, ext.get("resolution"),
                                EmojiParser.removeAllEmojis(title), videoLogExt, ext.get("first_image"),
                                ext.get("swf_link" + i), "0", "0", ptime, ptime, my_br, coding,
                                waitStatus, ext.get("isVip"), field1_status,"",VideoLog.TABLENAME_15X_VALUE);
                    }
                    
                    if ("Y".equals(ext.get("20x"))) {
                        videoLogSevice.insertLog(video_hash, i, userid, ext.get("resolution"), EmojiParser.removeAllEmojis(title),
                                videoLogExt,ext.get("first_image"), ext.get("swf_link" + i), "0", "0", ptime, ptime, my_br, coding,
                                waitStatus, ext.get("isVip"), field1_status,"",VideoLog.TABLENAME_20X_VALUE);
                    }
                    
                    if ("Y".equals(ext.get("125x"))) {
                        videoLogSevice.insertLog(video_hash, i, userid, ext.get("resolution"), EmojiParser.removeAllEmojis(title),
                                videoLogExt,ext.get("first_image"), ext.get("swf_link" + i), "0", "0", ptime, ptime, my_br, coding,
                                waitStatus, ext.get("isVip"), field1_status,"",VideoLog.TABLENAME_125X_VALUE);
                    }
                    
                }
                
                // 如果最高清晰度的编码，可复用视频编码，则放入优先编码队列中
                encodeTaskService.addToQuickEncodeQueueOnNeed(video_hash, brs.length, watermark, ext, playext,
                        upload_fileext);
            }
        }
        
        return 0;
    }
    
    private boolean publishKeepSourceNow(String userid) throws Exception {
        boolean publishNow = false;
        CcUser ccuser = ccUserService.getByUserId(userid);
        if ("2".equals(ccuser.getGrade())) {
            // 用户是否已经有免审权限
            publishNow = true;
        } else {
            // 检查是否有源文件免审的权限
            List<DOC> cist = ccuserjoinitemService.getpByUserid(userid);
            if (cist.size() > 0) {
                for (DOC doc : cist) {
                    if (Long.valueOf(doc.geto("id").toString()) == 45) {
                        publishNow = true;
                        break;
                    }
                }
            }
        }
        return publishNow;
    }
    
    private void updateUserSpace(String userid) {
        DBHelper_db db = new DBHelper_db();
        long usedSpace = db.sumAllVideoSize(userid);
        db.updateUserUsedSpace(userid, usedSpace);
        
    }
    
    private void setCata(long cataid, String hostid, String video_hash) {
        if (cataid > 0) {
            Cata_db cdb = new Cata_db(hostid);
            DOC pcata = cdb.getOne(cataid);
            LogicUtil.changeCata(hostid, video_hash, cataid, pcata);
            
        }
    }
    
    /**
     * 无源文件合并模式自带信息方法
     * @param playext 用户编码配置
     */
    public DOC getVideoInfo(DOC playext, String source_file, final String video_pool_id, final long cataid,
            final String hostid, final String filename, final String upload_fileext, final String userid,
            final long fileSize, boolean iskeepsource) throws Exception {
        
        DOC ext = new DOC();
        return getVideoInfo(playext, ext, source_file, video_pool_id, cataid, hostid, filename, upload_fileext, userid,
                fileSize, iskeepsource);
    }
    
    public DOC getVideoInfo(DOC playext, DOC ext, String source_file, final String video_pool_id, final long cataid,
            final String hostid, final String filename, final String upload_fileext, final String userid,
            final long fileSize, boolean iskeepsource) throws Exception {
        
        logger.info("video_pool_id:" + video_pool_id);
        
        boolean concatMode = ext.geti("concatMode") == 1;
        
        String target_fileext = ".flv";
        
        ext.put("video_pool_id", video_pool_id);
        
        String original_duration = "";
        String original_fps = "";
        String original_tot_fr = "";
        String original_encoding = "";
        String original_definition = ""; // 源视频分辨率，例如 1920x1080
        
        String original_audioft = "";
        String original_ar = "";
        String original_ac = "";
        
        int width = 0, height = 0, original_br = 0, original_ab = 0, int_rotate = 0;
        double start_time = 0;
        String rotate = "";
        String display_aspect_ratio = "";
        
        String original_pix_fmt = "";
        String original_profile = "";
        String original_audio_profile = "";
        String original_audio_duration = "";
        
        // 视频合并模式从外部传递参数
        if (concatMode) {
            original_duration = ext.get("original_duration");// 原视频时长
            original_definition = ext.get("original_definition");// 原视频分辨率
            original_fps = ext.get("original_fps");// 原视频帧率
            original_tot_fr = ext.get("original_tot_fr");// 原视频总帧数
            original_encoding = ext.get("original_encoding");// 原视频编码
            original_br = ext.geti("original_br");// 原视频码率
            width = ext.geti("width");
            height = ext.geti("height");
            start_time = ext.getd("start_time");
            original_ab = ext.geti("original_ab");
            logger.info("bitrate : " + ext.get("original_br"));
            original_audioft = ext.get("original_audioft");
            original_ar = ext.get("original_ar");
            original_ac = ext.get("original_ac");
            
            int_rotate = ext.geti("rotate");
            rotate = ext.get("rotate");
        } else {
            if (!FileUtil.exists(source_file)) {
                logger.info(">>>从hdfs下载文件>>>>>>>>" + source_file);
                UploadService.getVideo(source_file);
            }
            if (FileUtil.getFileSize(source_file) == 0) {
                return null;
            }
            
            DOC video_info = LogicUtil.analysisVideoByJsonFormat(source_file);
            original_duration = video_info.get("original_duration");// 原视频时长
            original_definition = video_info.get("original_definition");// 原视频分辨率
            original_fps = video_info.get("original_fps");// 原视频帧率
            original_tot_fr = video_info.get("original_tot_fr");// 原视频总帧数
            original_encoding = video_info.get("original_encoding");// 原视频编码
            original_br = video_info.geti("original_br");// 原视频码率
            width = video_info.geti("width");
            height = video_info.geti("height");
            start_time = video_info.getd("start_time");
            original_ab = video_info.geti("original_ab");
            logger.info("bitrate : " + video_info.get("original_br"));
            original_audioft = video_info.get("original_audioft");
            original_ar = video_info.get("original_ar");
            original_ac = video_info.get("original_ac");
            
            int_rotate = video_info.geti("rotate");
            rotate = video_info.get("rotate");
            display_aspect_ratio = video_info.get("display_aspect_ratio");
            
            original_pix_fmt = video_info.get("original_pix_fmt");
            original_profile = video_info.get("original_profile");
            original_audio_profile = video_info.get("original_audio_profile");
            original_audio_duration = video_info.get("original_audio_duration");
            
            
        }
        
        boolean isAudio = false;
        if (start_time < 0 && !StringUtils.equalsIgnoreCase(upload_fileext, ".m3u8")) {
            // ffmpeg64bit_centos -i SFILE.mp4 -itsoffset -54.373000 -i SFILE.mp4 -map 0:0 -map 1:1 -vcodec libx264 -acodec libfaac
            // SFILE.flv
            String mp4tempfile = "/tmp/formp4_" + video_pool_id + upload_fileext;
            String ffmpegstring = "/data/ffmpeg.3.0.2/bin/ffmpeg3 -i " + source_file + " -itsoffset " + start_time
                    + " -i " + source_file + " -map 0:0 -map 1:1 -vcodec copy -acodec copy -y " + mp4tempfile;
            
            System.out.println("copy in getVideoInfo:" + ffmpegstring);
            Command.run2(ffmpegstring, System.out);
            source_file = mp4tempfile;
            ext.put("new_source_file", source_file);
        }
        // 修正音频判断
        if (!StringUtil.isFine(original_definition) && original_ab>0) {
            original_definition = "640x362";
            width = 240;
            height = 240;
            original_encoding = "mjpeg";
            original_fps = "25";
            original_tot_fr = "1000";// 无总帧数
            original_br = original_ab;
            isAudio = true;
            
        }
        // 无法拿到正确分辨率的情况
        if ("0x0".equals(original_definition)) {
            original_definition = "1280x720";
        }
        // 设置用户最大码率个数
        
        Cata_db cdb = new Cata_db(hostid);
        DOC cata = cdb.getOne(cataid);
        if (cata != null) {
            CataProfile cataProfile = cataProfileService.getCataProfileByCatatree(cata.get("catatree"));
            if (cataProfile != null && "Y".equals(cataProfile.getStatus())) {
                String settingExt = cataProfile.getExt();
                DOC cataPlayext = com.cc.ovp.util.Ext.parseJson(settingExt);
                String[] keys = cataPlayext.getKeys();
                
                for (int i = 0; keys != null && i < keys.length; i++) {
                    Object o = cataPlayext.geto(keys[i]);
                    if (o != null) {
                        String value = (String)cataPlayext.geto(keys[i]);
                        //避免空字符串替换正常配置(bw)
                        if(StringUtil.isFine(value)) {
                            logger.info("updateCataExt:" + keys[i] + "=" + value);
                            playext.put(keys[i], o);
                            
                        }
                    }
                    
                }
                
                // hlsLevel 不存在于 用户设置，只存在于类别设置
                ext.put("hlsLevel", cataPlayext.get("hlsLevel"));
                ext.put("playerid", cataProfile.getPlayerid() == null ? "" : cataProfile.getPlayerid());
                ext.put("previewDuration", cataPlayext.get("previewDuration"));
                ext.put("luping", StringUtil.isFine(cataPlayext.get("isEdu")) && "1".equals(cataPlayext.get("isEdu"))
                        ? "1" : "0");
                
                // 源文件转HLS，分类设置
                ext.put("convertHls", cataPlayext.get("convertHls"));
                logger.info("updateCataExt:convertHls=" + cataPlayext.get("convertHls"));
            }
        }
        
        // 账户设置播放原文件的情况
        ext.put("keepsource", playext.get("keepsource"));
        // 播放原文件，转封装到mp4
        ext.put("keepsource_mp4", playext.get("keepsource_mp4"));
        ext.put("templateId", "0");
        // 设置mp3类型为直接输出播放的情况
        if (isAudio && playext.geti("mp3keepsource") == 1) {
            ext.put("keepsource", "1");
        }
        boolean keepsource = "1".equals(ext.get("keepsource"));
        //
        logger.info("keepsource:" + playext.get("keepsource") + "/mp3keepsource:" + playext.get("mp3keepsource"));
        logger.info("keepsource:" + ext.get("keepsource"));
        
        int maxBr = playext.geti("maxBr", 3);
        
        // 源文件转HLS，只有1个源码率
        boolean isConvertHls = "1".equals(ext.get("convertHls"));
        // iskeepsource 通过接口参数传递，保留keepsource,keepsource为账户配置，分类配置
        if (keepsource || iskeepsource || isConvertHls) {
            maxBr = 1;
        }
        // 进入vip编码队列
        ext.put("isVip", playext.get("isVip"));
        // 有倍速码率
        ext.put("125x", playext.get("125x"));
        ext.put("15x", playext.get("15x"));
        ext.put("20x", playext.get("20x"));
        // 单个视频移动端加密
        
        ArrayList<BW> taskList = EncodeTask_logic.getTask(original_br);
        String encodingLadder = "bw";
        
        //crf 编码方式，质量恒定，按分辨率分开编码任务
        if (playext.geti("crf") == 1) {
            taskList = EncodeTask_logic.getCrfTask(width);
            encodingLadder = "crf_bw";
            logger.info("crf_bw" + playext.get(encodingLadder));
            
            if (StringUtil.isFine(playext.get(encodingLadder))) {
                try {
                    net.sf.json.JSONArray bw_json = net.sf.json.JSONArray.fromObject(playext.get(encodingLadder));
                    ArrayList<BW> taskList_customer = new ArrayList<BW>();
                    boolean isBWSettingFine = true;
                    for (int i = 1; i <= bw_json.size(); i++) {
                        DOC oneBW = com.cc.ovp.util.Ext.parseJson(bw_json.get(i - 1).toString());
                        
                        BW bw_customer = new BW(oneBW.geti("width"), oneBW.geti("maxrate"), oneBW.geti("crf"), i);
                        if (bw_customer.crf <= 0 || bw_customer.width <= 0) {
                            isBWSettingFine = false;
                            logger.info("bw setting wrong:" + userid);
                            break;
                        }
                        taskList_customer.add(bw_customer);
                        
                    }
                    if (isBWSettingFine) {
                        //test task for 4
                        if(bw_json.size() == 4) {
                            taskList = EncodeTask_logic.getCrfTask(width, taskList_customer.get(0), taskList_customer.get(1),
                                    taskList_customer.get(2),taskList_customer.get(3));
                            maxBr = 4; //默认为3，此处需要设置为4
                        }else {
                            taskList = EncodeTask_logic.getCrfTask(width, taskList_customer.get(0), taskList_customer.get(1),
                                    taskList_customer.get(2));
                            
                        }
                        
                        for (int i = 0; i < taskList.size(); i++) {
                            logger.info(video_pool_id + " task:" + taskList.get(i));
                            
                        }
                        
                    }
                } catch (Exception e) {
                    logger.error(e.getMessage(), e);
                }
            }
        }else {
            logger.info("bw:" + playext.get(encodingLadder));
            
            if (StringUtil.isFine(playext.get(encodingLadder))) {
                try {
                    net.sf.json.JSONArray bw_json = net.sf.json.JSONArray.fromObject(playext.get(encodingLadder));
                    ArrayList<BW> taskList_customer = new ArrayList<BW>();
                    boolean isBWSettingFine = true;
                    for (int i = 1; i <= bw_json.size(); i++) {
                        DOC oneBW = com.cc.ovp.util.Ext.parseJson(bw_json.get(i - 1).toString());
                        
                        BW bw_customer = new BW(oneBW.geti("width"), oneBW.geti("bitrate"), i);
                        if (bw_customer.bitrate <= 0 || bw_customer.width <= 0) {
                            isBWSettingFine = false;
                            logger.info("bw setting wrong:" + userid);
                            break;
                        }
                        taskList_customer.add(bw_customer);
                        
                    }
                    if (isBWSettingFine) {
                        //test task for 4
                        if(bw_json.size() == 4) {
                            taskList = EncodeTask_logic.getTask(original_br, taskList_customer.get(0), taskList_customer.get(1),
                                    taskList_customer.get(2),taskList_customer.get(3));
                            maxBr = 4; //默认为3，此处需要设置为4
                        }else {
                            taskList = EncodeTask_logic.getTask(original_br, taskList_customer.get(0), taskList_customer.get(1),
                                    taskList_customer.get(2));
                            
                        }
                        
                        for (int i = 0; i < taskList.size(); i++) {
                            logger.info(video_pool_id + " task:" + taskList.get(i));
                            
                        }
                        
                    }
                } catch (Exception e) {
                    logger.error(e.getMessage(), e);
                }
            }
        }

            
        
        
        
        // 根据码率和分辨率计算要压缩的视频的码率及分辨率
        Map<String, Object> cal_video = LogicUtil.cal_video(taskList, original_definition, maxBr);
        String out_br = (String) cal_video.get("out_br");
        String resolution = (String) cal_video.get("resolution");
        logger.info("original_duration:" + original_duration);
        // 计算秒数
        String[] duration_times = original_duration.split("\\:");
        
        int hour = 0, minute = 0;
        double second = 0;
        
        try {
            hour = IntUtil.s2i(duration_times[0]);
            minute = IntUtil.s2i(duration_times[1]);
            second = IntUtil.s2d(duration_times[2]);
        } catch (Exception e) {
        
        }
        
        double sum_seconds = hour * 3600 + minute * 60 + second;
        
        logger.info("sum_seconds:" + sum_seconds);
        
        if (!StringUtil.isFine(original_definition)) {
            
            return null;
        }
        ext.put("source_filesize", "" + fileSize);
        ext.put("original_definition", original_definition);
        ext.put("original_br", original_br + "");
        ext.put("original_fps", original_fps);
        ext.put("original_tot_fr", original_tot_fr);
        ext.put("original_encoding", original_encoding);
        ext.put("isAudio", isAudio ? "1" : "0");
        ext.put("original_audioft", original_audioft);
        ;// 原视频声音格式mp3,wmav2等
        ext.put("original_ar", original_ar);// 原视频声音频率-ar
        ext.put("original_ac", original_ac);// 原视频声音频道数-ac
        ext.put("original_ab", "" + original_ab);// 原视频声音声速-ab
        
        ext.put("rotate", rotate);
        
        ext.put("display_aspect_ratio", display_aspect_ratio);// DAR
        
        ext.put("duration", original_duration);
        ext.put("out_br", out_br);// 码率
        ext.put("resolution", resolution);// 分辨率
        ext.put("playtime", "" + sum_seconds);
        
        ext.put("original_pix_fmt", original_pix_fmt);
        ext.put("original_audio_duration", original_audio_duration);
        ext.put("original_audio_profile", original_audio_profile);
        ext.put("original_profile", original_profile);
        // 用户播放设置
        
        logger.info(":::ext--::::original_br::::::::::::::::" + ext.geti("original_br"));
        
        int playerwidth = 0;
        int playerheight = 0;
        int autoplay = 0;
        int my_br = 2;// 首选码率等级
        int max_br = 1;// 最大码率等级
        logger.info("get info---");
        if (taskList != null) {
            for (int i = 0; i < taskList.size(); i++) {
                logger.info("level_status_" + (i + 1));
                
                if (!StringUtil.isFine("level_status_" + (i + 1))) {
                    ext.put("level_status_" + (i + 1), "-1");
                }
                
                BW bw = taskList.get(i);
                if (i == 0) {
                    my_br = bw.level;
                }
                if (i == taskList.size() - 1) {
                    max_br = bw.level;
                }
            }
        }
        
        // 用户配置的默认播放器宽,高
        System.out.println("adownload:" + playext.geti("adownload", 0));
        
        // 要视频下载后不可用,只能转为flv格式,打乱视频文件
        if (playext.geti("adownload", 0) == 1 && !keepsource) {
            target_fileext = ".flv";
            ext.put("seed", 1);// 是否加密1 加密
            ext.put("seed_const", LogicUtil.randomSeed());// 加密常量
        }
        
        playerwidth = playext.geti("width", playerwidth);
        playerheight = playext.geti("height", playerheight);
        autoplay = playext.geti("autoplay", autoplay);// 自动播放
        // 如果用户首选用高清播放，但上传的视频又没有高清码率，选择次码率
        if (max_br <= playext.geti("definition", my_br)) {
            my_br = max_br;
        } else {
            my_br = playext.geti("definition", my_br);
        }
        ext.put("autoplay", autoplay);// 自动播放
        ext.put("playerwidth", playerwidth);// 宽（设置）
        ext.put("playerheight", playerheight);// 高（设置）
        ext.put("my_br", my_br + "");// 默认播放码率
        ext.put("default_videolink", ext.get("swf_link" + my_br));
        
        ext.put("source_file", filename + upload_fileext);

        // 针对特定用户，配置编码直接输出MP4
        logger.info("userid:" + userid);
        if(encodeTaskService.isEncodeMp4User(userid)) {
            logger.info("target_fileext:.mp4");
            ext.put("target_fileext", ".mp4");//改为mp4
        }else {
            ext.put("target_fileext", target_fileext);// 转码后文件后缀
        }
        
        // swf_link0，给移动终端的mp4
        System.out.println("make link:" + taskList.size());
        for (int i = 1; i <= taskList.size(); i++) {
            ext.put("mp4_link" + i, filename + "_" + i + ".mp4");
            ext.put("swf_link" + i, filename + "_" + i + target_fileext);
            
        }
        
        boolean isRotated = int_rotate > 0;
        // 如果旋转了，显示比例会要旋转
        if (!keepsource && (int_rotate == 270 || int_rotate == 90)) {
            logger.info(video_pool_id + "roated,switch DAR.." + int_rotate);
            try {
                String[] pair = display_aspect_ratio.split(":");
                String dar = pair[1] + ":" + pair[0];
                ext.put("display_aspect_ratio", dar);
                
            } catch (Exception e) {
            
            }
        }
        // 截图=======================截图需要duration和source_file===========================
        
        // 800M以内的文件直接截图,mpg,wmv截图会有问题
        if (!isRotated && !isAudio && fileSize < 2000 * 1024 * 1024 && source_file.toLowerCase().indexOf(".mpg") == -1
                && source_file.toLowerCase().indexOf(".wmv") == -1 && source_file.toLowerCase().indexOf(".dat") == -1
                && source_file.toLowerCase().indexOf("vob") == -1 && source_file.toLowerCase().indexOf(".rmvb") == -1
                && source_file.toLowerCase().indexOf(".mp3") == -1) {
            if ("Y".equals(playext.get("isVip"))) {
                LogicUtil.cutImage(ext, hostid, cover_images_count, source_file, width, height);
            } else {
                String imgfilename = ext.get("source_file").split("\\.")[0];
                
                ArrayList<String> video_images = new ArrayList<String>();
                ArrayList<String> video_images_b = new ArrayList<String>();
                for (int i = 0; i < cover_images_count; i++) {
                    String video_imagelink = imgfilename + "_" + i + ".jpg";
                    String video_imagelink_b = imgfilename + "_" + i + "_b.jpg";
                    video_images.add(video_imagelink);
                    video_images_b.add(video_imagelink_b);
                }
                ext.put("images", video_images);
                ext.put("images_b", video_images_b);
                ext.put("first_image", video_images.get(0));
                ext.put("first_image_b", video_images_b.get(0));
            }
            
        } else if (!StringUtil.isFine(original_definition)) {
            ArrayList<String> video_images = new ArrayList<String>();
            ArrayList<String> video_images_b = new ArrayList<String>();
            for (int i = 0; i < cover_images_count; i++) {
                video_images.add("http://static.polyv.net/img/audio.jpg");
                video_images_b.add("http://static.polyv.net/img/audio.jpg");
            }
            ext.put("images", video_images);
            ext.put("images_b", video_images_b);
            ext.put("first_image", video_images.get(0));
            ext.put("first_image_b", video_images_b.get(0));
            
        } else {
            String imgfilename = ext.get("source_file").split("\\.")[0];
            
            ArrayList<String> video_images = new ArrayList<String>();
            ArrayList<String> video_images_b = new ArrayList<String>();
            for (int i = 0; i < cover_images_count; i++) {
                String video_imagelink = imgfilename + "_" + i + ".jpg";
                String video_imagelink_b = imgfilename + "_" + i + "_b.jpg";
                video_images.add(video_imagelink);
                video_images_b.add(video_imagelink_b);
            }
            ext.put("images", video_images);
            ext.put("images_b", video_images_b);
            ext.put("first_image", video_images.get(0));
            ext.put("first_image_b", video_images_b.get(0));
        }
        
        if (keepsource) {
            ext.put("first_image", "http://static.polyv.net/file/images/default.jpg");
            ext.put("first_image_b", "http://static.polyv.net/file/images/default_b.jpg");
        }
        
        return ext;
    }
    
    public String parseUrl(String type, String hostid, String url) {
        if (url.startsWith("http://")) {
            return url;
        } else {
            return "/u" + type + "/" + hostid + "/" + url;
        }
    }
    
    public void insert(ParamUtil pu, String hostid, String userid) throws Exception {
        Video_db vdb = new Video_db(hostid);
        long videoid = ServerUtil.getLongID();
        String title = pu.getString("title");
        String tag = pu.getString("tag");
        String describ = pu.getSourceString("describ");
        if (!StringUtil.isFine(title)) {
            throw new IllegalStateException("没有填写标题");
        }
        String hash = EncryptUtil.getMD5(title);
        // 作者 来源 来源链接 模板 视频
        DOC extdoc = new DOC();
        // 首播视频vid
        extdoc.put("fristPlay", pu.getString("fristPlay", ""));
        extdoc.put("author", pu.getString("author", ""));
        extdoc.put("source", pu.getString("source", ""));
        extdoc.put("sourcelink", pu.getString("sourcelink"));
        extdoc.put("templateid", pu.getString("templateid", ""));
        extdoc.put("userid", pu.getString("userid", "admin"));
        extdoc.put("lmodify_userid", pu.getString("lmodify_userid"));
        extdoc.put("thumbnail", pu.getString("thumbnail"));
        String videolist = pu.getSourceString("videolist");
        logger.info(videolist);
        JSONArray ja = new JSONArray(videolist);
        int video_count = ja != null ? ja.length() : 0;
        if (video_count == 0) {
            throw new IllegalStateException("没有选择视频");
        }
        for (int i = 0; ja != null && i < ja.length(); i++) {
            JSONObject jo = (JSONObject) ja.get(i);
            String video_pool_id = jo.getString("vpid");
            Video_pool_db vpdb = new Video_pool_db(hostid);
            DOC vpdoc = vpdb.getOne(video_pool_id);
            if (vpdoc != null) {
                jo.put("vp", Ext.parseJson(vpdoc.get("ext")));
            } else {
                ja.remove(i);
            }
        }
        video_count = ja.length();
        extdoc.put("videolist", ja.toString());
        String ext = Ext.setJson(extdoc);
        long ptime = System.currentTimeMillis();
        long lmodify = ptime;
        if (!vdb.insert(videoid, userid, title, tag, describ, hash, video_count, ext, ptime, lmodify,
                Constants.nodel)) {
            throw new IllegalStateException("insert failed");
        }
    }
    
    public void update(ParamUtil pu, String hostid, String userid) throws Exception {
        Video_db vdb = new Video_db(hostid);
        long videoid = pu.getLong("videoid");
        String title = pu.getString("title");
        String tag = pu.getString("tag");
        String describ = pu.getSourceString("describ");
        if (!StringUtil.isFine(title)) {
            throw new IllegalStateException("没有填写标题");
        }
        String hash = EncryptUtil.getMD5(title);
        if (vdb.getOneByHash(hash, videoid) != null) {
            throw new IllegalStateException("视频标题重复");
        }
        // 作者 来源 来源链接 模板 视频
        DOC extdoc = new DOC();
        // 首播视频vid
        extdoc.put("fristPlay", pu.getString("fristPlay", ""));
        extdoc.put("author", pu.getString("author"));
        extdoc.put("source", pu.getString("source"));
        extdoc.put("sourcelink", pu.getString("sourcelink"));
        extdoc.put("templateid", pu.getString("templateid"));
        extdoc.put("userid", pu.getString("userid"));
        extdoc.put("lmodify_userid", pu.getString("lmodify_userid"));
        extdoc.put("thumbnail", pu.getString("thumbnail"));
        String videolist = pu.getSourceString("videolist");
        JSONArray ja = new JSONArray(videolist);
        int video_count = ja != null ? ja.length() : 0;
        if (video_count == 0) {
            throw new IllegalStateException("没有选择视频");
        }
        // 根据前台传递进来的vid取得视频次视频的信息
        for (int i = 0; ja != null && i < ja.length(); i++) {
            JSONObject jo = (JSONObject) ja.get(i);
            if (jo != null) {
                String video_pool_id = jo.getString("vpid");
                Video_pool_db vpdb = new Video_pool_db(hostid);
                DOC vpdoc = vpdb.getOne(video_pool_id);
                DOC vpext = JsonUtil.strToDOC(vpdoc.get("ext"));
                vpext.put("publish_url", vpdoc.get("publish_url"));
                if (vpdoc != null) {
                    jo.put("vp", vpext);
                } else {
                    ja.remove(i);
                }
            }
        }
        extdoc.put("videolist", ja.toString());
        String ext = Ext.setJson(extdoc);
        long lmodify = System.currentTimeMillis();
        
        vdb.update(videoid, "title", title);
        vdb.update(videoid, "tag", tag);
        vdb.update(videoid, "describ", describ);
        vdb.update(videoid, "hash", hash);
        vdb.update(videoid, "video_count", "" + video_count);
        vdb.update(videoid, "ext", ext);
        vdb.update(videoid, "lmodify", "" + lmodify);
        IPUtil.delCacheFile(LogicUtil.parsePlaylistXmlPath(hostid, videoid));
    }
    
    /**
     * 修改ext,及数据表字段都可以使用的方法，因为修改title，tag,describ等字段非企业用户的视频需返回审核
     */
    public void update_video_pool(ParamUtil pu, String hostid, String userid) throws Exception {
        Video_pool_db vpdb = new Video_pool_db(hostid);
        DOC video_pool = vpdb.getOne(pu.getString("video_pool_id"));
        DOC ext = LogicUtil.changeExt(pu, video_pool);
        long ptime = video_pool.getl("ptime");
        long lmodify = ptime;
        String video_pool_id = video_pool.get("video_pool_id");
        vpdb.rinsert(video_pool_id, video_pool.getl("cataid"), video_pool.get("catatree"), userid,
                pu.getSourceString("title"), pu.getSourceString("describ"), pu.getString("publish_url", ""),
                Ext.setJson(ext), pu.getSourceString("tag"), userid, lmodify, ptime, video_pool.geti("times"),
                video_pool.geti("digg"), video_pool.geti("status"), "", "", video_pool.geti("ordertime"),
                video_pool.getl("size"));
        LogicUtil.cleanVXML(video_pool_id);
        yanzheng(video_pool.get("video_pool_id"), hostid, userid);
    }
    
    /**
     * 修改ext,及数据表字段都可以使用的方法，因为修改title，tag,describ等字段非企业用户的视频需返回审核
     */
    public void update_video_poolforMap(Map<String, Object> map, String hostid, String userid) throws Exception {
        if (!map.isEmpty()) {
            Video_logic videoLogic = new Video_logic();
            String video_pool_id = map.get("video_pool_id").toString();
            map.remove("video_pool_id");
            videoLogic.update_video_pool(map, hostid, userid, video_pool_id);
            yanzheng(video_pool_id, hostid, userid);
        }
        
    }
    
    public boolean yanzheng(String video_pool_id, String hostid, String userid) {
        try {
            Video_pool_db vpdb = new Video_pool_db(hostid);
            DOC video_pool = vpdb.getOne(video_pool_id);
            
            // replace到审核表video_pool_all
            vpdb.insertToBak(video_pool_id, "all");
            mongoSearchService.insertFromVideo(video_pool_id, hostid);
            // 获取用户权限
            String ugrade = "";
            ugrade = customerService.getByUserId(userid).getGrade();
            // 普通用户修改后需重新审核文字
            if (ugrade.equals(Permiss.PERSION + "")) {
                // 如果该记录已经审核过了，则把审核表的状态改为重新审核（只审核文字，不审核视频）
                if (video_pool.geti("status") != VideoStatus.video_appr_waite) {
                    Video_pool_db vpdb_all = new Video_pool_db("all");
                    vpdb_all.update(video_pool_id, "status", VideoStatus.video_re_appr + "");// 把状态置为重新审核文字
                }
            }
            return true;
        } catch (Exception e) {
            return false;
            // TODO: handle exception
        }
    }
    
    /**
     * 修改ext,及数据表字段都可以使用的方法，因为修改title，tag,describ等字段非企业用户的视频需返回审核
     */
    public void update_video_pool(Map map2, String hostid, String userid, String vid) throws Exception {
        String video_pool_id = vid;
        Video_pool_db vpdb = new Video_pool_db(hostid);
        vpdb.update(map2, "video_pool_id", video_pool_id);
        LogicUtil.cleanVXML(video_pool_id);
    }
    
    /**
     * 只修改ext字段使用
     */
    public void update_video_save_ext(ParamUtil pu, String hostid, String userid) throws Exception {
        String video_pool_id = pu.getString("video_pool_id");
        Video_pool_db vpdb = new Video_pool_db(hostid);
        LinkedHashMap<String, Object> map = new LinkedHashMap<String, Object>();
        map.put("playerid", pu.getString("playerId"));// 用户选择的播放器
        map.put("playername", pu.getString("playername"));
        vpdb.updateExt(video_pool_id, map);
        LogicUtil.cleanVXML(video_pool_id);
    }
    
    //// 只修改ext字段使用（备用方法）
    public void update_video_ext(ParamUtil pu, String hostid, String userid) throws Exception {
        String video_pool_id = pu.getString("video_pool_id");
        Video_pool_db vpdb = new Video_pool_db(hostid);
        vpdb.updateExt(video_pool_id, "qid", pu.getString("qid"));
        LogicUtil.cleanVXML(video_pool_id);
    }
    
    public void copy(ParamUtil pu, JspWriter out, String hostid, String userid) throws Exception {
        String title = pu.getString("title");
        String thumbnail = pu.getString("thumbnail");
        String description = pu.getString("description");
        String vpid = pu.getString("vpid");
        boolean cut = pu.getBoolean("cut");
        
        JSONObject json = new JSONObject();
        json.put("title", title);
        json.put("thumbnail", thumbnail);
        json.put("description", description);
        json.put("vpid", vpid);
        String ext = json.toString();
        
        Clipboard_db cdb = new Clipboard_db(hostid);
        cdb.rinsert(userid, "copy_video_pool", vpid, ServerUtil.getLongID(), ext);
    }
    
    public String getPasteData(ParamUtil pu, JspWriter out, String hostid, String userid) {
        Clipboard_db cdb = new Clipboard_db(hostid);
        DOC[] docs = cdb.getDataByUseridAndType(userid, "copy_video_pool");
        ArrayList list = new ArrayList();
        for (int i = 0; docs != null && i < docs.length; i++) {
            list.add(Ext.parseJson(docs[i].get("ext")));
        }
        cdb.deleteByUseridAndType(userid, "copy_video_pool");
        return Ext.setJson(list);
    }
    
    /**
     * TODO 应将处理结果返回，以便调用方判断，处理是否成功。
     * <br/>
     * 将该视频、该码率的编码任务，重设为待编码
     * @param filetype 1, 1.25, 1.5, 2.0
     */
    public void doMqAgainByByLevel(String userid, String video_pool_id, String hostid, int level, String filetype) {
        boolean speedMode = filetype.equals("1.5") || filetype.equals("2.0") || filetype.equals("1.25");
        
        Video_pool_db vpdb = new Video_pool_db(hostid);
        DOC video_pool = vpdb.getOne(video_pool_id);
        if (video_pool.geti("status") == VideoStatus.video_trans_ing) {
            logger.info("视频已经在处理");
        }
        if ("1".equals(video_pool.get("keepsource"))) {
            return;
        }
        try {
            progressService.deleteProgress(video_pool_id);
        } catch (Exception e) {
            // ignore
        }
        
        // TODO 为什么会出现源文件不存在的情况？
        // 如果源文件不存在，则不操作
        AliOssBucket customSrcBucket = AliOssBucket.getInstance(specialCDNConfig.getSrcBucket(userid));
        AliOssBucket srcBucket = customSrcBucket != null ? customSrcBucket : AliOssBucket.VOD_VIDEO_SRC;
        StorageType storageType = storageTypeService.getStorageTypeDownload(video_pool.get("storage_type"));
        if (StorageType.OSS.equals(storageType)) {
            // 这里进处理 keepsource=0 的情况即可
            String sourceFile = video_pool.get("source_file");
            String dfsNameSrc = LogicUtil.getSourceFilePath(sourceFile, hostid);
            String httpPath = dfsNameSrc.substring(dfsNameSrc.indexOf("video_source/"));
            if (!aliOssService.opsForAccess().exists(srcBucket, httpPath)) {
                logger.warn("source file not exists on OSS, videoPoolId=" + video_pool_id);
                return;
            }
        } else {
            DBHelper_db db = new DBHelper_db();
            DOC doc = db.getDFSSourcefileName(video_pool_id);
            DFSClient client = new DFSClient();
            if (doc == null || !client.isExists(doc.get("groupName"), doc.get("dst"))) {
                // TODO 临时处理，如果DFS文件不存在，再尝试OSS文件
                //      可参考 http://pm.igeeker.org/browse/LIVE-20733
                logger.info("source file not exists on DFS, try OSS.");
                String sourceFile = video_pool.get("source_file");
                String dfsNameSrc = LogicUtil.getSourceFilePath(sourceFile, hostid);
                String httpPath = dfsNameSrc.substring(dfsNameSrc.indexOf("video_source/"));
                if (!aliOssService.opsForAccess().exists(srcBucket, httpPath)) {
                    logger.warn("source file not exists on DFS, videoPoolId=" + video_pool_id);
                    return;
                }
            }
        }
        
        try {
            // 设置重新转码标志coding,从VideoStatus可以判断是重新转码(coding=25,26),还是第一次转码(coding=20),非常重要
            int coding = VideoStatus.video_trans_ing;
            if (video_pool.geti("status") == VideoStatus.video_publish_ok) {
                coding = VideoStatus.video_deal_again1;
            } else {
                coding = VideoStatus.video_deal_again0;
            }
            // 因video_log会定时清除老数据,需查一下是否有
            VideoLog videoLog = videoLogSevice.getVideoLog(video_pool_id, level, filetype);
            long startTime = System.currentTimeMillis();
            long ptime = System.currentTimeMillis();
            if (videoLog == null) {
                videoLogSevice.insertLog(video_pool_id, level, userid, video_pool.get("resolution"),
                        video_pool.get("title"), "0", video_pool.get("first_image"), video_pool.get("swf_link" + level),
                        "0", "0", startTime, ptime, video_pool.get("my_br"), coding, VideoStatus.video_trans_waite, "N","","",
                        VideoLog.TABLENAME_VALUE);
            } else {
                videoLogSevice.setStatusAndCoding(userid, video_pool_id, VideoStatus.video_trans_waite, coding, 0,
                        level, ptime, filetype);
            }
            if (!speedMode) {
                // 普通模式下将百分比置0
                videoLogSevice.setPercent(userid, video_pool_id, 0, level, VideoLog.TABLENAME_VALUE);
                // 清理缓存
                if (video_pool.geti("seed") == 0) {
                    String relativePath = video_pool.get("mp4_link" + level);
                    String sourcePath = "http://vback.polyv.net/mp4/" + relativePath;
                    LogicUtil.cleanWangSuByUrl(sourcePath);
                } else {
                    String groupName = video_pool.get("level_group_" + level);
                    CcUser ccUser = customerService.getByUserId(userid);
                    String surl = LogicUtil.getCdnUrl(ccUser.getSegurl(), groupName);
                    
                    String seg_link = "http://" + surl + "/pdx/" + video_pool.get("swf_link" + level).split("_")[0]
                            + "_" + level + ".pdx";
                    LogicUtil.cleanWangSuByUrl(seg_link);
                }
                
                videoLogSevice.cleanErrorInfo(userid, video_pool_id, level);
            }
            
        } catch (Exception e) {
            logger.error("exception: at com.cc.ovp.logic.Video_logic method=upload #cached#", e);
        }
        
        // 更新为视频表等待状态
        if (1 == level && !speedMode) {
            vpdb.update(video_pool_id, "status", VideoStatus.video_trans_waite + "");
        }
        
    }
    
    public void doMqAgainByVideoid(String userid, String video_pool_id, String hostid) {
        Video_pool_db vpdb = new Video_pool_db(hostid);
        DOC video_pool = vpdb.getOne(video_pool_id);
        if (video_pool.geti("status") == VideoStatus.video_trans_ing) {
            logger.info("视频已经在处理");
            // return;
        }
        try {
            progressService.deleteProgress(video_pool_id);
        } catch (Exception e) {
        
        }
        int seed = 0;
        /// =======重新提取原视频信息：处理加密视频====
        try {
            DBHelper_db db = new DBHelper_db();
            DOC doc = db.getDFSSourcefileName(video_pool_id);
            String source_file = doc.get("src");
            
            DFSClient client = new DFSClient();
            if (doc == null || !client.isExists(doc.get("groupName"), doc.get("dst"))) {
                logger.info(doc.get("dst") + " source not exists");
                return;
            }
            
            PlayProfile playProfile = playprofileService.getById(userid);
            DOC playext = new DOC();
            if (playProfile != null) {
                playext = com.cc.ovp.util.Ext.parseJson(playProfile.getExt());
            }
            
            String filename = LogicUtil.getVideoPublicFilePath(video_pool.get("video_pool_id"), userid);
            DOC ext = getVideoInfo(playext, source_file, video_pool.get("video_pool_id"), video_pool.getl("cataid"),
                    hostid, filename, source_file.substring(source_file.indexOf(".")), userid,
                    FileUtil.getFileSize(source_file), false);
            
            logger.info("getVideoEncryption(userid):" + getVideoEncryption(userid));
            if (getVideoEncryption(userid)) {
                seed = 1;
                
            }
            logger.info("put seed:" + seed);
            
            LinkedHashMap<String, Object> map = new LinkedHashMap<String, Object>();
            map.put("seed", seed);
            map.put("seed_const", LogicUtil.randomSeed());
            vpdb.updateExt(video_pool_id, map);
        } catch (Exception ee) {
            logger.error(ee.getMessage(), ee);
        }
        
        // ====加密视频处理完毕
        logger.info(">>>>>>>>>>>视频已存在，清除cdn，前端static缓存的MP4,提供给flash的接口xml");
        LogicUtil.cleanVXML(video_pool_id);
        
        ArrayList<BW> taskList = EncodeTask_logic.getTask(video_pool.geti("original_br"));
        logger.info("::::============重新转码 信息进入queue待处理.... ==" + taskList.size() + " taskList=" + taskList);
        if (taskList != null) {
            logger.info(">>>>>>>>>>>待转码视频数量: " + taskList.size() + " video_pool_id=" + video_pool_id);
            // 设置重新转码标志coding,从VideoStatus可以判断是重新转码(coding=25,26),还是第一次转码(coding=20),非常重要
            int coding = VideoStatus.video_trans_ing;
            if (video_pool.geti("status") == VideoStatus.video_publish_ok) {
                coding = VideoStatus.video_deal_again1;
            } else {
                coding = VideoStatus.video_deal_again0;
            }
            for (int i = 0; i < taskList.size(); i++) {
                BW bw = taskList.get(i);
                try {
                    long startTime = System.currentTimeMillis();
                    long ptime = System.currentTimeMillis();
                    videoLogSevice.insertLog(video_pool_id, bw.level, userid, video_pool.get("resolution"),
                            video_pool.get("title"), "0", video_pool.get("first_image"),
                            video_pool.get("swf_link" + bw.level), "0", "0", startTime, ptime, video_pool.get("my_br"),
                            coding, VideoStatus.video_trans_waite, "N", "","",VideoLog.TABLENAME_VALUE);
                    
                    videoLogSevice.cleanErrorInfo(userid, video_pool_id, bw.level);
                    // 清理缓存
                    if (seed == 0) {
                        String relativePath = video_pool.get("mp4_link" + (i + 1));
                        String sourcePath = "http://mpv.videocc.net/mp4/" + relativePath;
                        LogicUtil.cleanWangSuByUrl(sourcePath);
                    } else {
                        String groupName = video_pool.get("level_group_" + i);
                        CcUser ccUser = customerService.getByUserId(userid);
                        String surl = LogicUtil.getCdnUrl(ccUser.getSegurl(), groupName);
                        
                        String seg_link = "http://" + surl + "/pdx/"
                                + video_pool.get("swf_link" + (i + 1)).split("_")[0] + "_" + (i + 1) + ".pdx";
                        LogicUtil.cleanWangSuByUrl(seg_link);
                    }
                    
                } catch (Exception e) {
                    logger.error("exception: at com.cc.ovp.logic.Video_logic method=upload #cached#", e);
                }
                
            }
        }
        // 更新为视频表等待状态
        vpdb.update(video_pool_id, "status", VideoStatus.video_trans_waite + "");
        
    }
    
    public void doAgainShotByVideoid(String userid, String video_pool_id, String hostid) {
        Video_pool_db vpdb = new Video_pool_db(hostid);
        DOC video_pool = vpdb.getOne(video_pool_id);
        logger.info("::::============重新截图>>>>>>>>>> ");
        screenshot(video_pool.get("source_file"), hostid, video_pool.get("duration"),
                video_pool.get("original_definition"));
    }
    
    public void insert_links(ParamUtil pu, JspWriter out, String hostid, String userid) throws Exception {
        String[] links = pu.getString("links").split("\n");
        for (int i = 0; links != null && i < links.length; i++) {
            String link = links[i].trim();
            if (!StringUtil.isFine(link)) {
                continue;
            }
            DOC doc = VideoApi.getMeta(link);
            if (doc == null) {
                continue;
            }
            Video_pool_db vpdb = new Video_pool_db(hostid);
            DOC ext = new DOC();
            // ext.put("title", doc.get("title"));
            ext.put("duration", doc.get("duration"));
            ext.put("playtime", "");
            ext.put("images", new String[] { doc.get("image_link") });
            ext.put("first_image", doc.get("image_link"));
            ext.put("comment", doc.get("comment"));
            ext.put("source_filesize", "");
            ext.put("source", doc.get("source"));
            ext.put("swf_link", doc.get("swf_link"));
            long ptime = System.currentTimeMillis();
            long lmodify = ptime;
            vpdb.rinsert(EncryptUtil.getMD5(doc.get("swf_link")).toLowerCase(), doc.getl("cataid"), doc.get("catatree"),
                    userid, doc.get("title"), pu.getSourceString("describ"), pu.getString("publish_url", ""),
                    Ext.setJson(ext), doc.get("title"), userid, lmodify, ptime, doc.geti("times"), doc.geti("digg"), 0,
                    "", "", 0, doc.getl("size"));
            
        }
    }
    
    public void delete_pool(ParamUtil pu, JspWriter out, String hostid, String userid) throws Exception {
        String[] video_pool_ids = pu.getStrings("video_pool_id");
        Video_pool_db vpdb = new Video_pool_db(hostid);
        for (int i = 0; i < video_pool_ids.length; i++) {
            if (StringUtil.isFine(video_pool_ids[i])) {
                vpdb.delete(video_pool_ids[i].trim());
            }
        }
    }
    
    public void screenshot(final String uploadfile, final String hostid, final String original_duration,
            final String original_definition) {
        StringWriter writer = new StringWriter();
        String command = "";
        String source_file = LogicUtil.getSourceFilePath(uploadfile, hostid);
        
        // hostid + "/video_source/" // upload_fileext;
        if (!FileUtil.exists(source_file)) {
            logger.info(">>>从hdfs下载文件>>>>>>>>" + source_file);
            UploadService.getVideo(source_file);
        }
        String filename = uploadfile.split("\\.")[0];
        // 计算秒数
        String[] duration_times = original_duration.split("\\:");
        
        int hour = IntUtil.s2i(duration_times[0]);
        int minute = IntUtil.s2i(duration_times[1]);
        double second = IntUtil.s2d(duration_times[2]);
        double sum_seconds = hour * 3600 + minute * 60 + second;
        DecimalFormat df = new DecimalFormat("0.00");
        ArrayList<String> video_images = new ArrayList<String>();
        ArrayList<String> video_images_b = new ArrayList<String>();
        
        File[] file_video_image_s = new File[cover_images_count];
        String[] str_video_image_s = new String[cover_images_count];
        File[] file_video_image_b_s = new File[cover_images_count];
        String[] str_video_image_b_s = new String[cover_images_count];
        String[] picContentType = new String[cover_images_count];
        logger.info(":::::::::开始截图：：：：：" + cover_images_count);
        for (int i = 0; i < cover_images_count; i++) {
            String get_image_second = null;
            if (i == 0) {
                get_image_second = df.format(3);
            } else {
                get_image_second = df.format(sum_seconds / cover_images_count * i);
            }
            
            String video_image = Config.get("htmldir") + "video_image/" + hostid + "/" + filename + "_" + i + ".jpg";
            String video_image_b = Config.get("htmldir") + "video_image/" + hostid + "/" + filename + "_" + i
                    + "_b.jpg";
            String video_imagelink = filename + "_" + i + ".jpg";
            String video_imagelink_b = filename + "_" + i + "_b.jpg";
            command = "/bin/bash " + Config.get("svndir") + "/WEB-INF/sh/video_getimage.sh " + source_file + " "
                    + get_image_second + " " + video_image + " " + video_image_b + " " + original_definition;
            logger.info(">>>>>>>>截图i===" + command);
            Command.run(command, writer);
            
            video_images.add(video_imagelink);
            video_images_b.add(video_imagelink_b);
            
            file_video_image_s[i] = new File(video_image);
            str_video_image_s[i] = video_image;
            file_video_image_b_s[i] = new File(video_image_b);
            str_video_image_b_s[i] = video_image_b;
            picContentType[i] = "image/jpeg";
        }
        // 批量上传小图到hdfs
        UploadService.uploadPic(file_video_image_s, str_video_image_s, picContentType);
        // 批量上传大图到hdfs
        UploadService.uploadPic(file_video_image_b_s, str_video_image_b_s, picContentType);
    }
    
    public int deleteFile(String videoid, String hostid) {
        try {
            Data_db db = new Data_db("dfs_name_" + hostid);
            String sql = "SELECT * from dfs_name_" + hostid + " WHERE video_pool_id='" + videoid + "'";
            DOC[] docs = db.getData(sql, null);
            int ret = 0;
            if (docs != null) {
                for (DOC doc : docs) {
                    String str = doc.get("dst");
                    String groupName = doc.get("groupName");
                    ret = UploadService.deleteFile(groupName, str);
                    
                    String key = doc.get("id");
                    db.update(key, "del", 1);
                }
            }
            db.executeDelete("delete from dfs_name_" + hostid + " where video_pool_id='" + videoid + "'");
            Video_log_db vld = new Video_log_db();
            vld.delete(videoid);
            
            Video_pool_db vpd = new Video_pool_db(hostid);
            vpd.delete(videoid);
            
            // 跟新总表
            vpd = new Video_pool_db("all");
            vpd.delete(videoid);
            
            Video_log_db vldb = new Video_log_db();
            vldb.delete(videoid);
            
            Util.getUrl("http://segment.polyv.net/delete/" + videoid);
            // group4
            Util.getUrl("http://ws4s.videocc.net/delete/" + videoid);
            
            for (int i = 8; i <= Config.MAX_GROUP_NUM; i++) {
                Util.getUrl("http://ws" + i + "s.videocc.net/delete/" + videoid);
            }
            DBHelper_db helper = new DBHelper_db();
            helper.deleteVideoCallbackQueue(videoid);
            helper.deleteVideoStatusQueue(videoid);
            helper.deleteVideoImageQueue(videoid);
            
            return ret;
        } catch (Exception e) {
            logger.error(e, e);
            System.out.println(e.getMessage());
            return 0;
        }
    }
    
    private void sendCallback(String vid) {
        try {
            String userid = vid.substring(0, 10);
            
            CcUser user = ccUserService.getByUserId(userid);
            String transcoding_callback_url = user.getTcurl();
            String secretkey = user.getSecretkey();
            String sign = MD5Util.getMD5String("upload" + vid + secretkey);
            if (StringUtil.isFine(transcoding_callback_url) && transcoding_callback_url.startsWith("http://")) {
                
                backUrlThread but = new backUrlThread(
                        transcoding_callback_url + "?sign=" + sign + "&type=upload&vid=" + vid);
                System.out.println("upload sendCallback:" + vid + "&sign=" + sign);
                but.start();
            }
        } catch (Exception e) {
            
            // TODO: handle exception
        }
    }
    
    /**
     * 返回是否加密
     */
    public static boolean getVideoEncryption(String userid) {
        try {
            
            if (Redis2Utils.getString(Config.videoEncryption + userid) != null) {
                return Boolean.parseBoolean(Redis2Utils.getString(Config.videoEncryption + userid));
            } else {
                
                Map<String, Object> map = new HashMap<String, Object>();
                
                map.put("userid", userid);
                
                PlayProfileService playprofileService = (PlayProfileService) OVPContext.getBean("playprofileService");
                
                List<PlayProfile> playProfiles = playprofileService.getList(new Pager(), map);
                if (playProfiles.size() > 0) {
                    DOC doc = com.cc.ovp.util.Ext.parseJson(playProfiles.get(0).getExt());
                    if (doc.get("adownload").equals("1")) {
                        Redis2Utils.setString(Config.videoEncryption + userid, String.valueOf(true), 2000);
                        return true;
                    } else {
                        Redis2Utils.setString(Config.videoEncryption + userid, String.valueOf(false), 2000);
                        return false;
                    }
                } else {
                    return false;
                }
                
            }
            
        } catch (Exception e) {
            logger.error(e, e);
            return false;
            // TODO: handle exception
        }
    }
    
}
