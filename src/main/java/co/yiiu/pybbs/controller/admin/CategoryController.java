package co.yiiu.pybbs.controller.admin;

import co.yiiu.pybbs.model.Category;
import co.yiiu.pybbs.model.view.Categories;
import co.yiiu.pybbs.service.CategoryService;
import co.yiiu.pybbs.util.Result;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.LinkedList;
import java.util.List;

@Controller
@RequestMapping("/forum/category")
public class CategoryController extends BaseAdminController{
    @Autowired
    private CategoryService categoryService;

    @RequiresPermissions("category:add")
    @GetMapping("/add")
    public String add(Model model){
        model.addAttribute("pName",categoryService.selectByPid(0));
        return "admin/category/add";
    }

    @RequiresPermissions("category:add")
    @PostMapping("/add")
    public String add(Category category){
        categoryService.add(category);
        return "redirect:/forum/category/list";
    }

    @RequiresPermissions("category:edit")
    @GetMapping("/edit/{id}")
    public String edit(@PathVariable Integer id,Model model){
        Category category=categoryService.selectById(id);
        model.addAttribute("pid",category.getPid());
        model.addAttribute("id",id);
        return "admin/category/edit";
    }

    @RequiresPermissions("category:edit")
    @PostMapping("/edit")
    public String edit(Category category){
        categoryService.update(category);
        return "redirect:/forum/category/list";
    }

    @RequiresPermissions("category:delete")
    @GetMapping("/delete")
    @ResponseBody
    public Result delete(Integer id){
        categoryService.delete(id);
        return success();
    }

    @RequiresPermissions("category:list")
    @GetMapping("/list")
    public String list(Model model,@RequestParam(defaultValue = "1")Integer pageNo){
        IPage<Category> iPage=categoryService.selectAll(pageNo);
        List<Category> categories = iPage.getRecords();
        List<Categories> list = new LinkedList<>();
        for (int i=0;i<categories.size();i++) {
            int pid = categories.get(i).getPid();
            int id = categories.get(i).getId();
            String name = categories.get(i).getName();
            Date time = categories.get(i).getInTime();
            if (pid == 0) {
                list.add(new Categories(id,name,time,pid,"无"));
            } else {
                String pName = categoryService.selectById(pid).getName();
                list.add(new Categories(id,name,time,pid,pName));
            }
        }
        model.addAttribute("category",list);
        model.addAttribute("page",iPage);
        return "admin/category/list";
    }





}
