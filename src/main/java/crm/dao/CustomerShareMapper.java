package crm.dao;

import crm.entity.CustomerShare;

import java.util.List;

public interface CustomerShareMapper {
    public List<CustomerShare> checkDeleteEmp(Integer empid);
    public int insertMoreShare(List<CustomerShare> list);
    public int managerDeleteCs(Integer cid);
    public int modifyVs(List<CustomerShare> list);
    public List<CustomerShare> selectCvByCid(int cid);

}
