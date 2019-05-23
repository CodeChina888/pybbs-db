package co.yiiu.pybbs.controller.admin;

import co.yiiu.pybbs.model.Document;
import co.yiiu.pybbs.model.DocumentCategory;
import co.yiiu.pybbs.model.DocumentLabel;
import co.yiiu.pybbs.service.*;
import co.yiiu.pybbs.util.FileUtil;
import co.yiiu.pybbs.util.Result;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/forum/documentCenter")
public class DocumentCenterController extends BaseAdminController {
    private Logger log = LoggerFactory.getLogger(DocumentCenterController.class);
    @Autowired
    private FileUtil fileUtil;
    @Autowired
    private DocumentCenterService documentCenterService;
    @Autowired
    private DocumentLabelService documentLabelService;
    @Autowired
    private SystemConfigService systemConfigService;
    @Autowired
    private LabelService labelService;
    @Autowired
    private DocumentCategoryService documentCategoryService;

    @RequiresPermissions("document:add")
    @GetMapping("/add")
    public String add(Model model) {
        List<DocumentCategory> categoryList=documentCategoryService.selectAll();
        model.addAttribute("categoryList",categoryList);
        model.addAttribute("labels",labelService.selectAll());
        return "admin/document/add";
    }

    @RequiresPermissions("document:edit")
    @GetMapping("/edit/{code}")
    public String edit(@PathVariable String code,Model model) {
        Document document=documentCenterService.selectByCode(code);
        List<DocumentCategory> categoryList=documentCategoryService.selectAll();
        model.addAttribute("categoryList",categoryList);
        model.addAttribute("labels",labelService.selectAll());
        model.addAttribute("document",document);
        return "admin/document/edit";
    }

    @RequiresPermissions("document:edit")
    @PostMapping("/edit")
    public String edit(@RequestParam("files") MultipartFile file,@RequestParam("pdfFile") MultipartFile pdfFile,Document document,Integer[]ids) {
        String path = systemConfigService.selectAllConfig().get("upload_path").toString();
        List<DocumentLabel> list=new ArrayList<>();
        // 文件上传
        if (!pdfFile.isEmpty() && pdfFile != null) {
            String fileName = pdfFile.getOriginalFilename();
            // 文件后缀
            String fileNameSuffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            String Suffix = "pdf";
            if (Suffix.indexOf(fileNameSuffix) < 0) {
                log.error("文件上传格式有误");
                return "文件上传格式有误";
            }
            document=documentCenterService.selectByCode(document.getCode());
            File pdf=new File(document.getPdfPath());
            if (pdf.exists()) {
                pdf.delete();
            }
            document.setPdfName(fileName);
            String fileNamePrefix = fileName.substring(0 , fileName.lastIndexOf("."));
            //获取上传文件名
            fileName = fileNamePrefix + "-" + System.currentTimeMillis() + "." + fileNameSuffix;
            String static_url=systemConfigService.selectAllConfig().get("static_url").toString()+"static/upload/"+fileName;
            fileUtil.uploadFile(pdfFile, path,fileName);
            document.setPdfUrl(static_url);
            document.setPdfPath(path+fileName);
        }

        if (!file.isEmpty() && file != null) {
            String fileName = file.getOriginalFilename();
            // 文件后缀
            String fileNameSuffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            String Suffix = "pdf/docx/doc";
            if (Suffix.indexOf(fileNameSuffix) < 0) {
                log.error("文件上传格式有误");
                return "文件上传格式有误";
            }
            document=documentCenterService.selectByCode(document.getCode());
            File files=new File(document.getFullpath());
            if (files.exists()) {
                files.delete();
            }
            document.setOriginName(fileName);
            //文件名的前缀
            String fileNamePrefix = fileName.substring(0 , fileName.lastIndexOf("."));
            //获取上传文件名
            fileName = fileNamePrefix + "-" + System.currentTimeMillis() + "." + fileNameSuffix;
            fileUtil.uploadFile(file, path,fileName);
            String static_url=systemConfigService.selectAllConfig().get("static_url").toString()+"static/upload/"+fileName;
            document.setPath(static_url);
            document.setCode((UUID.randomUUID().toString().replace("-", "").toLowerCase()));
            document.setUrl("/forum/document/download/"+document.getCode());
            document.setFullpath(path+fileName);
        }
        document.setCategory(documentCategoryService.selectById(document.getDocumentCategoryId()).getName());
        documentCenterService.update(document);
        DocumentLabel documentLabel;
        if (ids!=null) {
            documentLabelService.deleteLabelById(document.getId());
            for (int i=0;i<ids.length;i++) {
                documentLabel=new DocumentLabel();
                documentLabel.setDocId(document.getId());
                documentLabel.setLabelId(ids[i]);
                list.add(documentLabel);
            }
            documentLabelService.insert(list);
        }
        log.info("文件上传成功");
        return "redirect:/forum/documentCenter/list";
    }

    @RequiresPermissions("document:delete")
    @GetMapping("/delete/{code}")
    @ResponseBody
    public Result delete(@PathVariable String code) {
        fileUtil.removeFile(code);
        int id=documentCenterService.selectIdByCode(code);
        documentCenterService.delete(code);
        documentLabelService.deleteLabelById(id);
        return success();
    }

    //文件上传
    @RequiresPermissions("document:upload")
    @PostMapping("/upload")
    public String upload(@RequestParam("files") MultipartFile file,@RequestParam("pdfFile") MultipartFile pdfFile,Document document,Integer[]ids) {
        String path = systemConfigService.selectAllConfig().get("upload_path").toString();
        List<DocumentLabel> list=new ArrayList<>();
        // 文件上传
        if (!pdfFile.isEmpty() && pdfFile != null) {
            String fileName = pdfFile.getOriginalFilename();
            // 文件后缀
            String fileNameSuffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            String Suffix = "pdf";
            if (Suffix.indexOf(fileNameSuffix) < 0) {
                log.error("文件上传格式有误");
                return "文件上传格式有误";
            }
            document.setPdfName(fileName);
            String fileNamePrefix = fileName.substring(0 , fileName.lastIndexOf("."));
            //获取上传文件名
            fileName = fileNamePrefix + "-" + System.currentTimeMillis() + "." + fileNameSuffix;
            String static_url=systemConfigService.selectAllConfig().get("static_url").toString()+"static/upload/"+fileName;
            fileUtil.uploadFile(pdfFile, path,fileName);
            document.setPdfUrl(static_url);
            document.setPdfPath(path+fileName);
        } else {
            log.error("pdf文件为空");
            return "pdf文件为空";
        }

        if (!file.isEmpty() && file != null) {
            String fileName = file.getOriginalFilename();
            // 文件后缀
            String fileNameSuffix = fileName.substring(fileName.lastIndexOf(".") + 1);
            String Suffix = "pdf/docx/doc";
            if (Suffix.indexOf(fileNameSuffix) < 0) {
                log.error("文件上传格式有误");
                return "文件上传格式有误";
            }
            document.setOriginName(fileName);
            //文件名的前缀
            String fileNamePrefix = fileName.substring(0 , fileName.lastIndexOf("."));
            //获取上传文件名
            fileName = fileNamePrefix + "-" + System.currentTimeMillis() + "." + fileNameSuffix;
            fileUtil.uploadFile(file, path,fileName);
            String static_url=systemConfigService.selectAllConfig().get("static_url").toString()+"static/upload/"+fileName;
            document.setPath(static_url);
            document.setCode((UUID.randomUUID().toString().replace("-", "").toLowerCase()));
            document.setUrl("/forum/document/download/"+document.getCode());
            document.setFullpath(path+fileName);
        } else {
            log.error("文件为空！");
            return "admin/error";
        }
        DocumentLabel documentLabel;
        document.setCategory(documentCategoryService.selectById(document.getDocumentCategoryId()).getName());
        documentCenterService.insert(document);
        if (ids!=null) {
            for (int i=0;i<ids.length;i++) {
                documentLabel=new DocumentLabel();
                documentLabel.setDocId(document.getId());
                documentLabel.setLabelId(ids[i]);
                list.add(documentLabel);
            }
            documentLabelService.insert(list);
        }
        log.info("文件上传成功");
        return "redirect:/forum/documentCenter/list";
    }

    @RequiresPermissions("document:list")
    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "1") Integer pageNo, Model model)
    {
        IPage<Document> page = documentCenterService.selectAll(pageNo);
        model.addAttribute("page", page);
        return "admin/document/list";
    }

}