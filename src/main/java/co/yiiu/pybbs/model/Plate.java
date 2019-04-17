package co.yiiu.pybbs.model;

import org.springframework.stereotype.Component;

import java.util.Date;
@Component
public class Plate
{
    private int id;
    private String name;
    private Date inTime;

    public int getId()
    {
        return id;
    }

    public void setId(int id)
    {
        this.id = id;
    }

    public String getName()
    {
        return name;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public Date getInTime()
    {
        return inTime;
    }

    public void setInTime(Date inTime)
    {
        this.inTime = inTime;
    }


}
