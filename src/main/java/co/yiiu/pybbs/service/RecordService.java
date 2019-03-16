package co.yiiu.pybbs.service;

import co.yiiu.pybbs.mapper.RecordMapper;
import co.yiiu.pybbs.model.Record;
import co.yiiu.pybbs.model.User;
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
public class RecordService {
    @Autowired
    private RecordMapper recordMapper;
    @Autowired
    private SystemConfigService systemConfigService;

    public void insert(Record record){
        record.setInTime(new Date());
        recordMapper.insert(record);
    }

    public List<Record> selectall(){
        QueryWrapper<Record> wrapper = new QueryWrapper<>();
//        wrapper.eq("admin_id", 0);
        return recordMapper.selectList(wrapper);
    }

    public IPage<Record> selectAll(Integer pageNo) {
        MyPage<Record> page = new MyPage<>(pageNo, Integer.parseInt((String) systemConfigService.selectAllConfig().get("page_size")));
        page.setAsc("id");
        return recordMapper.selectPage(page, null);
    }

}
