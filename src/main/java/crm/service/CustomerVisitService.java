package crm.service;

import crm.entity.CustomerVisit;

import java.util.List;

public interface CustomerVisitService {
    public List<CustomerVisit> checkDeleteEmp(Integer empid);

    public List<CustomerVisit> findAllCV();

    public CustomerVisit findCvById(int id);

    public int modifyCsById(CustomerVisit customerVisit);

    public int addCustomerVisit(CustomerVisit customerVisit);

    public int deleteCusVisit(CustomerVisit customerVisit);

    public List<CustomerVisit> findAllByCom(CustomerVisit customerVisit);

    public List<CustomerVisit> findByOp(CustomerVisit customerVisit);

    public int deleteMoreCv(int[] ids);

    public List<CustomerVisit> readyModifyMore(int[] ids);

    public int modifyMoreCusVisit(List<CustomerVisit> list);

}
