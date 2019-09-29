package crm.controller;

import crm.entity.Permission;
import crm.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
public class MenuController {

    @Autowired
    private PermissionService service;

    @RequestMapping("/getMainMenu")
    public String getMainMenu(Model model){

        List<Permission> list=service.selectAllPerByMenu();
        model.addAttribute("list",list);

        return "main.jsp";
    }
}
