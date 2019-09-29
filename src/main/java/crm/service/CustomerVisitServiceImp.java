package crm.service;

import crm.dao.CustomerMapper;
import crm.dao.CustomerVisitMapper;
import crm.entity.CustomerVisit;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
@Service("customerVisitService")
@Transactional(isolation = Isolation.DEFAULT,propagation = Propagation.REQUIRED,readOnly = false)
public class CustomerVisitServiceImp implements CustomerVisitService {

    @Autowired
    private CustomerVisitMapper mapper;

    @Override
    public List<CustomerVisit> checkDeleteEmp(Integer empid) {
        return mapper.checkDeleteEmp(empid);
    }

    @Override
    public List<CustomerVisit> findAllCV() {
        return mapper.selectAll();
    }

    @Override
    public CustomerVisit findCvById(int id) {
        return mapper.selectCvById(id);
    }

    @Override
    public int modifyCsById(CustomerVisit customerVisit) {
        return mapper.modifyCsById(customerVisit);
    }

    @Override
    public int addCustomerVisit(CustomerVisit customerVisit) {
        return mapper.addCustomerVisit(customerVisit);
    }

    @Override
    public int deleteCusVisit(CustomerVisit customerVisit) {
        return mapper.deleteCusVisit(customerVisit);
    }

    @Override
    public List<CustomerVisit> findAllByCom(CustomerVisit customerVisit) {
        return mapper.selectAllByCom(customerVisit);
    }

    @Override
    public List<CustomerVisit> findByOp(CustomerVisit customerVisit) {
        return mapper.selectByOp(customerVisit);
    }

    @Override
    public int deleteMoreCv(int[] ids) {
        for (int i=0;i<ids.length;i++){
            mapper.deleteMoreCv(ids[i]);
        }
        return 1;
    }

    @Override
    public List<CustomerVisit> readyModifyMore(int[] ids) {

        List<CustomerVisit> customerVisitList=new ArrayList<CustomerVisit>();
        for (int i=0;i<ids.length;i++){
           customerVisitList.add(mapper.selectCvById(ids[i]));

        }
        return customerVisitList;
    }

    @Override
    public int modifyMoreCusVisit(List<CustomerVisit> list) {
        mapper.updateMoreCustomerVisit(list);
        return 1;
    }
}
