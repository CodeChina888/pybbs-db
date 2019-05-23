package co.yiiu.pybbs.controller.admin;

import co.yiiu.pybbs.model.Category;
import co.yiiu.pybbs.model.DocumentCategory;
import co.yiiu.pybbs.model.view.Categories;
import co.yiiu.pybbs.service.CategoryService;
import co.yiiu.pybbs.service.DocumentCategoryService;
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
@RequestMapping("/forum/documentCategory")
public class DocumentCategoryController extends BaseAdminController{
    @Autowired
    private DocumentCategoryService documentCategoryService;
    @Autowired
    private CategoryService categoryService;

    @RequiresPermissions("DocumentCategory:add")
    @GetMapping("/add")
    public String add(Model model){
        List<Category> categoryList = categoryService.selectByPid(0);
        List<Categories> categoriesList = new LinkedList<>();
        for (Category category:categoryList) {
            List<Category> categories = categoryService.selectByPid(category.getId());
            for (Category category1:categories) {
                categoriesList.add(new Categories(category1.getId(),category1.getName(),category1.getInTime(),category1.getPid(),category.getName()+"/"+category1.getName()));
            }
        }
        model.addAttribute("categoriesList",categoriesList);
        return "admin/DocumentCategory/add";
    }

    @RequiresPermissions("DocumentCategory:add")
    @PostMapping("/add")
    public String add(DocumentCategory documentCategory){
        documentCategory.setTopId(categoryService.selectById(documentCategory.getPid()).getPid());
        documentCategoryService.add(documentCategory);
        return "redirect:/forum/documentCategory/list";
    }

    @RequiresPermissions("DocumentCategory:edit")
    @GetMapping("/edit/{id}")
    public String edit(@PathVariable Integer id,Model model){
        DocumentCategory documentCategory=documentCategoryService.selectById(id);
        model.addAttribute("documentCategory",documentCategory);
        model.addAttribute("id",id);
        return "admin/DocumentCategory/edit";
    }

    @RequiresPermissions("DocumentCategory:edit")
    @PostMapping("/edit")
    public String edit(DocumentCategory documentCategory){
        documentCategoryService.updateById(documentCategory);
        return "redirect:/forum/documentCategory/list";
    }

    @RequiresPermissions("DocumentCategory:delete")
    @GetMapping("/delete")
    @ResponseBody
    public Result delete(Integer id){
        documentCategoryService.delete(id);
        return success();
    }

    @RequiresPermissions("DocumentCategory:list")
    @GetMapping("/list")
    public String list(Model model,@RequestParam(defaultValue = "1")Integer pageNo){
        IPage<DocumentCategory> iPage=documentCategoryService.selectAllCategory(pageNo);
        List<DocumentCategory> documentCategoryList = iPage.getRecords();
        List<Categories> list = new LinkedList<>();
        for (int i=0;i<documentCategoryList.size();i++) {
            int pid = documentCategoryList.get(i).getPid();
            int id = documentCategoryList.get(i).getId();
            int topId=documentCategoryList.get(i).getTopId();
            String name = documentCategoryList.get(i).getName();
            Date time = documentCategoryList.get(i).getInTime();
            String topName=categoryService.selectById(topId).getName();
            String pName=categoryService.selectById(pid).getName();
            list.add(new Categories(id,name,time,pid,topName+"/"+pName));
        }
        model.addAttribute("category",list);
        model.addAttribute("page",iPage);
        return "admin/DocumentCategory/list";
    }





}
