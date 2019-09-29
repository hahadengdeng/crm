package crm.entity;

public class Dept {
    private int deptid;
    private String deptname;
    private String deptinfo;

    public int getDeptid() {
        return deptid;
    }

    public void setDeptid(int deptid) {
        this.deptid = deptid;
    }

    public String getDeptname() {
        return deptname;
    }

    public void setDeptname(String deptname) {
        this.deptname = deptname;
    }

    public String getDeptinfo() {
        return deptinfo;
    }

    public void setDeptinfo(String deptinfo) {
        this.deptinfo = deptinfo;
    }

    public Dept(int deptid) {
        this.deptid = deptid;
    }

    public Dept() {
    }

    @Override
    public String toString() {
        return "Dept{" +
                "deptid=" + deptid +
                ", deptname='" + deptname + '\'' +
                ", deptinfo='" + deptinfo + '\'' +
                '}';
    }
}
