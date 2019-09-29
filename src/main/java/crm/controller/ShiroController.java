package crm.controller;


import crm.entity.Employees;
import crm.service.ShiroService;
import crm.service.ShiroServiceImp;
import crm.shiro.MyRealm;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.apache.shiro.mgt.DefaultSecurityManager;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Controller
public class ShiroController {

    @Resource(name = "shiroService")
    private ShiroService serviceImp;

    @RequestMapping(value = "/login",method = RequestMethod.GET)
    public String login()
    {
        return "login.jsp";
    }

    @RequestMapping(value = "/login",method = RequestMethod.POST)
    public String login(Employees employees)
    {
        DefaultSecurityManager manager = new DefaultSecurityManager();
        MyRealm realm = new MyRealm();
        manager.setRealm(realm);
        //---设置加密的方式-------四个步骤-------
        HashedCredentialsMatcher matcher = new HashedCredentialsMatcher();
        matcher.setHashAlgorithmName("md5");//加密的方式
        matcher.setHashIterations(1);//加密的次数
        realm.setCredentialsMatcher(matcher);//把加密规则设到realm中
        //----------------------------------------------------
        SecurityUtils.setSecurityManager(manager);
        Subject subject = SecurityUtils.getSubject();
        UsernamePasswordToken token=new UsernamePasswordToken(employees.getUsername(),employees.getPassword());


        try {
            //设置是否记住
            token.setRememberMe(employees.isRemember());
            subject.login(token);
        }catch (AuthenticationException e){
            System.err.println(e.getMessage());
            return "login.jsp";
        }

        return "redirect:getMainMenu.action";
    }

    @RequestMapping("/loginOut")
    public String loginOut(){
        Subject subject=SecurityUtils.getSubject();
        subject.logout();
        return "login.jsp";
    }

    @RequestMapping("/checkPassword")
    public void checkPassword(Employees employees, HttpServletResponse resp){
        Md5Hash md5Hash = new Md5Hash(employees.getPassword());
        String newpassword= md5Hash.toString();
        String password=serviceImp.findPasswordByUserName(employees.getUsername());
        if (password.equals(newpassword)){
            try {
                resp.getWriter().print("true");
            } catch (IOException e) {
                e.printStackTrace();
            }
        }else {
            try {
                resp.getWriter().print("false");
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}
