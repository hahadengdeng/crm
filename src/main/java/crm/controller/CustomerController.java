package crm.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import crm.entity.Customer;
import crm.entity.bootstrapPage;
import crm.service.CustomerService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;

@Controller
public class CustomerController {

    @Autowired
    private CustomerService service;

    @RequiresPermissions("customer:selectbymanager")
    @RequestMapping("/findAllCus")
    public String findAllCus(Model model) {
        List<Customer> list = service.findAllCus();
        model.addAttribute("list", list);
        return "customer/showAllCus.jsp";
    }

   /* @RequestMapping("/insertCustomer")
    public String insertCustomer(Customer customer,Integer[] empids){
        service.insertCus(customer);
        int cid=customer.getCid();
        List<CustomerShare> list=new ArrayList<CustomerShare>();
        for (int i:empids){
            list.add(new CustomerShare(new Customer(cid),new Employees(i)));
        }
        shareService.insertMoreCus(list);
        return "redirect:/findAllCus.action";
    }*/

    @RequiresPermissions("customer:insertbymanager")
    @RequestMapping("/insertCustomer")
    public String insertCustomer(@Valid Customer customer, Integer[] empids) {
        service.insertCus(customer, empids);
        return "redirect:/findAllCus.action";
    }

    //表单验证
    @RequestMapping("/findCusByName")
    public @ResponseBody
    boolean findCusByName(String cusname) {
        Customer customer = service.findCusByCusName(cusname);
        if (customer != null) {
            return false;
        } else {
            return true;
        }
    }

    @RequiresPermissions("customer:delete")
    @RequestMapping("/deleteCustomer")
    public @ResponseBody
    boolean deleteCustomer(Integer cid) {
        if (service.deleteCustomer(cid) == 1) {
            return true;
        } else {
            return false;
        }
    }

    @RequiresPermissions("customer:managerupdate")
    @RequestMapping("/findCusByCid")
    public String findCusByCid(int cid, Model model) {
        List<Customer> list = service.findCusByCid(cid);
        model.addAttribute("list", list);
        return "customer/modifyCustomer.jsp";
    }


    //*********************************************************
    @RequestMapping("/findCusByCidModel")
    public @ResponseBody
    List<Customer> findCusByCid(int cid) {
        List<Customer> list = service.findCusByCid(cid);
        return list;
    }

    //*********************************************************
    @RequestMapping("/findCusByOp")
    public @ResponseBody
    boolean findCusByOp(Customer customer) {
        Customer c = service.findCusByOp(customer);
        if (c == null) {
            return true;
        } else {
            return false;
        }
    }

    @RequiresPermissions("customer:update")
    @RequestMapping("/modifyCus")
    public @ResponseBody
    int modifyCus(@Valid Customer customer) {
        int a = service.modifyCus(customer);
        if (a >= 0) {
            return 1;
        } else {
            return 0;
        }
    }

    @RequiresPermissions("customer:pagebymanager")
    @RequestMapping("/findCustomerByPage")
    public @ResponseBody
    bootstrapPage<Customer> findCustomerByPage(int offset, int limit,Customer customer) {

        PageHelper.offsetPage(offset, limit);
        List<Customer> list = service.findAllCusPage(customer);
        PageInfo<Customer> page = new PageInfo<Customer>(list);

        bootstrapPage<Customer> bootPage = new bootstrapPage<Customer>();
        bootPage.setTotal((int) page.getTotal());
        bootPage.setRows(page.getList());

        return bootPage;
    }

    //************************************************
    @RequestMapping("/findAllCusNull")
    public @ResponseBody
    List<Customer> findAllCusNull() {
        List<Customer> list = service.findAllCusNull();
        return list;
    }

    @RequiresPermissions("customer:selectbycom")
    @RequestMapping("findCusByCom")
    public String findCusByCom(Customer cus, Model model) {
        List<Customer> list = service.selectCusByCom(cus);
        model.addAttribute("list", list);
        return "customer/showByCom.jsp";
    }

    @RequiresPermissions("customer:insertbycom")
    @RequestMapping("/comAddCustomer")
    public @ResponseBody
    int comAddCustomer(@Valid Customer customer, String username) {
        service.comAddCustomer(customer, username);
        return 1;
    }

    @RequiresPermissions("customer:updatecsbycom")
    @RequestMapping("/comFindCusByCid")
    public String comFindCusByCid(int cid, Model model) {
        List<Customer> list = service.findCusByCid(cid);
        model.addAttribute("list", list);
        return "customerShare/comShareCus.jsp";
    }

    //文件下载
    @RequestMapping("/oneKeyLoad")
    public ModelAndView oneKeyLoad(Map<String, Object> map) {
        ModelAndView mav = new ModelAndView();

        List<Customer> list = service.findAllCusNull();

        map.put("list", list);

        mav.addObject("map", map);
        mav.setViewName("myExcelView");
        return mav;
    }

    @RequiresPermissions("customer:pagebycom")
    @RequestMapping("/comShowCusByPage")
    public @ResponseBody
    bootstrapPage<Customer> comShowCusByPage(int offset, int limit, Customer customer) {
        PageHelper.offsetPage(offset, limit);
        List<Customer> list = service.selectCusByCom(customer);

        PageInfo<Customer> page = new PageInfo<Customer>(list);

        bootstrapPage<Customer> bootPage = new bootstrapPage<Customer>();
        bootPage.setTotal((int) page.getTotal());
        bootPage.setRows(page.getList());
        return bootPage;
    }

    /*纯页面跳转*/
    @RequiresPermissions("customer:insertbymanager")
    @RequestMapping("/toAdd")
    public String toAdd() {
        return "customer/addCustomer.jsp";
    }


    @RequestMapping("/toShow")
    public String toShow() {
        return "redirect:/findAllCus.action";
    }

    @RequiresPermissions("customer:pagebymanager")
    @RequestMapping("/toShowCusByPage")
    public String toPage() {
        return "customer/showCusByPage.jsp";
    }

    @RequiresPermissions("customer:insertbycom")
    @RequestMapping("/toComAddCus")
    public String toComAddCus() {
        return "customer/comAddCustomer.jsp";
    }

    @RequiresPermissions("customer:pagebycom")
    @RequestMapping("/toComShowByPage")
    public String toComShowByPage() {
        return "customer/comShowByPage.jsp";
    }
}
