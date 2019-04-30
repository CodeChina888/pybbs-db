package co.yiiu.pybbs.controller.admin;

import co.yiiu.pybbs.model.Document;
import co.yiiu.pybbs.model.DocumentLabel;
import co.yiiu.pybbs.service.DocumentCenterService;
import co.yiiu.pybbs.service.DocumentLabelService;
import co.yiiu.pybbs.service.LabelService;
import co.yiiu.pybbs.service.SystemConfigService;
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
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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

    //文件上传
    @RequiresPermissions("document:upload")
    @PostMapping("/upload")
    @ResponseBody
    public Result upload(@RequestParam("file") MultipartFile file, Document document,Integer[]ids) {
        String uploadPath=systemConfigService.selectAllConfig().get("upload_path").toString();
        List<DocumentLabel> list=new ArrayList<>();
        if (file.isEmpty() || file == null) {
            log.error("文件为空！");
            return error("文件不能为空");
        }
        String fileName = file.getOriginalFilename();
        document.setOriginName(fileName);
        String fileNameSuffix = fileName.substring(fileName.lastIndexOf(".") + 1);
        String Suffix = "pdf/docx/doc";
        if (Suffix.indexOf(fileNameSuffix) < 0) {
            log.error("文件上传格式有误");
            return error("请上传正确的格式文件");
        }
        String path=uploadPath+document.getDocumentClass()+"/"+document.getDocumentType()+"/"+document.getDocumentClassify()+"/"+document.getDocumentName()+"/";
        //文件名的前缀
        String fileNamePrefix = fileName.substring(0 , fileName.lastIndexOf("."));
        //获取上传文件名
        fileName = fileNamePrefix + "-" + System.currentTimeMillis() + "." + fileNameSuffix;
        fileUtil.uploadFile(file, path,fileName);
        document.setPath(path);
        document.setCode((UUID.randomUUID().toString().replace("-", "").toLowerCase()));
        document.setUrl("/forum/document/download/"+document.getCode());
        document.setFullpath(path+fileName);
        System.out.println(fileUtil.getFileMd5(document.getFullpath()));
        DocumentLabel documentLabel;
        documentCenterService.insert(document);
        for (int i=0;i<ids.length;i++) {
            documentLabel=new DocumentLabel();
            documentLabel.setDocId(document.getId());
            documentLabel.setLabelId(ids[i]);
            list.add(documentLabel);
        }
        documentLabelService.insert(list);
        log.info("文件上传成功");
        return success();
    }

    @RequiresPermissions("document:list")
    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "1") Integer pageNo, Model model) {
        IPage<Document> page = documentCenterService.selectAll(pageNo);
        model.addAttribute("page", page);
        return "admin/document/list";
    }

    @RequiresPermissions("document:add")
    @GetMapping("/add")
    public String add(Model model) {
        model.addAttribute("labels",labelService.selectAll());
        return "admin/document/add";
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



}