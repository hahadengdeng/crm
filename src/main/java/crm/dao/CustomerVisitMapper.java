package crm.dao;


import crm.entity.Customer;
import crm.entity.CustomerVisit;
import crm.entity.QueryVo;

import java.util.List;

public interface CustomerVisitMapper {
    public List<CustomerVisit> selectAll();

    public List<CustomerVisit> checkDeleteEmp(Integer empid);

    public int managerDeleteCv(Integer cid);

    public CustomerVisit selectCvById(int id);

    public int modifyCsById(CustomerVisit customerVisit);

    public int addCustomerVisit(CustomerVisit customerVisit);

    public int deleteCusVisit(CustomerVisit customerVisit);

    public List<CustomerVisit> selectAllByCom(CustomerVisit customerVisit);

    public List<CustomerVisit> selectByOp(CustomerVisit customerVisit);

    public int deleteMoreCv(int id);

    public int updateMoreCustomerVisit(List<CustomerVisit> customerVisit);

    /*public List<CustomerVisit> selectByIds(QueryVo v);

    public List<CustomerVisit> selectByPage(CustomerVisit customerVisit);

    public int insertMoreCustomerVisit(List<CustomerVisit> customerVisit);

    public int updateMoreCustomerVisit(List<CustomerVisit> customerVisit);*/
}
