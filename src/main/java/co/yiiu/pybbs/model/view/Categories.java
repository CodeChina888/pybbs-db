package co.yiiu.pybbs.model.view;

import lombok.Data;
import org.springframework.stereotype.Component;

import java.io.Serializable;
import java.util.Date;

/**
 * @author chenghongzhi
 */

@Data
public class Categories implements Serializable
{
    private int id;
    private String name;
    private Date inTime;
    private int pid;
    private String pName;

    public Categories(int id, String name, Date inTime, int pid, String pName) {
        this.id = id;
        this.name = name;
        this.inTime = inTime;
        this.pid = pid;
        this.pName = pName;
    }
}
