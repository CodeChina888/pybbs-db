package co.yiiu.pybbs.service;

import co.yiiu.pybbs.mapper.UploadFileMapper;
import co.yiiu.pybbs.mapper.SoftcategoryMapper;
import co.yiiu.pybbs.model.Softcategory;
import co.yiiu.pybbs.model.Uploadfile;
import co.yiiu.pybbs.util.MyPage;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.util.Date;

@Transactional
@Service
public class UploadFileServies
{   @Autowired
    private UploadFileMapper uploadFileMapper;
    @Autowired
    private SystemConfigService systemConfigService;
    @Autowired
    private SoftcategoryMapper softcategoryMapper;

    public void upload(String fileName,int size,String url,int categoryId,String version,String description){
        Date inTime=new Date();
        Uploadfile u=new Uploadfile();
        u.setCategoryId(categoryId);
        u.setDescription(description);
        u.setFileName(fileName);
        u.setInTime(inTime);
        u.setSize(size);
        u.setUrl(url);
        u.setVersion(version);
        uploadFileMapper.insert(u);
    }

    public void insertCategory(String name,String path,String description){
        Date inTime=new Date();
        Softcategory s=new Softcategory();
        s.setInTime(inTime);
        s.setName(name);
        s.setPath(path);
        s.setDescription(description);
        softcategoryMapper.insert(s);
    }

    public IPage<Uploadfile> selectAllSoftware(Integer pageNo, Integer pageSize, String fileName, int categoryId) {
        IPage<Uploadfile> iPage = new MyPage<>(pageNo, pageSize == null ? Integer.parseInt(systemConfigService.selectAllConfig().get("page_size").toString()) : pageSize);
        QueryWrapper<Uploadfile> wrapper = new QueryWrapper<>();
        // 当传进来的name不为null的时候，就根据name查询
        if (!StringUtils.isEmpty(fileName)) {
            wrapper.lambda().eq(Uploadfile::getFileName, fileName);
        }
        wrapper.eq("category_id", categoryId);
        return uploadFileMapper.selectPage(iPage, wrapper);
    }
    public IPage<Softcategory> selectAllCategory(Integer pageNo, Integer pageSize, String fileName) {
        IPage<Softcategory> iPage = new MyPage<>(pageNo, pageSize == null ? Integer.parseInt(systemConfigService.selectAllConfig().get("page_size").toString()) : pageSize);
        QueryWrapper<Softcategory> wrapper = new QueryWrapper<>();
        // 当传进来的name不为null的时候，就根据name查询
        if (!StringUtils.isEmpty(fileName)) {
            wrapper.lambda().eq(Softcategory::getName, fileName);
        }
        wrapper.orderByDesc("in_time");
        return softcategoryMapper.selectPage(iPage, wrapper);
    }

    public Softcategory selecSoftcategorytById(int id){
        Softcategory softcategory=softcategoryMapper.selectById(id);
        return softcategory;
    }

    public Uploadfile selectuploadfileById(int id){
        Uploadfile uploadfile=uploadFileMapper.selectById(id);
        return uploadfile;
    }



}
