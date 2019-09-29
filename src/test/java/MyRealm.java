import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.mgt.DefaultSecurityManager;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.Subject;
import org.junit.Test;

import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.Set;

//自定义realm
public class MyRealm extends AuthorizingRealm {

    private HashMap<String,String> map=new HashMap<String, String>();

    public MyRealm(){
        map.put("admin","1234");
        map.put("lili","1234");
        super.setName("myRealm");
    }

    //模拟数据库得到角色信息
    public Set<String> get1(String username){
        LinkedHashSet<String> set= new LinkedHashSet<String>();
        set.add("admin");
        return set;
    }

    //模拟从数据库得到密码
    public String get3(String username){
        return map.get(username);
    }

    //模拟数据库得到权限信息
    public Set<String> get2(String username){
        LinkedHashSet<String> set= new LinkedHashSet<String>();
        set.add("select");
        set.add("delete");
        set.add("insert");
        return set;
    }

    //授权
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        //1.得到用户名
        String username = (String) principalCollection.getPrimaryPrincipal();
        //2.根据用户名得到角色信息
        Set<String> roles = get1(username);
        //3.根据用户名得到权限信息
        Set<String> permissions = get2(username);
        //4.设置权限和角色
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
        info.setRoles(roles);
        info.setStringPermissions(permissions);
        return info;
    }

    //认证
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {

        //1.从主体传过来的token拿到认证信息
        String username=(String) authenticationToken.getPrincipal();
        //2.通过用户名，从数据库得到凭证
        String password=get3(username);

        if (password==null){
            return null;
        }

        SimpleAuthenticationInfo info = new SimpleAuthenticationInfo(username, password, "myRealm");

        return info;
    }

    //测试
    @Test
    public void test(){
        MyRealm realm=new MyRealm();
        DefaultSecurityManager manager=new DefaultSecurityManager();
        manager.setRealm(realm);
        SecurityUtils.setSecurityManager(manager);

        Subject subject = SecurityUtils.getSubject();

        UsernamePasswordToken token = new UsernamePasswordToken("admin", "1234");

        subject.login(token);

        subject.checkRole("admin");

        subject.checkPermissions("select","delete");

        System.out.println("---------end----------");
    }
}
