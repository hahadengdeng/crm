package crm.dao;

import crm.entity.Permission;

import java.util.List;

public interface PermissionMapper {
    public List<Permission> selectAllPerByMenu();
}
