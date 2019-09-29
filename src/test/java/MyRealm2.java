import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.apache.shiro.mgt.DefaultSecurityManager;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.util.ByteSource;
import org.junit.Test;

import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.Set;

//自定义realm
public class MyRealm2 extends AuthorizingRealm {

    private HashMap<String,String> map=new HashMap<String, String>();

    public MyRealm2(){
        map.put("admin","81dc9bdb52d04dc20036dbd8313ed055");
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
        //加盐的地方
        /*info.setCredentialsSalt(ByteSource.Util.bytes("admin"));*/
        return info;
    }

    //测试
    @Test
    public void test(){
        MyRealm2 realm=new MyRealm2();
        DefaultSecurityManager manager=new DefaultSecurityManager();
        manager.setRealm(realm);
        //---设置加密的方式-------四个步骤-------
        HashedCredentialsMatcher matcher = new HashedCredentialsMatcher();
        matcher.setHashAlgorithmName("md5");//加密的方式
        matcher.setHashIterations(1);//加密的次数

        realm.setCredentialsMatcher(matcher);//把加密规则设到realm中
        //----------------------------------------------------

        SecurityUtils.setSecurityManager(manager);

        Subject subject = SecurityUtils.getSubject();

        UsernamePasswordToken token = new UsernamePasswordToken("admin", "1234");

        subject.login(token);

        subject.checkRole("admin");

        subject.checkPermissions("select","delete");

        System.out.println("---------end----------");
    }

    public static void main(String[] args) {
        //普通的加密
        String num="123";
        Md5Hash md5Hash = new Md5Hash(num);
        System.out.println(md5Hash);//81dc9bdb52d04dc20036dbd8313ed055
        //Md5Hash admin = new Md5Hash(num, "admin");//c93ccd78b2076528346216b3b2f701e6

    }
}
