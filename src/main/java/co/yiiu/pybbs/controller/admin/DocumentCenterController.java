package co.yiiu.pybbs.controller.admin;

import co.yiiu.pybbs.model.Document;
import co.yiiu.pybbs.service.DocumentCenterService;
import co.yiiu.pybbs.util.FileUtil;
import co.yiiu.pybbs.util.Result;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Controller
@RequestMapping("/forum/documentCenter")
public class DocumentCenterController extends BaseAdminController
{
    private Logger log= LoggerFactory.getLogger(DocumentCenterController.class);
    @Autowired
    private  FileUtil fileUtil;
    @Autowired
    private DocumentCenterService documentCenterService;
    @Value("${spring.servlet.multipart.max-file-size}")
    private String uploadAvatarSizeLimit;

    //文件上传
    @RequiresPermissions("document:upload")
    @PostMapping("/upload")
    @ResponseBody
    public Result upload(@RequestParam("file") MultipartFile file, Document document){
        try {
            if(file.isEmpty()||file==null) {
                log.error("文件为空！");
                return error("文件不能为空");
            }
            long size=file.getSize();
            String regix="[^0-9]";
            Pattern pattern=Pattern.compile(regix);
            Matcher matcher=pattern.matcher(uploadAvatarSizeLimit);
            int limitSize=Integer.parseInt(matcher.replaceAll("").trim());
            if(size > limitSize * 1024 * 1024){
                log.error("文件超过大小限制");
                return error("文件太大了，请上传文件大小在 " + limitSize + "MB 以内");
            }
            String fileName=file.getOriginalFilename();
            String fileNameSuffix=fileName.substring(fileName.lastIndexOf(".")+1);
            String Suffix = "pdf/docx/doc";
            if (Suffix.indexOf(fileNameSuffix) < 0){
                log.error("文件上传格式有误");
                return error("请上传正确的格式文件");
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        String url =fileUtil.uploadFile(file,document.getUrl());
        document.setPath(url);
        documentCenterService.insert(document);
        log.info("文件上传成功,路径为:"+url);
        return success(url);
    }

    @RequiresPermissions("document:list")
    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "1")Integer pageNo, Model model){
        IPage<Document> page =documentCenterService.selectAll(pageNo);
        model.addAttribute("page",page);
        return "admin/document/list";
    }

    @RequiresPermissions("document:add")
    @GetMapping("/add")
    public String add(Model model) {
        return "admin/document/add";
    }

    /**
     * 多文件上传
     * @param files
     * @return
     */
    @PostMapping("postUploadMore")
    public String uploadMore(@RequestParam("file") MultipartFile[] files){
        //文件上传位置
        String path = "D:/Files";
        for (int i = 0; i < files.length; i++){
            //1.判断文件是否为空
            if (files[i].isEmpty()){
                return "第"+ (i+1) +"个文件为空";
            }
            //2.判断文件后缀名是否符合要求
            //获取上传文件名
            String fileName = files[i].getOriginalFilename();
            String fileNameSuffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            String Suffix = "csv/txt/zip";
//        if (!Suffix.contains(fileNameSuffix)){
            if (Suffix.indexOf(fileNameSuffix) < 0) {
                return "第"+ (i+1) +"文件类型不正确";
            }
            //3.判断文件大小是否符合要求
            int size = (int) files[i].getSize();//获取上传文件大小,返回字节长度1M=1024k=1048576字节 - 文件过大进入controller之前抛出异常 - 前端判断文件大小
            System.out.println("size:" + size);
            if (size > 1024*1024){
                return "第"+ (i+1) +"上传文件过大，请上传小于1MB大小的文件";
            }
            //4.将文件重命名，避免文件名相同覆盖文件
            String fileNamePrefix = fileName.substring(0 , fileName.lastIndexOf("."));
            fileName = fileNamePrefix + "-" + System.currentTimeMillis() + "." + fileNameSuffix;//获取上传文件名
            // TODO:文件名存放数据库
            //5.判断文件夹是否存在
            File targetFile = new File(path + "/" + fileName);
            if (!targetFile.getParentFile().exists()) {
                //不存在创建文件夹
                targetFile.getParentFile().mkdirs();
            }
            try {
                //6.将上传文件写到服务器上指定的文件
                files[i].transferTo(targetFile);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return "success";
    }

    @RequestMapping(value = "/download/{fileName}", method = RequestMethod.GET)
    public String testDownload(HttpServletResponse res, HttpServletRequest request,@PathVariable String fileName) {
        String filePath = "D:/Files";
        File file = new File(filePath + "/" + fileName);
        System.out.println(file);
        if (file.exists()){//判断文件是否存在
            //判断浏览器是否为火狐
            try {
                if ("FF".equals(getBrowser(request))) {
                    // 火狐浏览器 设置编码new String(realName.getBytes("GB2312"), "ISO-8859-1");
                    fileName = new String(fileName.getBytes("GB2312"), "ISO-8859-1");
                }else{
                    fileName = URLEncoder.encode(fileName, "UTF-8");//encode编码UTF-8 解决大多数中文乱码
                    fileName = fileName.replace("+", "%20");//encode后替换空格  解决空格问题
                }
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
            res.setContentType("application/force-download");//设置强制下载
            res.setHeader("Content-Disposition", "attachment;filename=" + fileName);//设置文件名
            byte[] buff = new byte[1024];// 用来存储每次读取到的字节数组
            //创建输入流（读文件）输出流（写文件）
            BufferedInputStream bis = null;
            OutputStream os = null;
            try {
                os = res.getOutputStream();
                bis = new BufferedInputStream(new FileInputStream(file));
                int i = bis.read(buff);
                while (i != -1) {
                    os.write(buff, 0, buff.length);
                    os.flush();
                    i = bis.read(buff);
                }
            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                if (bis != null) {
                    try {
                        bis.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
                if (os != null){
                    try {
                        os.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
        }else {
            return "文件不存在！！！";
        }
        return "download success";
    }

    /**
     * @Title: getBrowser
     * @Description: 判断客户端浏览器
     * @return String
     * @author
     * @date
     */
    private static String getBrowser(HttpServletRequest request) {
        String UserAgent = request.getHeader("USER-AGENT").toLowerCase();
        if (UserAgent != null) {
            if (UserAgent.indexOf("msie") != -1)
                return "IE";
            if (UserAgent.indexOf("firefox") != -1)
                return "FF";
            if (UserAgent.indexOf("safari") != -1)
                return "SF";
        }
        return null;
    }

}
