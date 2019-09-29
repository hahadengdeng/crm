package crm.service;

import crm.dao.ShiroMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service("shiroService")
@Transactional(isolation = Isolation.DEFAULT,propagation = Propagation.REQUIRED,readOnly = false)
public class ShiroServiceImp implements ShiroService{

    @Autowired
    private ShiroMapper mapper;

    @Override
    public String findPasswordByUserName(String username) {
        return mapper.selectPasswordByUserName(username);
    }

    @Override
    public List<String> findDeptByUserName(String username) {
        return mapper.selectDeptByUserName(username);
    }

    @Override
    public List<String> findPermissionByUserName(String username) {
        return mapper.selectPermissionByUserName(username);
    }
}
