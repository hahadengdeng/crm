package crm.Instraction;

import crm.entity.Customer;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

@SuppressWarnings("deprecation")
@Component("myExcelView")
public class MyExcelView extends AbstractExcelView {

    @Override
    protected void buildExcelDocument(Map<String, Object> map, HSSFWorkbook hssfWorkbook, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws Exception {
        List<Customer> list=(List<Customer>)map.get("list");

        String fileName="客户信息.xls";

        httpServletResponse.setCharacterEncoding("utf-8");
        httpServletResponse.setContentType("application/ms-excel");
        httpServletResponse.setHeader("Content-Disposition","inline;fileName="+new String(fileName.getBytes(),"iso8859-1"));

        ServletOutputStream out=httpServletResponse.getOutputStream();
        HSSFSheet sheet= hssfWorkbook.createSheet();
        HSSFRow row=null;
        for (int i=0;i<list.size();i++){
            row=sheet.createRow(i);
            row.createCell(0).setCellValue(list.get(i).getCid());
            row.createCell(1).setCellValue(list.get(i).getCusname());
            row.createCell(2).setCellValue(list.get(i).getAddress());
            row.createCell(3).setCellValue(list.get(i).getContact());
            row.createCell(4).setCellValue(list.get(i).getEmail());
            row.createCell(5).setCellValue(list.get(i).getTel());
        }
        hssfWorkbook.write(out);
        hssfWorkbook.close();
        out.close();
    }
}
