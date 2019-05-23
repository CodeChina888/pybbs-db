package co.yiiu.pybbs.mapper;
import co.yiiu.pybbs.model.Software;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface SoftwareMapper extends BaseMapper<Software>
{
    Software selectByCode(String code);

    List<String> selectLabelByCode(String code);

    void delectByCode(String code);

    void deleteByCategoryId(Integer id);

    Software selectByCategoryId(Integer id);
}
