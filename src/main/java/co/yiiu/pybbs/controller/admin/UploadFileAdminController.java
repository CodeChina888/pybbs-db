package co.yiiu.pybbs.controller.admin;


import co.yiiu.pybbs.model.Softcategory;
import co.yiiu.pybbs.service.UploadFileServies;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;



@Controller
@RequestMapping("/forum/admin")
public class UploadFileAdminController extends BaseAdminController
{
    @Autowired
    private UploadFileServies uploadFileServies;

    @RequiresPermissions("software:add")
    @PostMapping("/software/add")
    public String upload(@RequestParam("file") MultipartFile file,@RequestParam("version") String version,@RequestParam("description")String description,@RequestParam("categoryId") Integer categoryId, @RequestParam("path") String path) {
        //获取上传文件名
        String fileName = file.getOriginalFilename();
        //1.判断文件是否为空(是否上传文件 / 文件内容是否为空)
        if (file.isEmpty()){
            return  "上传文件不可以为空";
        }
        //2.判断文件后缀名是否符合要求
        String fileNameSuffix = fileName.substring(fileName.lastIndexOf(".") + 1);
        String Suffix = "csv/txt/zip/docx/sql/vsdx/ini";
//        if (!Suffix.contains(fileNameSuffix)){
        if (Suffix.indexOf(fileNameSuffix) < 0) {
            return "文件类型不正确";
        }
        //3.判断文件大小是否符合要求
        int size = (int) file.getSize();//获取上传文件大小,返回字节长度1M=1024k=1048576字节 - 文件过大进入controller之前抛出异常 - 前端判断文件大小
        //System.out.println("size:" + size);
       //if (size > 1024*1024){
           // return "上传文件过大，请上传小于1MB大小的文件";
        //}
        //4.将文件重命名，避免文件名相同覆盖文件
        String fileNamePrefix = fileName.substring(0 , fileName.lastIndexOf("."));
        fileName = fileNamePrefix + "-" + System.currentTimeMillis() + "." + fileNameSuffix;//获取上传文件名
        // TODO:文件名存放数据库
        //5.判断文件夹是否存在
       // String path = "D:/Files";
        // TODO:存放数据库
        uploadFileServies.upload(fileName,size,path + "/" + fileName,categoryId,version,description);

        File targetFile = new File(path + "/" + fileName);
        if (!targetFile.getParentFile().exists()) {
            //不存在创建文件夹
            targetFile.getParentFile().mkdirs();
        }
        try {
            //6.将上传文件写到服务器上指定的文件
            file.transferTo(targetFile);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return redirect("/forum/admin/software/list/"+categoryId);
    }

    /**
     * 多文件上传
     * @param files
     * @return
     */

    @PostMapping("postUploadMore")
    @ResponseBody
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
            //System.out.println("size:" + size);
           // if (size > 1024*1024){
                //return "第"+ (i+1) +"上传文件过大，请上传小于1MB大小的文件";
            //}
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
    @ResponseBody
    public String testDownload(HttpServletResponse res, HttpServletRequest request, @PathVariable String fileName) {

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

    @RequiresPermissions("software:list")
    @GetMapping("/software/list/{categoryId}")
    public String softwarelist(@RequestParam(defaultValue = "1") Integer pageNo, String name, Model model,@PathVariable int categoryId) {
        if (StringUtils.isEmpty(name)) name = null;
        IPage<co.yiiu.pybbs.model.Uploadfile> page = uploadFileServies.selectAllSoftware(pageNo, null, name,categoryId);
        model.addAttribute("page", page);
        model.addAttribute("categoryId",categoryId);
        model.addAttribute("name", name);
        return "admin/software/list";
    }

    @RequiresPermissions("software:add")
    @GetMapping("/software/add")
    public String softwareAdd(Model model,Integer categoryId) {
         Softcategory s=uploadFileServies.selecSoftcategorytById(categoryId);
         model.addAttribute("path",s.getPath());
         model.addAttribute("categoryId",categoryId);
        return "admin/software/add";
    }

    @RequiresPermissions("software:categoryadd")
    @GetMapping("/software/categoryadd")
    public String categoryAdd() {
        return "admin/software/categoryadd";
    }

    @RequiresPermissions("software:categoryadd")
    @PostMapping ("/software/categoryadd")
    public String categoryAdd(String name,String path,String description) {
        uploadFileServies.insertCategory(name,path,description);
        return redirect("/admin/software/categorylist");
    }


    @RequiresPermissions("software:categorylist")
    @GetMapping("/software/categorylist")
    public String categorylist(@RequestParam(defaultValue = "1") Integer pageNo, String name, Model model) {
        if (StringUtils.isEmpty(name)) name = null;
        IPage<Softcategory> page = uploadFileServies.selectAllCategory(pageNo, null, name);
        model.addAttribute("page", page);
        model.addAttribute("name", name);
        return "admin/software/categorylist";
    }






}
