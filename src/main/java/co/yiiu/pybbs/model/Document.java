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
    private String code;
    private String fullpath;
    private String originName;
    private String url;
    private String path;
    private Date inTime;
    private String pdfUrl;
    private String pdfPath;
    private String pdfName;
    private Integer documentCategoryId;
    private String category;
}
