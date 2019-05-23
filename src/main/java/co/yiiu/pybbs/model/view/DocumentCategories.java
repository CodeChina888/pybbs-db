package co.yiiu.pybbs.model.view;

import lombok.Data;
import org.springframework.stereotype.Component;

import java.io.Serializable;
import java.util.Date;

@Data
public class DocumentCategories implements Serializable
{
    private int id;
    private String name;
    private Date inTime;
    private int pid;
    private int topId;
    private String pName;

    public DocumentCategories(int id, String name, Date inTime, int pid, int topId, String pName) {
        this.id = id;
        this.name = name;
        this.inTime = inTime;
        this.pid = pid;
        this.topId = topId;
        this.pName = pName;
    }

    public DocumentCategories() {
    }
}
