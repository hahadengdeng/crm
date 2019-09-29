import crm.dao.PermissionMapper;
import crm.entity.*;
import crm.service.*;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class test {

    @Autowired
    private EmployeesService serviceImp;

    @Test
    public void aaa() {
        serviceImp.modifyRole(new Employees(14,new Dept(1)));
    }
}
