package co.yiiu.pybbs.mapper;

import co.yiiu.pybbs.model.SoftwareLabel;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface SoftwareLabelMapper extends BaseMapper<SoftwareLabel>
{
    void deleteLabelById(Integer id);

    void insertForEach(@Param("lists") List<SoftwareLabel> list);
}
