package crm.entity;

import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.List;

@Component("queryvo")
public class QueryVo {
    private List<Integer> ids;

    private List<Integer> empIds;

    private List<CustomerShare> customerShares;

    private List<CustomerVisit> customerVisits;

    public List<CustomerVisit> getCustomerVisits() {
        return customerVisits;
    }

    public void setCustomerVisits(List<CustomerVisit> customerVisits) {
        this.customerVisits = customerVisits;
    }

    public List<CustomerShare> getCustomerShares() {
        return customerShares;
    }

    public void setCustomerShares(List<CustomerShare> customerShares) {
        this.customerShares = customerShares;
    }

    public List<Integer> getEmpIds() {
        return empIds;
    }

    public void setEmpIds(List<Integer> empIds) {
        this.empIds = empIds;
    }

    private String[] arr;

    public QueryVo() {
        System.out.println("--------------");
    }

    public String[] getArr() {
        return arr;
    }

    public QueryVo(String[] arr) {
        this.arr = arr;
    }

    public void setArr(String[] arr) {
        this.arr = arr;
    }

    public List<Integer> getIds() {
        return ids;
    }

    public void setIds(List<Integer> ids) {
        this.ids = ids;
    }

    public QueryVo(List<Integer> ids) {
        this.ids = ids;
    }

    @Override
    public String toString() {
        return "QueryVo{" +
                "ids=" + ids +
                ", empIds=" + empIds +
                ", customerShares=" + customerShares +
                ", customerVisits=" + customerVisits +
                ", arr=" + Arrays.toString(arr) +
                '}';
    }
}
