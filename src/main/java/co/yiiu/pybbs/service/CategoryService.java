package co.yiiu.pybbs.service;

import co.yiiu.pybbs.mapper.CategoryMapper;
import co.yiiu.pybbs.model.Category;
import co.yiiu.pybbs.util.MyPage;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
@Transactional
public class CategoryService {
    @Autowired
    private CategoryMapper categoryMapper;
    @Autowired
    private DocumentCategoryService documentCategoryService;
    @Autowired
    private SystemConfigService systemConfigService;

    public void add(Category category){
        category.setInTime(new Date());
        categoryMapper.insert(category);
    }

    public void update(Category category){
        category.setInTime(new Date());
        categoryMapper.updateById(category);
    }

    public List<Category> selectByPid(Integer pid){
        QueryWrapper<Category> wrapper=new QueryWrapper<>();
        wrapper.lambda().eq(Category::getPid,pid);
        return categoryMapper.selectList(wrapper);
    }

    public Category selectById(Integer id){
        return categoryMapper.selectById(id);
    }

    // 删除关联的二级目录表
    public void delete(Integer id){
        Category category=categoryMapper.selectById(id);
        if (category.getPid()==0) {
            List<Category> list=this.selectByPid(category.getId());
            list.forEach(category1 -> {
                documentCategoryService.deleteByCategoryId(category1.getId());
                categoryMapper.deleteById(category1.getId());
            });
        } else {
            documentCategoryService.deleteByCategoryId(id);
        }
        categoryMapper.deleteById(id);
    }

    public List<Category> selectAll(){
        QueryWrapper<Category> wrapper =new QueryWrapper<>();
        return categoryMapper.selectList(wrapper);
    }

    public IPage<Category> selectAll(Integer pageNo) {
        MyPage<Category> page = new MyPage<>(pageNo,Integer.parseInt((String) systemConfigService.selectAllConfig().get("page_size")));
        return categoryMapper.selectPage(page, null);
    }

}
