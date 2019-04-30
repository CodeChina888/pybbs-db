package co.yiiu.pybbs.model;

import org.springframework.stereotype.Component;

import java.util.Date;
@Component
public class SoftCategory
{
    private int id;
    private String name;
    private String path;
    private Date inTime;
    private String description;
    private int cgId;
    private int layer;
    private boolean hasSg;

    public boolean isHasSg()
    {
        return hasSg;
    }

    public void setHasSg(boolean hasSg)
    {
        this.hasSg = hasSg;
    }

    public int getLayer()
    {
        return layer;
    }

    public void setLayer(int layer)
    {
        this.layer = layer;
    }

    public int getCgId()
    {
        return cgId;
    }

    public void setCgId(int cgId)
    {
        this.cgId = cgId;
    }

    public String getDescription()
    {
        return description;
    }

    public void setDescription(String description)
    {
        this.description = description;
    }

    public Date getInTime()
    {
        return inTime;
    }

    public void setInTime(Date inTime)
    {
        this.inTime = inTime;
    }

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

    public String getPath()
    {
        return path;
    }

    public void setPath(String path)
    {
        this.path = path;
    }
}
