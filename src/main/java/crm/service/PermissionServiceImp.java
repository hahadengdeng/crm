package crm.service;

import crm.dao.PermissionMapper;
import crm.entity.Permission;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("permissionService")
public class PermissionServiceImp implements PermissionService {

    @Autowired
    private PermissionMapper mapper;

    @Override
    public List<Permission> selectAllPerByMenu() {
        List<Permission> list=mapper.selectAllPerByMenu();
        return list;
    }
}
