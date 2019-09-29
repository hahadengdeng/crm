package crm.entity;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.HashMap;

public class CustomerVisit {
    private int id;

    @NotEmpty()
    private Customer customer;
    @NotEmpty()
    private Employees employees;
    @NotEmpty()
    private String date;
    @NotEmpty()
    private String content;

    //-------
    private HashMap<String,Integer> map;

    public HashMap<String, Integer> getMap() {
        return map;
    }

    public void setMap(HashMap<String, Integer> map) {
        this.map = map;
    }
    //--------------------------------------------
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Employees getEmployees() {
        return employees;
    }

    public void setEmployees(Employees employees) {
        this.employees = employees;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    @Override
    public String toString() {
        return "CustomerVisit{" +
                "id=" + id +
                ", customer=" + customer +
                ", employees=" + employees +
                ", date='" + date + '\'' +
                ", content='" + content + '\'' +
                '}';
    }

    public CustomerVisit(Customer customer) {
        this.customer = customer;
    }

    public CustomerVisit(Customer customer, Employees employees) {
        this.customer = customer;
        this.employees = employees;
    }

    public CustomerVisit() {
    }

    public CustomerVisit(Customer customer, Employees employees, String content) {
        this.customer = customer;
        this.employees = employees;
        this.content = content;
    }

    public CustomerVisit(int id, Customer customer, Employees employees, String content) {
        this.id = id;
        this.customer = customer;
        this.employees = employees;
        this.content = content;
    }
}
