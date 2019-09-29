package crm.service;

import crm.entity.Permission;

import java.util.List;

public interface PermissionService {
    public List<Permission> selectAllPerByMenu();
}
