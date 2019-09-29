package crm.controller;

import crm.entity.Customer;
import crm.entity.CustomerShare;
import crm.entity.Employees;
import crm.entity.QueryVo;
import crm.service.CustomerShareService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

@Controller
public class CustomerShareController {

    @Autowired
    private CustomerShareService service;

    //表单验证
    @RequestMapping("checkDeleteEmp")
    public @ResponseBody
    List<CustomerShare> checkDeleteEmp(Integer empid) {
        List<CustomerShare> list = service.checkDeleteEmp(empid);
        return list;
    }

    @RequiresPermissions("customer:updatecsbymanager")
    @RequestMapping("/modifyCs")
    public @ResponseBody
    int modifyCs(int[] empids, Integer cid) {
        List<CustomerShare> list = new ArrayList<CustomerShare>();
        for (int i : empids) {
            list.add(new CustomerShare(new Customer(cid), new Employees(i)));
        }
        Integer result = service.modifyCs(list, cid);
        if (result == 1) {
            return 1;
        } else {
            return 0;
        }
    }

    @RequiresPermissions("customer:share")
    @RequestMapping("/shareCustomer")
    public @ResponseBody
    int shareCustomer(int[] empids, int cid) {
        service.shareCustomer(empids, cid);
        return 1;
    }


    @RequiresPermissions("customer:tran")
    @RequestMapping("/customerTran")
    public String customerTran(int cid, Model model) {
        List<CustomerShare> list = service.findCvByCid(cid);
        model.addAttribute("list", list);
        return "customerShare/customerTran.jsp";
    }

    @RequiresPermissions("customer:tran")
    @RequestMapping("/tranCs")
    public @ResponseBody
    int tranCs(QueryVo q) {
        List<CustomerShare> list = new ArrayList<CustomerShare>();
        list = q.getCustomerShares();
        service.modifyVs(list);
        return 1;
    }


    @RequiresPermissions("customershare:select")
    @RequestMapping("/customerTranModel")
    public @ResponseBody
    List<CustomerShare> customerTranModel(int cid) {
        List<CustomerShare> list = service.findCvByCid(cid);
        return list;
    }
}
