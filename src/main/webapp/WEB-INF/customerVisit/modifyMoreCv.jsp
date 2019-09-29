<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/9/25
  Time: 16:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<link href="css/bootstrap.min.css" rel="stylesheet">
<style>
    .error{
        color: red;
    }
</style>
<body>
<form id="form1">
    <table class="table table-bordered">
        <c:forEach items="${list}" var="l" varStatus="v">
            <tr>
                <td>
                    id:
                    <input type="text" value="${l.id}" readonly="readonly" id="customerVisits[${v.index}].id" name="id">
                </td>
                <td>
                    访问客户:
                    <select name="cid" id="customerVisits[${v.index}].customer.cid" name="cid">
                        <option value="${l.customer.cid}">${l.customer.cusname}</option>
                    </select>
                </td>
                <td>
                    接待人员:
                    <select name="empid" id="customerVisits[${v.index}].employees.empid" name="empid">
                        <option value="${l.employees.empid}">${l.employees.username}</option>
                    </select>
                </td>
                <td>
                    访问内容:
                    <input type="text" value="${l.content}" id="customerVisits[${v.index}].content" name="content">
                </td>
                <td>
                    拜访日期:
                    <input type="date" value="${l.date}"  name="date" id="customerVisits[${v.index}].date">
                </td>
                </div>
            </tr>
        </c:forEach>
        <tr>
            <td colspan="5"><button type="button"  style="margin-left: 47%" onclick="modifyMore()">确认修改</button></td>
        </tr>
    </table>
</form>
</body>
<script src="javascript/jQuery-1.12.4.js"></script>
<script src="javascript/bootstrap.js"></script>
<script src="javascript/jquery.validate.js"></script>
<script src="javascript/messages_zh.js"></script>

<script>
    $(function () {
        var $arr1 = $("select[name ='empid']");
        var $arr2 = $("select[name ='cid']");
        $.ajax({
            type: "get",
            url: "${pageContext.request.contextPath}/findAllEmp.action",
            contentType: "application/json;charset=utf-8",
            success: function (result) {
                for (var i = 0; i < $arr1.length; i++) {
                    for (var j = 0; j < result.length; j++) {
                        var a = "<option value='" + result[j].empid + "'>" + result[j].username + "</option>"
                        var b = $arr1[i].value;
                        if (b != result[j].empid) {
                            $($arr1[i]).append(a);
                        }
                    }
                }
            }
        });

        $.ajax({
            type: "get",
            url: "${pageContext.request.contextPath}/findAllCusNull.action",
            contentType: "application/json;charset=utf-8",
            success: function (result) {
                for (var i = 0; i < $arr2.length; i++) {
                    for (var j = 0; j < result.length; j++) {
                        var a = "<option value='" + result[j].cid + "'>" + result[j].cusname + "</option>"
                        var b = $arr2[i].value;
                        if (b != result[j].cid) {
                            $($arr2[i]).append(a);
                        }
                    }
                }
            }
        });
    });

    function modifyMore(){
        if($("#form1").valid()==true){
            var arrId=$("input[name='id']");
            var arrCid=$("select[name='cid']");
            var arrEmpid=$("select[name='empid']");
            var arrContent=$("input[name='content']");
            var arrDate=$("input[name='date']");
            for (var i=0;i<arrId.length;i++){
                $(arrId[i]).attr("name",$(arrId[i]).attr("id"));
                $(arrCid[i]).attr("name",$(arrCid[i]).attr("id"));
                $(arrEmpid[i]).attr("name",$(arrEmpid[i]).attr("id"));
                $(arrContent[i]).attr("name",$(arrContent[i]).attr("id"));
                $(arrDate[i]).attr("name",$(arrDate[i]).attr("id"));
            }
            $.ajax({
                type: "get",
                url: "${pageContext.request.contextPath}/modifyMoreCusVisit.action",
                contentType: "application/json;charset=utf-8",
                data:$("#form1").serialize(),
                success:function (msg) {
                    if (msg==1){
                        window.location.href="gotoManagerShowCvPage.action";
                    }
                }
            });

        }
    }


    $.validator.setDefaults({
        submitHandler: function (form) {
            form.submit();
        }
    });

    $().ready(function () {
        $("#form1").validate({
            debug: true,
            rules: {
                content: "required",
                date: "required"
            },
            messages: {
                content: {
                    required: "访问内容不能为空"
                },
                date: {
                    required: "日期不能为空"
                }
            }
        });
    });
</script>
</html>
