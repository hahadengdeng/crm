package crm.service;

import crm.dao.EmployeesMapper;
import crm.entity.Employees;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service("employeeService")
@Transactional(isolation = Isolation.DEFAULT, propagation = Propagation.REQUIRED, readOnly = false)
public class EmployeesServiceImp implements EmployeesService {

    @Autowired
    private EmployeesMapper mapper;

    @Override
    public void addEmployee() {
    }

    @Override
    public void updateEmployee() {
        System.err.println("update");
    }

    @Override
    public void removeEmployee() {
        System.err.println("delete");
    }

    @Override
    public Employees selectByUsername(Employees employees) {
        return mapper.selectByUsername(employees);
    }

    @Override
    public int register(Employees employees) {
        return mapper.register(employees);
    }

    @Override
    public int modifyPassword(Employees employees) {
        return mapper.modifyPassword(employees);
    }

    @Override
    public List<Employees> findAllCommissioner(Employees employees) {
        return mapper.selectAllCommissioner(employees);
    }

    @Override
    public Employees findEmpById(Integer empid) {
        return mapper.selectEmpById(empid);
    }

    @Override
    public Employees findModify(Employees employees) {
        return mapper.selectModify(employees);
    }

    @Override
    public int modifyCom(Employees employees) {
        return mapper.modifyCom(employees);
    }

    @Override
    public int addCommissioner(Employees employees) {
        return mapper.register(employees);
    }

    @Override
    public int deleteCom(Integer empid) {
        return mapper.deleteCom(empid);
    }

    @Override
    public List<Employees> findAllEmp() {
        return mapper.selectAllEmp();
    }

    @Override
    public int insertManager(Employees employees) {
        return mapper.register(employees);
    }

    @Override
    public List<Employees> findAllManager(Employees employees) {
        System.err.println(employees);
        return mapper.selectAllManager(employees);
    }

    @Override
    public List<Employees> findEmpNotAdmin() {
        return mapper.selectEmpNotAdmin();
    }

    @Override
    public int modifyRole(Employees employees) {
        return mapper.modifyRole(employees);
    }

    @Override
    public int resetPassword(Employees employees) {
        return mapper.resetPassword(employees);
    }
}
