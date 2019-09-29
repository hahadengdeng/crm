<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/9/19
  Time: 18:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<style>
    .error {
        color: red;
    }
</style>
<link href="css/bootstrap.min.css" rel="stylesheet">
<body>
<table class="table table-striped">
    <tr>
        <td colspan="7">
            <center>此处修改基本信息</center>
        </td>
    </tr>
    <tr>
        <td hidden>客户id</td>
        <td>客户名</td>
        <td>客户地址</td>
        <td>联系人</td>
        <td>客户电话</td>
        <td>客户邮箱</td>
    </tr>

        <tr>
            <td hidden id="cid">${list[0].customer.cid}</td>
            <td>${list[0].customer.cusname}</td>
            <td>${list[0].customer.address}</td>
            <td>${list[0].customer.contact}</td>
            <td>${list[0].customer.tel}</td>
            <td>${list[0].customer.email}</td>
        </tr>

</table>
<form id="empForm" method="post">
    <table class="table table-striped" id="tab2">
        <tr>
            <td colspan="2">
                <center>此处转移对应的专员</center>
            </td>
        </tr>
        <c:forEach items="${list}" var="c" varStatus="v">
            <tr>
                <td hidden><input type="text" value="${list[0].customer.cid}" name="customerShares[${v.index}].customer.cid"></td>
                <td hidden><input type="text" value="${c.id}" name="customerShares[${v.index}].id"></td>
                <td>
                    <select name="customerShares[${v.index}].employees.empid" style="width: 100%;" id="empids">
                        <option value="${c.employees.empid}" selected>${c.employees.username}</option>
                    </select>
                </td>
            </tr>
        </c:forEach>
        <tr>
            <td><a id="updateMore" class="btn btn-default">确认修改负责专员</a></td>
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
        var $arr = $("select[id ='empids']");

        $.ajax({
            type: "get",
            url: "${pageContext.request.contextPath}/findAllEmp.action",
            contentType: "application/json;charset=utf-8",
            success: function (result) {
                for (var i = 0; i < $arr.length; i++) {
                    for (var j = 0; j < result.length; j++) {
                        var a = "<option value='" + result[j].empid + "'>" + result[j].username + "</option>"
                        var b = $arr[i].value;
                        if (b != result[j].empid) {
                            $($arr[i]).append(a);
                        }
                    }
                }
            }
        });
    });


    function partern() {
        var arr = $("select[id ='empids']");
        for (var i = 0; i < arr.length - 1; i++) {
            for (var j = i + 1; j < arr.length; j++) {
                if (arr[i].value == arr[j].value) {
                    return false;
                }
            }
        }
        return true;
    }

    $("#updateMore").click(function () {
        var a = partern();
        if (a == true) {
            var cid = $("#cid").html();
            $.ajax({
                type: "post",
                url: "${pageContext.request.contextPath}/tranCs.action",
                data: $("#empForm").serialize(),
                success: function (msg) {
                    if (msg == 1) {
                        var a = confirm("是否留在本页");
                        if (a == true) {
                            window.location.href = "${pageContext.request.contextPath}/customerTran.action?cid=" + cid + ""
                        } else {
                            window.location.href = "${pageContext.request.contextPath}/findAllCus.action"
                        }
                    }
                }
            });
        } else {
            alert("无法将该客户指定给同一专员");
        }
    })

    //表单验证


    function subCus() {
        var cid = $("#cid").val();
        if ($("#cusForm").valid() == true) {
            $.ajax({
                type: "post",
                url: "${pageContext.request.contextPath}/modifyCus.action",
                data: $("#cusForm").serialize(),
                success: function (msg) {
                    if (msg == 1) {
                        var a = confirm("是否留在本页");
                        if (a == true) {
                            window.location.href = "${pageContext.request.contextPath}/findCusByCid.action?cid=" + cid + ""
                        } else {
                            window.location.href = "${pageContext.request.contextPath}/findAllCus.action"
                        }
                    }
                }
            });
        }
    }


</script>
</html>
