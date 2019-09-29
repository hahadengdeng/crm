package crm.service;

import crm.entity.Employees;

import java.util.List;

public interface EmployeesService {
    void addEmployee();

    void updateEmployee();

    void removeEmployee();

    public Employees selectByUsername(Employees employees);

    public int register(Employees employees);

    public int modifyPassword(Employees employees);

    public List<Employees> findAllCommissioner(Employees employees);

    public Employees findEmpById(Integer empid);

    public Employees findModify(Employees employees);

    public int modifyCom(Employees employees);

    public int addCommissioner(Employees employees);

    public int deleteCom(Integer empid);

    public List<Employees> findAllEmp();

    public int insertManager(Employees employees);

    public List<Employees> findAllManager(Employees employees);

    public List<Employees> findEmpNotAdmin();

    public int modifyRole(Employees employees);

    public int resetPassword(Employees employees);
}
