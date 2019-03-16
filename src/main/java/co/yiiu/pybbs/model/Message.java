package co.yiiu.pybbs.model;

import java.lang.reflect.Array;
import java.util.List;
import java.util.Set;

public class Message <T>
{
    private String code;
    private Array message;
    private Data data;

    public Array getMessage()
    {
        return message;
    }

    public void setMessage(Array message)
    {
        this.message = message;
    }

    public Data getData()
    {
        return data;
    }

    public void setData(Data data)
    {
        this.data = data;
    }

    public String getCode()
    {
        return code;
    }

    public void setCode(String code)
    {
        this.code = code;
    }




}
