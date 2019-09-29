package crm.dao;

import java.util.List;

public interface ShiroMapper {
    public String selectPasswordByUserName(String username);
    public List<String> selectDeptByUserName(String username);
    public List<String> selectPermissionByUserName(String username);
}

