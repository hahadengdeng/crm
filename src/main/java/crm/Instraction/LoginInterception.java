package crm.Instraction;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URL;

public class LoginInterception implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
        String loginName=(String) httpServletRequest.getSession().getAttribute("loginName");
        String uri=httpServletRequest.getRequestURI();
        if (uri.contains("login")||uri.contains("checkLoginName")|| uri.contains("register")){
           return true;
        }else{
            if (loginName!=null){
                return true;
            }else {
                httpServletResponse.sendRedirect(httpServletRequest.getContextPath()+"/login.action");
                return false;
            }
        }
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
