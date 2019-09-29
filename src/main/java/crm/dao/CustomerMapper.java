package crm.dao;


import crm.entity.Customer;

import java.util.List;

public interface CustomerMapper {
    public List<Customer> selectAllCus();

    public int insertCus(Customer customer);

    public Customer selectCusByCusName(String cusname);

    public int managerDeleteCus(Integer cid);

    public List<Customer> selectCusByCid(Integer cid);

    public Customer selectCusByOp(Customer customer);

    public int modifyCus(Customer customer);

    public List<Customer> selectAllCusNull();

    public List<Customer> selectCusByCom(Customer customer);

    public List<Customer> selectAllCusPage(Customer customer);

    //public List<Customer> selectCusByOps(Customer customer);
}
