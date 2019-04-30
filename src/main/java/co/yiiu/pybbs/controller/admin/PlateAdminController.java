package co.yiiu.pybbs.controller.admin;

import co.yiiu.pybbs.model.Plate;
import co.yiiu.pybbs.service.PlateServies;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/forum/admin/plate")
public class PlateAdminController extends BaseAdminController
{   @Autowired
    private PlateServies plateServies;

    @RequiresPermissions("plate:list")
    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "1") Integer pageNo, String name, Model model) {
        if (StringUtils.isEmpty(name)) {
            name = null;
        }
        IPage<Plate> page = plateServies.selectAll(pageNo, null, name);
        model.addAttribute("page", page);
        model.addAttribute("name", name);
        return "admin/plate/list";
    }
}
