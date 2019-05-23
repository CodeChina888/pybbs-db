package co.yiiu.pybbs.controller.front;

import co.yiiu.pybbs.controller.api.BaseApiController;
import co.yiiu.pybbs.model.Document;
import co.yiiu.pybbs.model.Software;
import co.yiiu.pybbs.model.User;
import co.yiiu.pybbs.service.DocumentCategoryService;
import co.yiiu.pybbs.service.DocumentCenterService;
import co.yiiu.pybbs.service.SoftwareService;
import co.yiiu.pybbs.service.UserService;
import co.yiiu.pybbs.util.FileUtil;
import co.yiiu.pybbs.util.Result;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.util.List;

@Controller
@RequestMapping("/forum/software")
public class SoftwareController extends BaseApiController {
    @Autowired
    private FileUtil fileUtil;
    @Autowired
    private SoftwareService softwareService;
    @Autowired
    private UserService userService;
    @Autowired
    private DocumentCategoryService documentCategoryService;
    private Logger log= LoggerFactory.getLogger(SoftwareController.class);

    @ResponseBody
    @GetMapping("/download/{code}")
    public Result downloadFile(HttpServletResponse response, @PathVariable String code, HttpSession session){
        try {
            User user=(User) session.getAttribute("_user");
            Integer userId=user.getOriginId();
            List userLabel=userService.getUserLabel(userId);
            List requireLabel=softwareService.selectLabelByCode(code);
            userLabel.retainAll(requireLabel);
            if (requireLabel.isEmpty()) {
                if ("下载成功".equals(fileUtil.downloadSoftware(response, code))) {
                    return success("文件下载成功");
                } else {
                    return error("文件下载失败，请重试！");
                }
            }
            if (!userLabel.isEmpty()) {
                if ("下载成功".equals(fileUtil.downloadSoftware(response,code))) {
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

    @GetMapping("/list")
    public String softwareList(@RequestParam(defaultValue = "1") Integer pageNo, Model model) {
        IPage<Software> page = softwareService.selectAll(pageNo);
        model.addAttribute("pageNo", pageNo);
        model.addAttribute("page", page);
        return render("software/list");
    }
}
