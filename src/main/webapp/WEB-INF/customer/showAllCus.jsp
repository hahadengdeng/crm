<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/9/18
  Time: 11:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<link href="css/bootstrap.min.css" rel="stylesheet">
<body>
<table class="table table-striped">
    <tr>
        <td>客户id</td>
        <td>客户名</td>
        <td>客户地址</td>
        <td>联系人</td>
        <td>客户电话</td>
        <td>客户邮箱</td>
        <td>专员姓名</td>
        <td>操作</td>
    </tr>
    <c:forEach items="${list}" var="c">
        <tr>
            <td>${c.cid}</td>
            <td>${c.cusname}</td>
            <td>${c.address}</td>
            <td>${c.contact}</td>
            <td>${c.tel}</td>
            <td>${c.email}</td>
            <td>
                <c:forEach items="${c.employees}" var="e">
                    <input type="text" hidden value="${e.empid}" name="empids">
                    ${e.name}&nbsp;
                </c:forEach>
            </td>
            <td>
                <a type="button" class="btn btn-warning"
                   href="${pageContext.request.contextPath}/findCusByCid.action?cid=${c.cid}">修改</a>
                <a type="button" class="btn btn-info"
                   href="${pageContext.request.contextPath}/customerTran.action?cid=${c.cid}">转移</a>
                <a class="btn btn-danger" onclick="deleteCus(this)">删除</a>
            </td>
        </tr>
    </c:forEach>
</table>
<a class="btn btn-default" href="${pageContext.request.contextPath}/oneKeyLoad.action">下载</a>
</body>
<script src="javascript/jQuery-1.12.4.js"></script>
<script src="javascript/bootstrap.js"></script>
<script src="javascript/jquery.validate.js"></script>
<script src="javascript/messages_zh.js"></script>
<script>
    function deleteCus(obj) {
        var b = confirm("高危操作,确认删除此客户吗?");
        if (b == true) {
            var cid = obj.parentElement.parentElement.firstElementChild.innerHTML;
            $.ajax({
                type: "get",
                url: "${pageContext.request.contextPath}/deleteCustomer.action",
                data: {
                    cid: cid
                },
                contentType: "application/json;charset=utf-8",
                success: function (result) {
                    if (result == true) {
                        alert("删除成功");
                        window.location.href = "${pageContext.request.contextPath}/toShow.action";
                    } else {
                        alert("删除失败");
                        window.location.href = "${pageContext.request.contextPath}/toShow.action";
                    }
                }
            });
        }
    }
</script>
</html>
