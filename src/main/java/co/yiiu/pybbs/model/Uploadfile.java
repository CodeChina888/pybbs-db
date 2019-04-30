package co.yiiu.pybbs.model;

import org.springframework.stereotype.Component;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Component
public class Uploadfile implements Serializable
{
    private int id;
    private int categoryId;
    private String fileName;
    private int size;
    private String url;
    private Date inTime;
    private String description;
    private  String version;
    private int Grade;
    private String code;
    private String originName;

    public String getCode()
    {
        return code;
    }

    public void setCode(String code)
    {
        this.code = code;
    }

    public String getOriginName()
    {
        return originName;
    }

    public void setOriginName(String originName)
    {
        this.originName = originName;
    }

    public int getGrade()
    {
        return Grade;
    }

    public void setGrade(int grade)
    {
        Grade = grade;
    }

    public String getDescription()
    {
        return description;
    }

    public void setDescription(String description)
    {
        this.description = description;
    }

    public String getVersion()
    {
        return version;
    }

    public void setVersion(String version)
    {
        this.version = version;
    }

    public int getCategoryId()
    {
        return categoryId;
    }

    public void setCategoryId(int categoryId)
    {
        this.categoryId = categoryId;
    }

    public int getId()
    {
        return id;
    }

    public void setId(int id)
    {
        this.id = id;
    }

    public  String getFileName()
    {
        return fileName;
    }

    public void setFileName(String fileName)
    {
        this.fileName = fileName;
    }

    public int getSize()
    {
        return size;
    }

    public void setSize(int size)
    {
        this.size = size;
    }

    public String getUrl()
    {
        return url;
    }

    public void setUrl(String url)
    {
        this.url = url;
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
