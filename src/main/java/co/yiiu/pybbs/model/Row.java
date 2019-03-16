package co.yiiu.pybbs.model;

public class Row
{
    private int id;
    private String username;
    private String nickname;
    private Object birthday;
    private int age;
    private String avatar;
    private String email;
    private String phone;
    private String qq;
    private String unit;
    private String sex;
    private int level;
    private int points;
    private String locales;
    private String auth;
    private String status;
    private int experience;
    private int consumablePoint;

    private Boolean hasPermission;

    public Boolean getHasPermission()
    {
        return hasPermission;
    }

    public void setHasPermission(Boolean hasPermission)
    {
        this.hasPermission = hasPermission;
    }

    public int getId()
    {
        return id;
    }

    public void setId(int id)
    {
        this.id = id;
    }

    public String getUsername()
    {
        return username;
    }

    public void setUsername(String username)
    {
        this.username = username;
    }

    public String getNickname()
    {
        return nickname;
    }

    public void setNickname(String nickname)
    {
        this.nickname = nickname;
    }



    public int getAge()
    {
        return age;
    }

    public Object getBirthday()
    {
        return birthday;
    }

    public void setBirthday(Object birthday)
    {
        this.birthday = birthday;
    }

    public void setAge(int age)
    {
        this.age = age;
    }

    public String getAvatar()
    {
        return avatar;
    }

    public void setAvatar(String avatar)
    {
        this.avatar = avatar;
    }

    public String getEmail()
    {
        return email;
    }

    public void setEmail(String email)
    {
        this.email = email;
    }

    public String getPhone()
    {
        return phone;
    }

    public void setPhone(String phone)
    {
        this.phone = phone;
    }

    public String getQq()
    {
        return qq;
    }

    public void setQq(String qq)
    {
        this.qq = qq;
    }

    public String getUnit()
    {
        return unit;
    }

    public void setUnit(String unit)
    {
        this.unit = unit;
    }

    public String getSex()
    {
        return sex;
    }

    public void setSex(String sex)
    {
        this.sex = sex;
    }

    public int getLevel()
    {
        return level;
    }

    public void setLevel(int level)
    {
        this.level = level;
    }

    public int getPoints()
    {
        return points;
    }

    public void setPoints(int points)
    {
        this.points = points;
    }

    public String getLocales()
    {
        return locales;
    }

    public void setLocales(String locales)
    {
        this.locales = locales;
    }

    public String getAuth()
    {
        return auth;
    }

    public void setAuth(String auth)
    {
        this.auth = auth;
    }

    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    public int getExperience()
    {
        return experience;
    }

    public void setExperience(int experience)
    {
        this.experience = experience;
    }

    public int getConsumablePoint()
    {
        return consumablePoint;
    }

    public void setConsumablePoint(int consumablePoint)
    {
        this.consumablePoint = consumablePoint;
    }

    public String getProfession()
    {
        return profession;
    }

    public void setProfession(String profession)
    {
        this.profession = profession;
    }

    public String getRealname()
    {
        return realname;
    }

    public void setRealname(String realname)
    {
        this.realname = realname;
    }

    private String profession;
    private String realname;

}
