package co.yiiu.pybbs.service;



import co.yiiu.pybbs.mapper.PlateMapper;
import co.yiiu.pybbs.model.Plate;
import co.yiiu.pybbs.util.MyPage;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.util.List;


@Transactional
@Service
public class PlateServies
{     @Autowired
      private SystemConfigService systemConfigService;
      @Autowired
      private PlateMapper plateMapper;

    public IPage<Plate> selectAll(Integer pageNo, Integer pageSize, String fileName) {
        IPage<Plate> iPage = new MyPage<>(pageNo, pageSize == null ? Integer.parseInt(systemConfigService.selectAllConfig().get("page_size").toString()) : pageSize);
        QueryWrapper<Plate> wrapper = new QueryWrapper<>();
        // 当传进来的name不为null的时候，就根据name查询
        if (!StringUtils.isEmpty(fileName)) {
            wrapper.lambda().eq(Plate::getName, fileName);
        }
        wrapper.orderByDesc("in_time");
        return plateMapper.selectPage(iPage,wrapper);
    }

    public List<Plate> selectall(){
        QueryWrapper<Plate> wrapper = new QueryWrapper<>();
        wrapper.orderByDesc("in_time");
        return plateMapper.selectList(wrapper);
    }

}
