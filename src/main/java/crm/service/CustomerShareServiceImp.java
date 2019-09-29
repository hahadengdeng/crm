package crm.service;

import crm.dao.CustomerShareMapper;
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

@Service("customerShareService")
@Transactional(isolation = Isolation.DEFAULT,propagation = Propagation.REQUIRED,readOnly = false)
public class CustomerShareServiceImp implements CustomerShareService{

    @Autowired
    private CustomerShareMapper mapper;

    @Override
    public List<CustomerShare> checkDeleteEmp(Integer empid) {
        List<CustomerShare> shareList=mapper.checkDeleteEmp(empid);
        return shareList;
    }

    @Override
    public int insertMoreCus(List<CustomerShare> list) {
        return mapper.insertMoreShare(list);
    }

    @Override
    public Integer modifyCs(List<CustomerShare> list, Integer cid) {
        Integer a=mapper.managerDeleteCs(cid);
        Integer b= mapper.insertMoreShare(list);
        if (a!=null&&b!=null){
            return 1;
        }else {
            return 0;
        }
    }

    @Override
    public int shareCustomer(int[] empids, int cid) {
        List<CustomerShare> list=new ArrayList<CustomerShare>();
        for (int i=0;i<empids.length;i++){
            list.add(new CustomerShare(new Customer(cid),new Employees(empids[i])));
        }
        return mapper.insertMoreShare(list);
    }

    @Override
    public int modifyVs(List<CustomerShare> list) {
        return mapper.modifyVs(list);
    }

    @Override
    public List<CustomerShare> findCvByCid(int cid) {
        return mapper.selectCvByCid(cid);
    }
}
