package co.yiiu.pybbs.service;

import co.yiiu.pybbs.mapper.SoftwareMapper;
import co.yiiu.pybbs.model.Software;
import co.yiiu.pybbs.util.FileUtil;
import co.yiiu.pybbs.util.MyPage;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Transactional
@Service
public class SoftwareService {
    @Autowired
    private SoftwareMapper softwareMapper;
    @Autowired
    private SystemConfigService systemConfigService;
    @Autowired
    private FileUtil fileUtil;

    public void insert(Software software){
        software.setInTime(new Date());
        softwareMapper.insert(software);
    }

    public void delete(String code){
        if (softwareMapper.selectByCode(code)!=null) {
            fileUtil.removeSoftware(code);
            softwareMapper.delectByCode(code);
        }
    }

    public IPage<Software> selectAll(Integer pageNo) {
        MyPage<Software> page = new MyPage<>(pageNo,Integer.parseInt((String) systemConfigService.selectAllConfig().get("page_size")));
        QueryWrapper<Software> wrapper=new QueryWrapper<>();
        return softwareMapper.selectPage(page, wrapper);
    }

    public IPage<Software> selectAll(Integer pageNo,String name) {
        MyPage<Software> page = new MyPage<>(pageNo,Integer.parseInt((String) systemConfigService.selectAllConfig().get("page_size")));
        QueryWrapper<Software> wrapper=new QueryWrapper<>();
        wrapper.lambda().like(Software::getOriginName,name);
        return softwareMapper.selectPage(page, wrapper);
    }


    public Software selectByCode(String code){
        return softwareMapper.selectByCode(code);
    }

    public List<String> selectLabelByCode(String code){
        return softwareMapper.selectLabelByCode(code);
    }

    public void update(Software document){
        document.setInTime(new Date());
        softwareMapper.updateById(document);
    }

    public void deleteByCategoryId(Integer id){
        if (softwareMapper.selectByCategoryId(id)!=null) {
            this.delete(softwareMapper.selectByCategoryId(id).getCode());
        }
        softwareMapper.deleteByCategoryId(id);

    }
}
