package co.yiiu.pybbs.model;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

@Data
public class Label {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private String code;
    private String name;
}
