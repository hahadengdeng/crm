package crm.shiro;

import crm.service.ShiroService;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.util.HashSet;
import java.util.Set;


//自定义realm
public class MyRealm extends AuthorizingRealm {

    private ShiroService ss;

    //授权
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        //1.得到用户名
        String username = (String) principalCollection.getPrimaryPrincipal();
        //2.根据用户名得到角色信息
        Set<String> roles = new HashSet<String>(ss.findDeptByUserName(username));
        //3.根据用户名得到权限信息
        Set<String> permissions = new HashSet<String>(ss.findPermissionByUserName(username));
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
        String password=ss.findPasswordByUserName(username);

        if (password==null){
            return null;
        }

        SimpleAuthenticationInfo info = new SimpleAuthenticationInfo(username, password, "myRealm");

        return info;
    }

    public ShiroService getSs() {
        return ss;
    }

    public void setSs(ShiroService ss) {
        this.ss = ss;
    }

    /*    //测试
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
    }*/
/*    @Test
    public void aa(){
        String a=ss.findPasswordByUserName("yyp");
        System.err.println(a);
    }*/
}
