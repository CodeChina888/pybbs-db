package co.yiiu.pybbs.util;

import co.yiiu.pybbs.model.Document;
import co.yiiu.pybbs.service.DocumentCenterService;
import co.yiiu.pybbs.service.SystemConfigService;
import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.security.MessageDigest;

/**
 * Created by tomoya.
 * Copyright (c) 2018, All Rights Reserved.
 * https://yiiu.co
 */
@Component
public class FileUtil {

  private Logger log = LoggerFactory.getLogger(FileUtil.class);

  @Autowired
  private SystemConfigService systemConfigService;
  @Autowired
  private DocumentCenterService documentCenterService;
  @Autowired
  private Document document;
  /**
   * 上传文件
   * @param file 要上传的文件对象
   * @param fileName 文件名，可以为空，为空的话，就生成一串uuid代替文件名
   * @param customPath 自定义存放路径，这个地址是跟在数据库里配置的路径后面的，
   *                   格式类似 avatar/admin 前后没有 / 前面表示头像，后面是用户的昵称，举例，如果将用户头像全都放在一个文件夹里，这里可以直接传个 avatar
   * @return
   */
  public String upload(MultipartFile file, String fileName, String customPath) {
    try {
      if (file == null || file.isEmpty()) {
        return null;
      }

      if (StringUtils.isEmpty(fileName)) {
        fileName = StringUtil.uuid();
      }
      String suffix = "." + file.getContentType().split("/")[1];
      // 如果存放目录不存在，则创建
      File savePath = new File(systemConfigService.selectAllConfig().get("upload_path").toString() + customPath);
      if (!savePath.exists()) savePath.mkdirs();

      // 给上传的路径拼上文件名与后缀
      String localPath = systemConfigService.selectAllConfig().get("upload_path").toString() + customPath + "/" + fileName + suffix;

      // 上传文件
      // 下面 BufferedOutputStream的构造参数是直接在参数里通过 new FileOutputStream() 的方式传入的，所以它没有对象接收
      // 但下面只关闭了 stream 的流，这个FileOutputStream有没有关闭呢？
      // 答案是关了，跟踪 stream.close() 源码就会发现，这货关闭的就是 OutputStream , 也就是传入的这个输出流
      // 另外实现了AutoCloseable这个接口的流当声明流被放在 try(){} 的()里时，流用完了，程序会自动的调用这个流的close()方法
      BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(new File(localPath)));
      stream.write(file.getBytes());
      stream.close();

      // 上传成功后返回访问路径
      return systemConfigService.selectAllConfig().get("static_url").toString() + customPath + "/" + fileName + suffix + "?v=" + StringUtil.randomNumber(1);
    } catch (IOException e) {
      log.error(e.getMessage());
      return null;
    }
  }

  // 上传文件
  public String uploadFile(MultipartFile file,String filePath,String fileName){
    try {
      File targetFile=new File(filePath+fileName);
      if (!targetFile.getParentFile().exists())
        //不存在创建文件夹
        targetFile.getParentFile().mkdirs();
      //6.将上传文件写到服务器上指定的文件
      file.transferTo(targetFile);
      log.info("文件上传成功");
      return "文件上传成功";
    }catch (Exception e){
      e.printStackTrace();
      log.error(e.getMessage());
    }
    return "文件上传失败";
  }

  // 下载文件
  public String downloadFile(HttpServletResponse response,String code) throws UnsupportedEncodingException {
    document=documentCenterService.selectByCode(code);
    String fullPath = document.getFullpath();
    String originName = document.getOriginName();
    // 获取了文件名称
    if (originName != null) {
      //设置文件路径
      File file = new File(fullPath);
      if (file.exists()) {
        response.setContentType("application/force-download");
        // 设置强制下载不打开
//        response.setHeader("Content-Disposition","inline;fileName=" +new String(originName.getBytes("UTF-8"),"iso-8859-1"));
        response.addHeader("Content-Disposition","attachment;fileName=" +new String(originName.getBytes("UTF-8"),"iso-8859-1"));
        response.setCharacterEncoding("utf-8");
        byte[] buffer = new byte[1024];
        FileInputStream fis = null;
        BufferedInputStream bis = null;
        try {
          fis = new FileInputStream(file);
          bis = new BufferedInputStream(fis);
          OutputStream os = response.getOutputStream();
          int i = bis.read(buffer);
          while (i != -1) {
            os.write(buffer, 0, i);
            i = bis.read(buffer);
          }
          return "下载成功";
        } catch (Exception e) {
          e.printStackTrace();
        } finally {
          if (bis != null) {
            try {
              bis.close();
            } catch (IOException e) {
              e.printStackTrace();
            }
          }
          if (fis != null) {
            try {
              fis.close();
            } catch (IOException e) {
              e.printStackTrace();
            }
          }
        }
      }
    }
    return "下载失败";
  }


  // 删除文件
  public boolean removeFile(String code){
    document=documentCenterService.selectByCode(code);
    String path=document.getFullpath();
    File file=new File(path);
    if (file.exists()) {
      file.delete();
      return true;
    }
    return false;
  }

  public String previewFile(HttpServletResponse response,String code) throws UnsupportedEncodingException {
    document=documentCenterService.selectByCode(code);
    String fullPath = document.getFullpath();
    String originName = document.getOriginName();
    // 获取了文件名称
    if (originName != null) {
      //设置文件路径
      File file = new File(fullPath);
      if (file.exists()) {
        response.setHeader("Content-Disposition","inline;fileName=" +new String(originName.getBytes("UTF-8"),"iso-8859-1"));
        byte[] buffer = new byte[1024];
        FileInputStream fis = null;
        BufferedInputStream bis = null;
        try {
          fis = new FileInputStream(file);
          bis = new BufferedInputStream(fis);
          OutputStream os = response.getOutputStream();
          int i = bis.read(buffer);
          while (i != -1) {
            os.write(buffer, 0, i);
            i = bis.read(buffer);
          }
          return "预览成功";
        } catch (Exception e) {
          e.printStackTrace();
        } finally {
          if (bis != null) {
            try {
              bis.close();
            } catch (IOException e) {
              e.printStackTrace();
            }
          }
          if (fis != null) {
            try {
              fis.close();
            } catch (IOException e) {
              e.printStackTrace();
            }
          }
        }
      }
    }
    return "预览失败";
  }

  // md5文件校验
  public String getFileMd5(String filePath){
    File file = new File(filePath);
    if(!file.exists() || !file.isFile()){
      return "文件不存在，生成Md5失败";
    }
    byte[] buffer = new byte[2048];
    try {
      MessageDigest digest = MessageDigest.getInstance("MD5");
      FileInputStream in = new FileInputStream(file);
      while(true){
        int len = in.read(buffer,0,2048);
        if(len != -1){
          digest.update(buffer, 0, len);
        }else{
          break;
        }
      }
      in.close();
      byte[] md5Bytes  = digest.digest();
      StringBuffer hexValue = new StringBuffer();
      for (int i = 0; i < md5Bytes.length; i++) {
        int val = ((int) md5Bytes[i]) & 0xff;
        if (val < 16) {
          hexValue.append("0");
        }
        hexValue.append(Integer.toHexString(val));
      }
      return hexValue.toString();
    } catch (Exception e) {
      e.printStackTrace();
      return "";
    }
  }



}
