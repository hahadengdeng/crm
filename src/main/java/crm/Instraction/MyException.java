package crm.Instraction;

import org.apache.shiro.authz.AuthorizationException;
import org.springframework.validation.BindException;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class MyException implements HandlerExceptionResolver {
    @Override
    public ModelAndView resolveException(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) {
        ModelAndView mav=new ModelAndView();

        if (e instanceof AuthorizationException){
            mav.addObject("msg","权限不足");
        }else if (e instanceof IOException){
            mav.addObject("msg","错误");
        }else {
            mav.addObject("msg","未知异常");
        }

        mav.setViewName("../err.jsp");
        return mav;
    }
}
