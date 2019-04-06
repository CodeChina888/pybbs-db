package co.yiiu.pybbs.service;

import co.yiiu.pybbs.mapper.DocumentCenterMapper;
import co.yiiu.pybbs.model.Document;
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
public class DocumentCenterService {
    @Autowired
    private DocumentCenterMapper documentCenterMapper;
    @Autowired
    private SystemConfigService systemConfigService;

    public void insert(Document document){
        document.setInTime(new Date());
        documentCenterMapper.insert(document);
    }
    public void delete(Integer id){
        if(documentCenterMapper.selectById(id).getId()!=null)
            documentCenterMapper.deleteById(id);
    }

    //查询所有
    public List<Document> selectall(){
        QueryWrapper<Document> wrapper=new QueryWrapper<>();
        wrapper.orderByAsc("document_class");
        return documentCenterMapper.selectList(wrapper);
    }

    public IPage<Document> selectAll(Integer pageNo) {
        MyPage<Document> page = new MyPage<>(pageNo,Integer.parseInt((String) systemConfigService.selectAllConfig().get("page_size")));
        page.setAsc("document_class");
        return documentCenterMapper.selectPage(page, new QueryWrapper<Document>().orderByAsc("document_class").orderByAsc("document_type"));
    }
}
