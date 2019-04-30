package co.yiiu.pybbs.model;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;
import org.springframework.stereotype.Component;

import java.io.Serializable;
import java.util.Date;

@Data
@Component
public class Document implements Serializable {
    private static final long serialVersionUID = -8444058017995383187L;
    @TableId(type = IdType.AUTO)
    private Integer id;
    //文档类别 例如：明御
    private String documentClass;
    //文档种类 例如：安全网关
    private String documentType;
    //文档分类 例如 安装/配置/维护
    private String documentClassify;
    //文档名称
    private String documentName;
    private String code;
    private String fullpath;
    private String originName;
    private String url;
    private String path;
    private Date inTime;
}
