package co.yiiu.pybbs.service;

import co.yiiu.pybbs.mapper.LabelMapper;
import co.yiiu.pybbs.model.Label;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
@Service
@Transactional
public class LabelService {
    @Autowired
    private LabelMapper labelMapper;

    public List<Label> selectall(){
        QueryWrapper<Label> wrapper = new QueryWrapper<>();
        wrapper.orderByDesc("id");
        return labelMapper.selectList(wrapper);
    }

    public List SelectAllBySoftId(Integer softId){
        return labelMapper.selectBySoftId(softId);
    }

    public List<Label> selectAll(){
        return labelMapper.selectAll();
    }
}
