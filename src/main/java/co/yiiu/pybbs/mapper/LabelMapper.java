package co.yiiu.pybbs.mapper;

import co.yiiu.pybbs.model.Label;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface LabelMapper extends BaseMapper<Label> {
    List<Label> selectAll();

    List selectBySoftId(@Param("softId") Integer softId);
}
