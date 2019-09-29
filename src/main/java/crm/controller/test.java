package crm.controller;

import crm.entity.Customer;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.validation.Valid;
import java.util.List;

@Controller
public class test {

    @RequestMapping("/aaa")
    public void aaa(@Valid Customer customer, BindingResult result){
        if (result.hasErrors()){
            List<FieldError> list=result.getFieldErrors();
            for (FieldError f:list){
                System.err.println(f.getField()+" "+f.getDefaultMessage());
            }
        }else {
            System.err.println("-------------go---");
            System.err.println(customer);
        }
    }

    @RequestMapping("/toaaa")
    public String toaaa(){
        return "customer/test.jsp";
    }

}
