package co.yiiu.pybbs.controller.front;

import co.yiiu.pybbs.controller.api.BaseApiController;
import co.yiiu.pybbs.model.Document;
import co.yiiu.pybbs.model.DocumentCategory;
import co.yiiu.pybbs.model.User;
import co.yiiu.pybbs.service.DocumentCategoryService;
import co.yiiu.pybbs.service.DocumentCenterService;
import co.yiiu.pybbs.service.UserService;
import co.yiiu.pybbs.util.FileUtil;
import co.yiiu.pybbs.util.Result;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.apache.http.HttpResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.util.Iterator;
import java.util.List;

@Controller
@RequestMapping("/forum/document")
public class DocumentController extends BaseApiController {
    @Autowired
    private FileUtil fileUtil;
    @Autowired
    private DocumentCenterService documentCenterService;
    @Autowired
    private UserService userService;
    @Autowired
    private DocumentCategoryService documentCategoryService;
    private Logger log= LoggerFactory.getLogger(DocumentController.class);

    @ResponseBody
    @GetMapping("/download/{code}")
    public Result downloadFile(HttpServletResponse response, @PathVariable String code, HttpSession session){
        try {
            User user=(User) session.getAttribute("_user");
            Integer userId=user.getOriginId();
            List userLabel=userService.getUserLabel(userId);
            List requireLabel=documentCenterService.selectLabelByCode(code);
            userLabel.retainAll(requireLabel);
            if (requireLabel.isEmpty()) {
                if ("下载成功".equals(fileUtil.downloadFile(response, code))) {
                    return success("文件下载成功");
                } else {
                    return error("文件下载失败，请重试！");
                }
            }
            if (!userLabel.isEmpty()) {
                if ("下载成功".equals(fileUtil.downloadFile(response,code))) {
                    return success("文件下载成功");
                }
            } else {
                return error("没有权限操作！");
            }
        }catch (Exception e){
            log.error(e.getMessage());
            e.printStackTrace();
        }
        return error("文件下载失败，请重试!");
    }

    @ResponseBody
    @GetMapping("/previews/{code}")
    public Result documentViews(@PathVariable String code, HttpServletResponse response,HttpSession session) throws UnsupportedEncodingException {
        try {
            User user=(User) session.getAttribute("_user");
            Integer userId=user.getOriginId();
            List userLabel=userService.getUserLabel(userId);
            List requireLabel=documentCenterService.selectLabelByCode(code);
            userLabel.retainAll(requireLabel);
            if (requireLabel.isEmpty()) {
                if ("预览成功".equals(fileUtil.previewFile(response,code))) {
                    return success("文件预览成功");
                }
            }
            if (!userLabel.isEmpty()) {
                if ("预览成功".equals(fileUtil.previewFile(response,code))) {
                    return success("文件预览成功");
                }
            } else {
                return error("没有权限操作！");
            }
        }catch (Exception e){
            log.error(e.getMessage());
            e.printStackTrace();
        }
        return error("文件预览失败，请重试");
    }

    @GetMapping("/list")
    public String documentList(@RequestParam(defaultValue = "1") Integer pageNo, String name,Model model) {
        if (StringUtils.isEmpty(name)) {
            name = null;
        }
        System.out.println(name);
        IPage<Document> page = documentCenterService.selectAll(pageNo,name);
        for (Document document:page.getRecords()) {
            System.out.println(document.toString());
        }
        model.addAttribute("pageNo", pageNo);
        model.addAttribute("page", page);
        model.addAttribute("name",name);
        return render("document/list");
    }
}
