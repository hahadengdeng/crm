package crm.entity;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;

import javax.validation.constraints.Pattern;
import java.util.List;

public class Customer {

    private int cid;

    @NotEmpty(message = "cusname不能为空")
    @Length(min = 2,message = "cusname长度不能小于2")
    private String cusname;

    @NotEmpty(message = "address不能为空")
    private String address;

    @NotEmpty(message = "contact不能为空")
    private String contact;

    @NotEmpty(message = "tel能为空")
    @Pattern(regexp = "^[1][0-9]{10}$",message = "电话格式不正确")
    private String tel;

    @NotEmpty(message = "email能为空")
    @Email
    private String email;

    private String username;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    private List<Employees> employees;

    public List<Employees> getEmployees() {
        return employees;
    }

    public void setEmployees(List<Employees> employees) {
        this.employees = employees;
    }

    public Customer() {
    }

    public int getCid() {
        return cid;
    }

    public void setCid(int cid) {
        this.cid = cid;
    }

    public String getCusname() {
        return cusname;
    }

    public void setCusname(String cusname) {
        this.cusname = cusname;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Override
    public String toString() {
        return "Customer{" +
                "cid=" + cid +
                ", cusname='" + cusname + '\'' +
                ", address='" + address + '\'' +
                ", contact='" + contact + '\'' +
                ", tel='" + tel + '\'' +
                ", email='" + email + '\'' +
                ", employees=" + employees +
                '}';
    }

    public Customer(int cid) {
        this.cid = cid;
    }

    public Customer(int cid, String cusname, String address) {
        this.cid = cid;
        this.cusname = cusname;
        this.address = address;
    }

    public Customer(String cusname, String address, String contact, String tel, String email) {
        this.cusname = cusname;
        this.address = address;
        this.contact = contact;
        this.tel = tel;
        this.email = email;
    }
}
