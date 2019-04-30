package co.yiiu.pybbs.mapper;

import co.yiiu.pybbs.model.DocumentLabel;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface DocumentLabelMapper extends BaseMapper<DocumentLabel> {
    void insertForEach(@Param("lists") List<DocumentLabel> list);

    void deleteLabelById(Integer id);
}
