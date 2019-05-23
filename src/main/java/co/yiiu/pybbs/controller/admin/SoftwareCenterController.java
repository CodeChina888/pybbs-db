package co.yiiu.pybbs.controller.admin;

import co.yiiu.pybbs.mapper.SoftwareMapper;
import co.yiiu.pybbs.model.*;
import co.yiiu.pybbs.service.*;
import co.yiiu.pybbs.util.FileUtil;
import co.yiiu.pybbs.util.Result;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/forum/softwareCenter")
public class SoftwareCenterController extends BaseAdminController {
    private Logger log = LoggerFactory.getLogger(SoftwareCenterController.class);
    @Autowired
    private FileUtil fileUtil;
    @Autowired
    private SoftwareService softwareService;
    @Autowired
    private SoftwareLabelServise softwareLabelServise;
    @Autowired
    private SystemConfigService systemConfigService;
    @Autowired
    private LabelService labelService;
    @Autowired
    private DocumentCategoryService softwareCategoryService;

    @RequiresPermissions("software:add")
    @GetMapping("/add")
    public String add(Model model) {
        List<DocumentCategory> categoryList=softwareCategoryService.selectAll();
        model.addAttribute("categoryList",categoryList);
        model.addAttribute("labels",labelService.selectAll());
        return "admin/software/add";
    }

    @RequiresPermissions("software:edit")
    @GetMapping("/edit/{code}")
    public String edit(@PathVariable String code,Model model) {
        Software software=softwareService.selectByCode(code);
        List<DocumentCategory> categoryList=softwareCategoryService.selectAll();
        model.addAttribute("categoryList",categoryList);
        model.addAttribute("labels",labelService.selectAll());
        model.addAttribute("software",software);
        return "admin/software/edit";
    }

    @RequiresPermissions("software:edit")
    @PostMapping("/edit")
    public String edit(@RequestParam("files") MultipartFile file,Software software,Integer[]ids) {
        String path = systemConfigService.selectAllConfig().get("upload_path").toString();
        List<SoftwareLabel> list=new ArrayList<>();
        // 文件上传
        if (!file.isEmpty() && file != null) {
            String fileName = file.getOriginalFilename();
            // 文件后缀
            String fileNameSuffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            String Suffix = "pdf/docx/doc";
            if (Suffix.indexOf(fileNameSuffix) < 0) {
                log.error("文件上传格式有误");
                return "文件上传格式有误";
            }
            fileUtil.removeSoftware(software.getCode());
            software.setOriginName(fileName);
            //文件名的前缀
            String fileNamePrefix = fileName.substring(0 , fileName.lastIndexOf("."));
            //获取上传文件名
            fileName = fileNamePrefix + "-" + System.currentTimeMillis() + "." + fileNameSuffix;
            fileUtil.uploadFile(file, path,fileName);
            String static_url=systemConfigService.selectAllConfig().get("static_url").toString()+"static/upload/"+fileName;
            software.setPath(static_url);
            software.setCode((UUID.randomUUID().toString().replace("-", "").toLowerCase()));
            software.setUrl("/forum/software/download/"+software.getCode());
            software.setFullpath(path+fileName);
        }
        software.setCategory(softwareCategoryService.selectById(software.getSoftwareCategoryId()).getName());
        SoftwareLabel softwareLabel;
        softwareService.update(software);
        if (ids!=null) {
            softwareLabelServise.delete(software.getId());
            for (int i=0;i<ids.length;i++) {
                softwareLabel=new SoftwareLabel();
                softwareLabel.setSoftwareId(software.getId());
                softwareLabel.setLabelId(ids[i]);
                list.add(softwareLabel);
            }
            softwareLabelServise.insert(list);
        }
        log.info("文件上传成功");
        return "redirect:/forum/softwareCenter/list";
    }

    @RequiresPermissions("software:delete")
    @GetMapping("/delete/{code}")
    @ResponseBody
    public Result delete(@PathVariable String code) {
        fileUtil.removeSoftware(code);
        int id=softwareService.selectByCode(code).getId();
        softwareService.delete(code);
        softwareLabelServise.delete(id);
        return success();
    }

    //文件上传
    @RequiresPermissions("software:upload")
    @PostMapping("/upload")
    @Transactional
    public String upload(@RequestParam("files") MultipartFile file,Software software,Integer[]ids) {
        String path = systemConfigService.selectAllConfig().get("upload_path").toString();
        List<SoftwareLabel> list=new ArrayList<>();
        // 文件上传
        if (!file.isEmpty() && file != null) {
            String fileName = file.getOriginalFilename();
            // 文件后缀
            String fileNameSuffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            String Suffix = "pdf/docx/doc";
            if (Suffix.indexOf(fileNameSuffix) < 0) {
                log.error("文件上传格式有误");
                return null;
            }
            software.setOriginName(fileName);
            //文件名的前缀
            String fileNamePrefix = fileName.substring(0 , fileName.lastIndexOf("."));
            //获取上传文件名
            fileName = fileNamePrefix + "-" + System.currentTimeMillis() + "." + fileNameSuffix;
            fileUtil.uploadFile(file, path,fileName);
            String static_url=systemConfigService.selectAllConfig().get("static_url").toString()+"static/upload/"+fileName;
            software.setPath(static_url);
            software.setCode((UUID.randomUUID().toString().replace("-", "").toLowerCase()));
            software.setUrl("/forum/software/download/"+software.getCode());
            software.setFullpath(path+fileName);
        } else {
            log.error("文件为空！");
            return null;
        }
        SoftwareLabel softwareLabel;
        software.setCategory(softwareCategoryService.selectById(software.getSoftwareCategoryId()).getName());
        softwareService.insert(software);
        if (ids!=null) {
            for (int i=0;i<ids.length;i++) {
                softwareLabel=new SoftwareLabel();
                softwareLabel.setSoftwareId(software.getId());
                softwareLabel.setLabelId(ids[i]);
                list.add(softwareLabel);
            }
            softwareLabelServise.insert(list);
        }
        log.info("文件上传成功");
        return "redirect:/forum/softwareCenter/list";
    }

    @RequiresPermissions("software:list")
    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "1") Integer pageNo, Model model)
    {
        IPage<Software> page = softwareService.selectAll(pageNo);
        model.addAttribute("page", page);
        return "admin/software/list";
    }

}