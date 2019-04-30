package co.yiiu.pybbs.mapper;

//import com.example.middleware.Model.File;
import co.yiiu.pybbs.model.Uploadfile;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface UploadFileMapper extends BaseMapper<Uploadfile>
{
     int Insert(Uploadfile u);
     int handleLabelRelation(@Param("fileId")int fileId,@Param("labelId")int labelId);
     int selectIdByName(@Param("fileName") String fileName);
     void deleteLabelRelation(@Param("fileId")int fileId);
}
