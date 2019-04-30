package co.yiiu.pybbs.service;

import co.yiiu.pybbs.mapper.SoftcategoryMapper;
import co.yiiu.pybbs.mapper.UploadFileMapper;
import co.yiiu.pybbs.model.SoftCategory;
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

@Transactional
@Service
public class UploadFileServies
{   @Autowired
    private UploadFileMapper uploadFileMapper;
    @Autowired
    private SystemConfigService systemConfigService;
    @Autowired
    private SoftcategoryMapper SoftCategoryMapper;
    @Autowired
    private FileLabelServise fileLabelServise;

    public void upload(String fileName, int size, String url, int categoryId, String version, String description,  String[] labels,String originName){
        System.out.println("jinlai");
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

    public void insertCategory(String name,String path,String description,int cgId,int layer){
        Date inTime =new Date();
        SoftCategory s=new SoftCategory();
        s.setInTime(inTime);
        s.setName(name);
        s.setPath(path);
        s.setDescription(description);
        s.setCgId(cgId);
        s.setLayer(layer+1);
        if (cgId==0){
            s.setHasSg(false);
        }else {
            SoftCategory SoftCategory =SoftCategoryMapper.selectById(cgId);
            SoftCategory.setHasSg(true);
            SoftCategoryMapper.updateById(SoftCategory);
            s.setHasSg(false);
        }

        SoftCategoryMapper.insert(s);
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
    public IPage<SoftCategory> selectAllCategory(Integer pageNo, Integer pageSize, String fileName,Integer cgId) {
        IPage<SoftCategory> iPage = new MyPage<>(pageNo, pageSize == null ? Integer.parseInt(systemConfigService.selectAllConfig().get("page_size").toString()) : pageSize);
        QueryWrapper<SoftCategory> wrapper = new QueryWrapper<>();
        // 当传进来的name不为null的时候，就根据name查询
        if (!StringUtils.isEmpty(fileName)) {
            wrapper.lambda().eq(SoftCategory::getName, fileName);
        }
        wrapper.eq("cg_id",cgId);
        return SoftCategoryMapper.selectPage(iPage, wrapper);
    }

    public SoftCategory selecSoftcategorytById(int id){
        SoftCategory SoftCategory=SoftCategoryMapper.selectById(id);
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



}
