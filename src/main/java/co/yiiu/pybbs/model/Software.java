package co.yiiu.pybbs.model;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;
import org.springframework.stereotype.Component;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Component
@Data
public class Software implements Serializable
{
    private static final long serialVersionUID = -8444058017995383187L;
    @TableId(type = IdType.AUTO)
    private Integer id;
    private Date inTime;
    private String url;
    private String path;
    private String code;
    private String fullpath;
    private String originName;
    private String category;
    private String version;
    private String description;
    private Integer softwareCategoryId;

}
