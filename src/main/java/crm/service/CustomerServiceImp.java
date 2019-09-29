package crm.service;

import crm.dao.CustomerMapper;
import crm.dao.CustomerShareMapper;
import crm.dao.CustomerVisitMapper;
import crm.dao.EmployeesMapper;
import crm.entity.Customer;
import crm.entity.CustomerShare;
import crm.entity.Employees;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service("customerService")
@Transactional(isolation = Isolation.DEFAULT, propagation = Propagation.REQUIRED, readOnly = false)
public class CustomerServiceImp implements CustomerService {

    @Autowired
    private CustomerMapper mapper;

    @Autowired
    private CustomerShareMapper customerShareMapper;

    @Autowired
    private CustomerVisitMapper customerVisitMapper;

    @Autowired
    private EmployeesMapper employeesMapper;

    @Override
    public List<Customer> findAllCus() {
        return mapper.selectAllCus();
    }

    /*   @Override
       public int insertCus(Customer customer) {
           return mapper.insertCus(customer);
       }
   */
    @Override
    public int insertCus(Customer customer, Integer[] empids) {
        Integer a = mapper.insertCus(customer);
        int cid = customer.getCid();
        List<CustomerShare> list = new ArrayList<CustomerShare>();
        for (int i : empids) {
            list.add(new CustomerShare(new Customer(cid), new Employees(i)));
        }
        Integer b = customerShareMapper.insertMoreShare(list);
        if (a != null && b != null) {
            return 1;
        } else {
            return 0;
        }
    }

    @Override
    public Customer findCusByCusName(String cusname) {
        return mapper.selectCusByCusName(cusname);
    }

    @Override
    public int deleteCustomer(Integer cid) {
        int a = customerVisitMapper.managerDeleteCv(cid);
        int b = customerShareMapper.managerDeleteCs(cid);
        int c = mapper.managerDeleteCus(cid);
        System.err.println(a+" "+b+" "+c);
        if (a >= 0 && b >= 0 && c >= 0) {
            return 1;
        } else {
            return 0;
        }
    }

    @Override
    public List<Customer> findCusByCid(Integer cid) {
        return mapper.selectCusByCid(cid);
    }

    @Override
    public Customer findCusByOp(Customer customer) {
        return mapper.selectCusByOp(customer);
    }

    @Override
    public int modifyCus(Customer customer) {
        return mapper.modifyCus(customer);
    }

    @Override
    public List<Customer> findAllCusNull() {
        return mapper.selectAllCusNull();
    }

    @Override
    public List<Customer> selectCusByCom(Customer customer) {
        return mapper.selectCusByCom(customer);
    }

    @Override
    public int comAddCustomer(Customer customer, String username) {
        mapper.insertCus(customer);
        int cid = customer.getCid();
        Employees e= employeesMapper.selectByUsername(new Employees(username));
        List<CustomerShare> list=new ArrayList<CustomerShare>();
        System.err.println(cid+" "+e);
        list.add(new CustomerShare(new Customer(cid),new Employees(e.getEmpid())));
        customerShareMapper.insertMoreShare(list);
        return 1;
    }

    @Override
    public List<Customer> findAllCusPage(Customer customer) {
        return mapper.selectAllCusPage(customer);
    }

   /* @Override
    public List<Customer> findCusByOps(Customer customer) {
        return mapper.selectCusByOps(customer);
    }*/
}
