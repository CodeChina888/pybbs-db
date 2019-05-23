package co.yiiu.pybbs.model;

import co.yiiu.pybbs.model.view.DocumentCategories;
import lombok.Data;
import org.springframework.stereotype.Component;

import java.io.Serializable;
import java.util.Date;
@Data
@Component
public class DocumentCategory implements Serializable
{
    private int id;
    private String name;
    private Date inTime;
    private int pid;
    private int topId;
}
