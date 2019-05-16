package co.yiiu.pybbs.service;

import co.yiiu.pybbs.mapper.SoftcategoryMapper;
import co.yiiu.pybbs.mapper.UploadFileMapper;
import co.yiiu.pybbs.model.Softcategory;
import co.yiiu.pybbs.model.Uploadfile;
import co.yiiu.pybbs.util.CodeUtil;
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
public class UploadFileServies
{   @Autowired
    private UploadFileMapper uploadFileMapper;
    @Autowired
    private SystemConfigService systemConfigService;
    @Autowired
    private SoftcategoryMapper softcategoryMapper;
    @Autowired
    private FileLabelServise fileLabelServise;

    public void upload(String fileName, int size, String url, int categoryId, String version, String description,  String[] labels,String originName){
        Date inTime=new Date();
        Uploadfile u=new Uploadfile();
        u.setCategoryId(categoryId);
        u.setDescription(description);
        u.setFileName(fileName);
        u.setInTime(inTime);
        u.setSize(size);
        u.setUrl(url);
        u.setVersion(version);
        u.setGrade(1);
        u.setOriginName(originName);
        u.setCode(CodeUtil.getShortAppCode());
        uploadFileMapper.Insert(u);
        for (int i=0;i<labels.length;i++){
            uploadFileMapper.handleLabelRelation(u.getId(),Integer.parseInt(labels[i]));
        }
    }

    public void insertCategory(String name,String description,int cgId,int layer){
        Date inTime =new Date();
        Softcategory s=new Softcategory();
        s.setInTime(inTime);
        s.setName(name);
        s.setDescription(description);
        s.setCgId(cgId);
        s.setLayer(layer+1);
        if (cgId==0){
            s.setPath(systemConfigService.selectByKey("upload_path").getValue()+name);
            s.setHasSg(false);
        }else {
            Softcategory SoftCategory =softcategoryMapper.selectById(cgId);
            SoftCategory.setHasSg(true);
            softcategoryMapper.updateById(SoftCategory);
            s.setHasSg(false);
            s.setPath(softcategoryMapper.selectById(cgId).getPath()+"/"+name);
        }

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
    public IPage<Softcategory> selectAllCategory(Integer pageNo, Integer pageSize, String fileName, Integer cgId) {
        IPage<Softcategory> iPage = new MyPage<>(pageNo, pageSize == null ? Integer.parseInt(systemConfigService.selectAllConfig().get("page_size").toString()) : pageSize);
        QueryWrapper<Softcategory> wrapper = new QueryWrapper<>();
        // 当传进来的name不为null的时候，就根据name查询
        if (!StringUtils.isEmpty(fileName)) {
            wrapper.lambda().eq(Softcategory::getName, fileName);
        }
        wrapper.eq("cg_id",cgId);
        return softcategoryMapper.selectPage(iPage, wrapper);
    }

    public Softcategory selecSoftcategorytById(int id){
        Softcategory SoftCategory=softcategoryMapper.selectById(id);
        return SoftCategory;
    }

    public Uploadfile selectuploadfileByCode(String code){
        QueryWrapper<Uploadfile> wrapper = new QueryWrapper<>();
        wrapper.eq("code",code);
        Uploadfile uploadfile=uploadFileMapper.selectOne(wrapper);
        return uploadfile;
    }

    public Uploadfile selectuploadfileById(int id){
        Uploadfile uploadfile=uploadFileMapper.selectById(id);
        return uploadfile;
    }

    public void deletefileById(int id){
        uploadFileMapper.deleteById(id);
        uploadFileMapper.deleteLabelRelation(id);
    }

    public void updateFile(Uploadfile u){
        Uploadfile uploadfile=uploadFileMapper.selectById(u.getId());
        uploadfile.setOriginName(u.getOriginName());
        uploadfile.setVersion(u.getVersion());
        uploadfile.setDescription(u.getDescription());
    }

    public void updateFile(Uploadfile u,String[] labels){
        uploadFileMapper.updateById(u);
        if (labels.length!=0)
        {
            fileLabelServise.delete(u.getId());
            for (int i = 0; i <labels.length; i++)
            {
                fileLabelServise.insert(u.getId(), Integer.parseInt(labels[i]));
            }
        }
    }

    public List<Softcategory> selectall(){
        QueryWrapper<Softcategory> wrapper = new QueryWrapper<>();
        wrapper.orderByDesc("id");
        return softcategoryMapper.selectList(wrapper);
    }

}
