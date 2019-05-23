package co.yiiu.pybbs.model;

import lombok.Data;
import org.springframework.stereotype.Component;

import java.io.Serializable;
import java.util.Date;

@Data
@Component
public class Category implements Serializable
{
    private int id;
    private String name;
    private Date inTime;
    private int pid;
}
