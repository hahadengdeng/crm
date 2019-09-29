package crm.dao;



import com.github.pagehelper.Page;
import crm.entity.Employees;

import java.util.List;


public interface EmployeesMapper {
    public Employees login(Employees employees);

    public List<Employees> selectAllCommissioner(Employees employees);

    public Employees selectEmpById(Integer empid);

    public Employees selectByUsername(Employees employees);

    public int register(Employees employees);

    public int modifyPassword(Employees employees);

    public Employees selectModify(Employees employees);

    public int modifyCom(Employees employees);

    public int deleteCom(Integer empid);

    public List<Employees> selectAllEmp();

    public List<Employees> selectAllManager(Employees employees);

    public List<Employees> selectEmpNotAdmin();

    public int modifyRole(Employees employees);

    public int resetPassword(Employees employees);


}
