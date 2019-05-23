package co.yiiu.pybbs.service;

import co.yiiu.pybbs.mapper.DocumentCategoryMapper;
import co.yiiu.pybbs.model.DocumentCategory;
import co.yiiu.pybbs.util.MyPage;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.util.Date;
import java.util.List;

@Transactional
@Service
public class DocumentCategoryService {
    @Autowired
    private DocumentCategoryMapper documentCategoryMapper;
    @Autowired
    private SystemConfigService systemConfigService;
    @Autowired
    private DocumentCenterService documentCenterService;
    @Autowired
    private SoftwareService softwareService;

    public void add(DocumentCategory documentCategory){
        documentCategory.setInTime(new Date());
        documentCategoryMapper.insert(documentCategory);
    }

    public DocumentCategory selectById(Integer id){
        return documentCategoryMapper.selectById(id);
    }

    public void updateById(DocumentCategory documentCategory){
        documentCategory.setInTime(new Date());
        documentCategoryMapper.updateById(documentCategory);
    }

    public List<DocumentCategory> selectByPid(Integer pid){
        QueryWrapper<DocumentCategory> wrapper=new QueryWrapper<>();
        wrapper.lambda().eq(DocumentCategory::getPid,pid);
        return documentCategoryMapper.selectList(wrapper);
    }


    public IPage<DocumentCategory> selectAllCategory(Integer pageNo, Integer pageSize, Integer pid) {
        IPage<DocumentCategory> iPage = new MyPage<>(pageNo, pageSize == null ? Integer.parseInt(systemConfigService.selectAllConfig().get("page_size").toString()) : pageSize);
        QueryWrapper<DocumentCategory> wrapper = new QueryWrapper<>();
        wrapper.eq("pid",pid);
        return documentCategoryMapper.selectPage(iPage, wrapper);
    }

    public IPage<DocumentCategory> selectAllCategory(Integer pageNo) {
        IPage<DocumentCategory> iPage = new MyPage<>(pageNo, Integer.parseInt(systemConfigService.selectAllConfig().get("page_size").toString()));
        return documentCategoryMapper.selectPage(iPage, null);
    }

    // 根据categoryId删除二级目录
    public void deleteByCategoryId(Integer CategoryId) {
        QueryWrapper<DocumentCategory> wrapper = new QueryWrapper<>();
        wrapper.lambda()
                .eq(DocumentCategory::getPid, CategoryId);
        documentCategoryMapper.delete(wrapper);
    }

    // 删除二级目录
    public void delete(Integer id){
        documentCategoryMapper.deleteById(id);
        documentCenterService.deleteByCategoryId(id);
        softwareService.deleteByCategoryId(id);
    }

    public List<DocumentCategory> selectAll(){
        QueryWrapper<DocumentCategory> wrapper=new QueryWrapper<>();
        return documentCategoryMapper.selectList(wrapper);
    }


}

