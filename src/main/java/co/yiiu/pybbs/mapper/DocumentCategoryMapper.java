package co.yiiu.pybbs.mapper;

import co.yiiu.pybbs.model.DocumentCategory;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Component;

@Mapper
@Component
public interface DocumentCategoryMapper extends BaseMapper<DocumentCategory>
{

}
