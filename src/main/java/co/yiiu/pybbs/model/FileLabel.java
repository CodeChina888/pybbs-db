package co.yiiu.pybbs.model;


import org.springframework.stereotype.Component;

@Component
public class FileLabel
{
    private int id;
    private int fileId;
    private int labelId;

    public int getId()
    {
        return id;
    }

    public void setId(int id)
    {
        this.id = id;
    }

    public int getFileId()
    {
        return fileId;
    }

    public void setFileId(int fileId)
    {
        this.fileId = fileId;
    }

    public int getLabelId()
    {
        return labelId;
    }

    public void setLabelId(int labelId)
    {
        this.labelId = labelId;
    }
}
