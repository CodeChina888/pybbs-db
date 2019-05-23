package co.yiiu.pybbs.mapper;

import co.yiiu.pybbs.model.Document;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public interface DocumentCenterMapper extends BaseMapper<Document> {

    Document selectByCode(String code);

    List<String> selectLabelByCode(String code);

    void delectByCode(String code);

    Integer selectIdByCode(String code);

    void deleteByCategoryId(Integer id);

    Document selectByCategoryId(Integer id);
}
