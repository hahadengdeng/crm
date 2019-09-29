package crm.service;

import crm.dao.DeptMapper;
import crm.entity.Dept;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service("deptService")
@Transactional(isolation = Isolation.DEFAULT,propagation = Propagation.REQUIRED,readOnly = false)
public class DeptServiceImp implements DeptService{

    @Autowired
    private DeptMapper mapper;

    @Override
    public List<Dept> findAllDept() {
        return mapper.selectAllDept();
    }
}
