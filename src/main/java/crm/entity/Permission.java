package crm.entity;

import java.util.List;

public class Permission {
    private int permissionid;
    private String pname;
    private String purl;
    private int ismenu;
    private int parentid;
    private String pinfo;
    private List<Permission> list;

    public List<Permission> getList() {
        return list;
    }

    public void setList(List<Permission> list) {
        this.list = list;
    }

    public int getPermissionid() {
        return permissionid;
    }

    public void setPermissionid(int permissionid) {
        this.permissionid = permissionid;
    }

    public String getPname() {
        return pname;
    }

    public void setPname(String pname) {
        this.pname = pname;
    }

    public String getPurl() {
        return purl;
    }

    public void setPurl(String purl) {
        this.purl = purl;
    }

    public int getIsmenu() {
        return ismenu;
    }

    public void setIsmenu(int ismenu) {
        this.ismenu = ismenu;
    }

    public int getParentid() {
        return parentid;
    }

    public void setParentid(int parentid) {
        this.parentid = parentid;
    }

    public String getPinfo() {
        return pinfo;
    }

    public void setPinfo(String pinfo) {
        this.pinfo = pinfo;
    }

    @Override
    public String toString() {
        return "Permission{" +
                "permissionid=" + permissionid +
                ", pname='" + pname + '\'' +
                ", purl='" + purl + '\'' +
                ", ismenu=" + ismenu +
                ", parentid=" + parentid +
                ", pinfo='" + pinfo + '\'' +
                ", list=" + list +
                '}';
    }

    public Permission() {
    }
}
