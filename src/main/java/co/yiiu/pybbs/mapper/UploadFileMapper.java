package co.yiiu.pybbs.mapper;

//import com.example.middleware.Model.File;
import co.yiiu.pybbs.model.Uploadfile;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UploadFileMapper extends BaseMapper<Uploadfile>
{
    //void insertMessage(@Param("fileName") String fileName, @Param("size") int size, @Param("url") String url,@Param("categoryId") int categoryId, @Param("inTime") Date inTime);
    //List<File> selectAllMessage();
}
