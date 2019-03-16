package co.yiiu.pybbs.model;

public class Data
{
    private String jwtToken;

    public String getJwtToken()
    {
        return jwtToken;
    }

    public void setJwtToken(String jwtToken)
    {
        this.jwtToken = jwtToken;
    }

    public Row getRow()
    {
        return row;
    }

    public void setRow(Row row)
    {
        this.row = row;
    }

    private Row row;
}
