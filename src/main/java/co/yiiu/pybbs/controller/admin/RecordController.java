package co.yiiu.pybbs.controller.admin;

import co.yiiu.pybbs.model.Record;
import co.yiiu.pybbs.service.RecordService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
@RequestMapping("/forum/admin/record")
public class RecordController {

    @Autowired
    private RecordService recordService;

    @RequiresPermissions("records:list")
    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "1") Integer pageNo, Model model){
        IPage<Record> iPage = recordService.selectAll(pageNo);
        model.addAttribute("page", iPage);
        return "admin/record/list";
    }
}
