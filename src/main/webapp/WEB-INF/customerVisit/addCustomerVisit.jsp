<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/9/21
  Time: 10:51
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
        color:red;
    }
</style>

<body>
<form id="form1">
    <table class="table table-striped">
        <tr>
            <td>来访客户:</td>
            <td>
                <select name="customer.cid" style="width:60% " id="cid" required>
                    <option value="">请选择客户</option>
                </select>
            </td>
        </tr>
        <tr>
            <td>接待人员:</td>
            <td>
                <select name="employees.empid" style="width:60% " id="empid" required>
                    <option value="">请选择员工:</option>
                </select>
            </td>
        </tr>
        <tr>
            <td>访问内容:</td>
            <td>
                <textarea class="form-control" rows="3" name="content"></textarea>
            </td>
        </tr>
        <tr>
            <td>来访日期:</td>
            <td>
                <input type="date" name="date">
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <center><a class="btn btn-default" onclick="addCs()">确认添加</a></center>
            </td>
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
        $.ajax({
            type: "get",
            url: "${pageContext.request.contextPath}/findAllCusNull.action",
            contentType: "application/json;charset=utf-8",
            success: function (msg) {
                for (var i = 0; i < msg.length; i++) {
                    $("#cid").append("<option value='" + msg[i].cid + "'>" + msg[i].cusname + "</option>");
                }
            }
        });

        $.ajax({
            type: "get",
            url: "${pageContext.request.contextPath}/findAllEmp.action",
            contentType: "application/json;charset=utf-8",
            success: function (msg) {
                for (var i = 0; i < msg.length; i++) {
                    $("#empid").append("<option value='" + msg[i].empid + "'>" + msg[i].username + "</option>");
                }
            }
        })
    })


    function addCs() {
        if ($("#form1").valid() == true) {
            $.ajax({
                type: "post",
                url: "${pageContext.request.contextPath}/addCustomerVisit.action",
                data: $("#form1").serialize(),
                success: function (msg) {
                    window.location.href = "${pageContext.request.contextPath}/findAllCusVisit.action";
                    $("#myModal").modal("hide");
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
