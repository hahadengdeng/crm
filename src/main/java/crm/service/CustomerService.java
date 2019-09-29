package crm.service;

import crm.entity.Customer;

import java.util.List;

public interface CustomerService {
    public List<Customer> findAllCus();

    public int insertCus(Customer customer, Integer[] empids);

    public Customer findCusByCusName(String cusname);

    public int deleteCustomer(Integer cid);

    public List<Customer> findCusByCid(Integer cid);

    public Customer findCusByOp(Customer customer);

    public int modifyCus(Customer customer);

    public List<Customer> findAllCusNull();

    public List<Customer> selectCusByCom(Customer customer);

    public int comAddCustomer(Customer customer, String username);

    public List<Customer> findAllCusPage(Customer customer);

    //public List<Customer> findCusByOps(Customer customer);
}
