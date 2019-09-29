package crm.entity;

import crm.controller.First;
import crm.controller.Second;
import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.stereotype.Repository;
import javax.validation.constraints.Pattern;
import java.io.Serializable;
import java.util.List;

@Repository("employees")
public class Employees implements Serializable {
    private int empid;
    @NotEmpty(groups = {First.class})
    @Length(min = 2,message = "cusname长度不能小于2")
    private String username;
    @NotEmpty()
    private String password;
    @NotEmpty()
    @Pattern(regexp = "^[1][0-9]{10}$",message = "电话格式不正确")
    private String tel;
    @NotEmpty()
    private String name;

    @Email()
   // @NotEmpty(groups = First.class)
    private String email;
    private Dept dept;
    private boolean remember;

    public Employees(int empid, Dept dept) {
        this.empid = empid;
        this.dept = dept;
    }

    public Dept getDept() {
        return dept;
    }

    public void setDept(Dept dept) {
        this.dept = dept;
    }

    public boolean isRemember() {
        return remember;
    }

    public void setRemember(boolean remember) {
        this.remember = remember;
    }

    //-------------------
    private List<CustomerVisit> customerVisits;

    public List<CustomerVisit> getCustomerVisits() {
        return customerVisits;
    }

    public void setCustomerVisits(List<CustomerVisit> customerVisits) {
        this.customerVisits = customerVisits;
    }
    //--------------------

    public int getEmpid() {
        return empid;
    }

    public void setEmpid(int empid) {
        this.empid = empid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }


    @Override
    public String toString() {
        return "Employees{" +
                "empid=" + empid +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", tel='" + tel + '\'' +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", dept=" + dept +
                ", remember=" + remember +
                ", customerVisits=" + customerVisits +
                '}';
    }

    public Employees() {
    }

    public Employees(int empid, String username) {
        this.empid = empid;
        this.username = username;
    }

    public Employees(String username, String password) {
        this.username = username;
        this.password = password;
    }

    public Employees(int empid, String username, String password, String tel, String name, String email, Dept dept) {
        this.empid = empid;
        this.username = username;
        this.password = password;
        this.tel = tel;
        this.name = name;
        this.email = email;
        this.dept = dept;
    }

    public Employees(int empid) {
        this.empid = empid;
    }

    public Employees(String username) {
        this.username = username;
    }

}
