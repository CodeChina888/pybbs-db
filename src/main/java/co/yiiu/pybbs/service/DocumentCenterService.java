package co.yiiu.pybbs.service;

import co.yiiu.pybbs.mapper.DocumentCenterMapper;
import co.yiiu.pybbs.model.Document;
import co.yiiu.pybbs.model.DocumentLabel;
import co.yiiu.pybbs.util.FileUtil;
import co.yiiu.pybbs.util.MyPage;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.util.Date;
import java.util.List;

@Service
@Transactional
public class DocumentCenterService {
    @Autowired
    private DocumentCenterMapper documentCenterMapper;
    @Autowired
    private SystemConfigService systemConfigService;
    @Autowired
    private FileUtil fileUtil;

    public void insert(Document document){
        document.setInTime(new Date());
        documentCenterMapper.insert(document);
    }

    public void delete(String code){
        if (documentCenterMapper.selectByCode(code)!=null) {
            fileUtil.removeFile(code);
            documentCenterMapper.delectByCode(code);
        }
    }

    public IPage<Document> selectAll(Integer pageNo) {
        MyPage<Document> page = new MyPage<>(pageNo,Integer.parseInt((String) systemConfigService.selectAllConfig().get("page_size")));
        QueryWrapper<Document> wrapper=new QueryWrapper<>();
        return documentCenterMapper.selectPage(page, wrapper);
    }

    public IPage<Document> selectAll(Integer pageNo,String name) {
        MyPage<Document> page = new MyPage<>(pageNo,Integer.parseInt((String) systemConfigService.selectAllConfig().get("page_size")));
        QueryWrapper<Document> wrapper=new QueryWrapper<>();
        if (!StringUtils.isEmpty(name)) {
            wrapper.lambda().like(Document::getOriginName,name);
            wrapper.orderByDesc("category");
        }
        return documentCenterMapper.selectPage(page, wrapper);
    }

    public Document selectByCode(String code){
        return documentCenterMapper.selectByCode(code);
    }

    public Integer selectIdByCode(String code){
        return documentCenterMapper.selectIdByCode(code);
    }

    public List<String> selectLabelByCode(String code){
        return documentCenterMapper.selectLabelByCode(code);
    }

    public void update(Document document){
        document.setInTime(new Date());
        documentCenterMapper.updateById(document);
    }

    public void deleteByCategoryId(Integer id){
        if (documentCenterMapper.selectByCategoryId(id)!=null) {
            this.delete(documentCenterMapper.selectByCategoryId(id).getCode());
        }
        documentCenterMapper.deleteByCategoryId(id);
    }
}
