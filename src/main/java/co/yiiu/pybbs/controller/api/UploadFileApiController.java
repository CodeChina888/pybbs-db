package co.yiiu.pybbs.controller.api;

import co.yiiu.pybbs.controller.admin.BaseAdminController;
import co.yiiu.pybbs.model.SoftCategory;
import co.yiiu.pybbs.model.Uploadfile;
import co.yiiu.pybbs.model.User;
import co.yiiu.pybbs.service.UploadFileServies;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.net.URLEncoder;

@Controller
@RequestMapping("/api")
public class UploadFileApiController extends BaseAdminController
{
    @Autowired
    private UploadFileServies uploadFileServies;

    @GetMapping("/software/list/{categoryId}")
    public String softwareList(@RequestParam(defaultValue = "1") Integer pageNo, String name, Model model, @PathVariable int categoryId) {
        if (StringUtils.isEmpty(name)) name = null;
        IPage<Uploadfile> page = uploadFileServies.selectAllSoftware(pageNo, null, name,categoryId);
        model.addAttribute("page", page);
        model.addAttribute("categoryId",categoryId);
        model.addAttribute("name", name);
        return  render("software/softwarelist");
    }

    @GetMapping("/software/categorylist")
    public String categoryList(@RequestParam(defaultValue = "1") Integer pageNo, String name, @RequestParam(defaultValue = "0")int cgId, Model model) {
        if (StringUtils.isEmpty(name)) name = null;
        IPage<SoftCategory> page = uploadFileServies.selectAllCategory(pageNo, null, name,cgId);
        model.addAttribute("page", page);
        model.addAttribute("name", name);
        return render("software/categorylist");
    }

    @RequestMapping(value = "/software/download/{id}", method = RequestMethod.GET)
    @ResponseBody
    public String testDownload(HttpServletResponse res, HttpServletRequest request, HttpSession session, @PathVariable Integer id) {
        // 获取用户信息
        User user=(User) session.getAttribute("_user");
        // 用户id
        Integer userId=user.getOriginId();
        Uploadfile u=uploadFileServies.selectuploadfileById(id);
        File file = new File(u.getUrl());
        String fileName = u.getFileName();
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
