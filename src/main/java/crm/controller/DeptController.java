package crm.controller;

import com.google.gson.Gson;
import crm.entity.Dept;
import crm.service.DeptService;
import crm.service.DeptServiceImp;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DeptController {

    @Autowired
    private DeptService service;

    @RequestMapping("/findAllDept")
    public @ResponseBody List<Dept> findAllDept(){
        return service.findAllDept();
    }
}
