package com.whut_vaccine.domain;

public class Child {
    private int id;
    private String childname;
    private int parentid;
    private String statement;
    private String birthday;


    public Child() {
    }

    public Child(int id, String childname, int parentid, String statement, String birthday) {
        this.id = id;
        this.childname = childname;
        this.parentid = parentid;
        this.statement = statement;
        this.birthday = birthday;
    }


    /*此处说明statement疫苗接种情况规则：
        形如*A1_B1_C1,A2_B2_C2...
        A1,A2表示疫苗id
        B1,B2表示接种与否,1表示接种了,0表示未接种
        C1,C2表示接种时间，如未接种，则用0表示
        逗号为分隔符
        */
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getChildname() {
        return childname;
    }

    public void setChildname(String childname) {
        this.childname = childname;
    }

    public String getStatement() {
        return statement;
    }

    public void setStatement(String statement) {
        this.statement = statement;
    }

    public int getParentid() {

        return parentid;
    }

    public void setParentid(int parentid) {
        this.parentid = parentid;
    }
    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    @Override
    public String toString() {
        return "Child{" +
                "id=" + id +
                ", childname='" + childname + '\'' +
                ", parentid='" + parentid + '\'' +
                ", statement='" + statement + '\'' +
                ", birthday='" + birthday + '\'' +
                '}';
    }
}
