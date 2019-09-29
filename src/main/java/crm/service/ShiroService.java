package crm.service;

import java.util.List;

public interface ShiroService {
    public String findPasswordByUserName(String username);
    public List<String> findDeptByUserName(String username);
    public List<String> findPermissionByUserName(String username);
}
