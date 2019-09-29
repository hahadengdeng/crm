package crm.service;

import crm.entity.CustomerShare;

import java.util.List;

public interface CustomerShareService {
    public List<CustomerShare> checkDeleteEmp(Integer empid);

    public int insertMoreCus(List<CustomerShare> list);

    public Integer modifyCs(List<CustomerShare> list, Integer cid);

    public int shareCustomer(int[] empids,int cid);

    public int modifyVs(List<CustomerShare> list);

    public List<CustomerShare> findCvByCid(int cid);

}
