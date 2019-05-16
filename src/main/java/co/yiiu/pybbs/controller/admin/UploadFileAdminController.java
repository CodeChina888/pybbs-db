package co.yiiu.pybbs.controller.admin;


import co.yiiu.pybbs.model.Label;
import co.yiiu.pybbs.model.Softcategory;
import co.yiiu.pybbs.model.Uploadfile;
import co.yiiu.pybbs.service.FileLabelServise;
import co.yiiu.pybbs.service.LabelService;
import co.yiiu.pybbs.service.UploadFileServies;
import co.yiiu.pybbs.util.Result;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import java.io.*;
import java.util.List;


@Controller
@RequestMapping("/forum/admin")
public class UploadFileAdminController extends BaseAdminController
{
    @Autowired
    private UploadFileServies uploadFileServies;
    @Autowired
    private LabelService labelService;
    @Autowired
    private FileLabelServise fileLabelServise;


    @RequiresPermissions("software:add")
    @PostMapping("/software/add")
    public String upload(@RequestParam("file") MultipartFile file, @RequestParam("version") String version, @RequestParam("description") String description, @RequestParam("categoryId") Integer categoryId, @RequestParam("path") String path, @RequestParam("label") String[] Labels)
    {
        //获取上传文件名
        String fileName = file.getOriginalFilename();
        String originName = fileName;
        //1.判断文件是否为空(是否上传文件 / 文件内容是否为空)
        if (file.isEmpty())
        {
            return "上传文件不可以为空";
        }
        //2.判断文件后缀名是否符合要求
        String fileNameSuffix = fileName.substring(fileName.lastIndexOf(".") + 1);
        String Suffix = "csv/txt/zip/docx/sql/vsdx/ini/dll/vmdk/jpg/pdf";
        if (Suffix.indexOf(fileNameSuffix) < 0)
        {
            return "文件类型不正确";
        }
        //3.判断文件大小是否符合要求
        int size = (int) file.getSize();//获取上传文件大小,返回字节长度1M=1024k=1048576字节 - 文件过大进入controller之前抛出异常 - 前端判断文件大小
        //4.将文件重命名，避免文件名相同覆盖文件
        String fileNamePrefix = fileName.substring(0, fileName.lastIndexOf("."));
        fileName = fileNamePrefix + "-" + System.currentTimeMillis() + "." + fileNameSuffix;//获取上传文件名
        // TODO:文件名存放数据库
        // TODO:存放数据库
        uploadFileServies.upload(fileName, size, path + "/" + fileName, categoryId, version, description, Labels, originName);

        File targetFile = new File(path + "/" + fileName);
        if (!targetFile.getParentFile().exists())
        {
            //不存在创建文件夹
            targetFile.getParentFile().mkdirs();
        }
        try
        {
            //6.将上传文件写到服务器上指定的文件
            file.transferTo(targetFile);
        }
        catch (IOException e)
        {
            e.printStackTrace();
        }
        return redirect("/forum/admin/software/list?categoryId=" + categoryId);
    }

    /**
     * 多文件上传
     *
     * @param files
     * @return
     */

    @PostMapping("postUploadMore")
    @ResponseBody
    public String uploadMore(@RequestParam("file") MultipartFile[] files)
    {
        //文件上传位置
        String path = "D:/Files";
        for (int i = 0; i < files.length; i++)
        {
            //1.判断文件是否为空
            if (files[i].isEmpty())
            {
                return "第" + (i + 1) + "个文件为空";
            }
            //2.判断文件后缀名是否符合要求
            //获取上传文件名
            String fileName = files[i].getOriginalFilename();
            String fileNameSuffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            String Suffix = "csv/txt/zip";
            if (Suffix.indexOf(fileNameSuffix) < 0)
            {
                return "第" + (i + 1) + "文件类型不正确";
            }
            //3.判断文件大小是否符合要求
            int size = (int) files[i].getSize();//获取上传文件大小,返回字节长度1M=1024k=1048576字节 - 文件过大进入controller之前抛出异常 - 前端判断文件大小
            //4.将文件重命名，避免文件名相同覆盖文件
            String fileNamePrefix = fileName.substring(0, fileName.lastIndexOf("."));
            fileName = fileNamePrefix + "-" + System.currentTimeMillis() + "." + fileNameSuffix;//获取上传文件名
            // TODO:文件名存放数据库
            //5.判断文件夹是否存在
            File targetFile = new File(path + "/" + fileName);
            if (!targetFile.getParentFile().exists())
            {
                //不存在创建文件夹
                targetFile.getParentFile().mkdirs();
            }
            try
            {
                //6.将上传文件写到服务器上指定的文件
                files[i].transferTo(targetFile);
            }
            catch (IOException e)
            {
                e.printStackTrace();
            }
        }
        return "success";
    }


    @RequiresPermissions("software:list")
    @GetMapping("/software/list")
    public String softwarelist(@RequestParam(defaultValue = "1") Integer pageNo, String name, Model model, Integer categoryId)
    {
        if (StringUtils.isEmpty(name)) {
            name = null;
        }
        IPage<co.yiiu.pybbs.model.Uploadfile> page = uploadFileServies.selectAllSoftware(pageNo, null, name, categoryId);
        model.addAttribute("page", page);
        model.addAttribute("categoryId", categoryId);
        model.addAttribute("name", name);
        return "admin/software/list";
    }

    @RequiresPermissions("software:add")
    @GetMapping("/software/add")
    public String softwareAdd(Model model, Integer categoryId)
    {
        Softcategory s = uploadFileServies.selecSoftcategorytById(categoryId);
        List<Label> list = labelService.selectall();
        model.addAttribute("path", s.getPath());
        model.addAttribute("categoryId", categoryId);
        model.addAttribute("Labels", list);
        return "admin/software/add";
    }

    @RequiresPermissions("software:categoryadd")
    @GetMapping("/software/categoryadd")
    public String categoryAdd(@RequestParam(defaultValue = "0") Integer cgId, @RequestParam(defaultValue = "") String path, @RequestParam(defaultValue = "0") int layer, Model model)
    {
        model.addAttribute("layer", layer);
        model.addAttribute("cgId", cgId);
        return "admin/software/categoryadd";
    }

    @RequiresPermissions("software:categoryadd")
    @PostMapping("/software/categoryadd")
    public String categoryAdd(String name,String description, int cgId, int layer, Model model)
    {
        uploadFileServies.insertCategory(name, description, cgId, layer);
        model.addAttribute("cgId", cgId);
        return redirect("/forum/admin/software/categorylist");
    }


    @RequiresPermissions("software:categorylist")
    @GetMapping("/software/categorylist")
    public String categorylist(@RequestParam(defaultValue = "1") Integer pageNo, String name, @RequestParam(defaultValue = "0") int cgId, Model model)
    {
        if (StringUtils.isEmpty(name)) {
            name = null;
        }
        IPage<Softcategory> page = uploadFileServies.selectAllCategory(pageNo, null, name, cgId);
        IPage<Uploadfile> softs = uploadFileServies.selectAllSoftware(pageNo, null, name, cgId);
        Softcategory SoftCategory = uploadFileServies.selecSoftcategorytById(cgId);
        if (softs != null)
        {
            model.addAttribute("softs", softs);
        }
        if (SoftCategory != null)
        {
            model.addAttribute("categoryName", SoftCategory.getName());
        }
        model.addAttribute("page", page);
        model.addAttribute("name", name);
        return "admin/software/categorylist";
    }
    @RequiresPermissions("software:delete")
    @GetMapping("/software/delete")
    @ResponseBody
    public Result softwareDelete(Integer softId)
    {
        Uploadfile uploadfile = uploadFileServies.selectuploadfileById(softId);
        File targetFile = new File(uploadfile.getUrl());
        if (targetFile.exists())
        {
            targetFile.delete();
        }
        else {
            return error("软件不存在");
        }
        uploadFileServies.deletefileById(softId);
        return success();

    }
    @RequiresPermissions("software:edit")
    @GetMapping("/software/edit")
    public String edit(Integer id, Model model) {
        model.addAttribute("software",uploadFileServies.selectuploadfileById(id));
        model.addAttribute("labels",labelService.selectall());
        model.addAttribute("categorys",uploadFileServies.selectall());
        model.addAttribute("filelabels",fileLabelServise.softLabels(id));
        return "admin/software/edit";
    }

    @RequiresPermissions("software:edit")
    @PostMapping("/software/edit")
    public String update(@RequestParam("id") Integer id,@RequestParam("originName") String originName,@RequestParam("version") String version,@RequestParam(name = "label",defaultValue ="") String[] labels ,@RequestParam("description")String description,@RequestParam("categorys") String categorys) throws IOException
    {
        Uploadfile uploadfile=uploadFileServies.selectuploadfileById(id);
        Integer  categoryId=uploadfile.getCategoryId();
        if (uploadfile.getCategoryId()!=Integer.parseInt(categorys)){
            Softcategory softCategory=uploadFileServies.selecSoftcategorytById(Integer.parseInt(categorys));
            File targetFile = new File(uploadfile.getUrl());
            String fileNameSuffix = originName.substring(originName.lastIndexOf(".") + 1);
            String fileNamePrefix = originName.substring(0, originName.lastIndexOf("."));
            String fileName = fileNamePrefix + "-" + System.currentTimeMillis() + "." + fileNameSuffix;
            File outputFile=new File(softCategory.getPath()+"/" + fileName);
            FileUtils.moveFile(targetFile,outputFile);
            uploadfile.setUrl(softCategory.getPath()+"/" + fileName);
            uploadfile.setCategoryId(softCategory.getId());
            categoryId=softCategory.getId();
        }
        uploadfile.setOriginName(originName);
        uploadfile.setVersion(version);
        uploadfile.setDescription(description);
        uploadFileServies.updateFile(uploadfile,labels);
        return redirect("/forum/admin/software/list?categoryId=" +categoryId);
    }




}
