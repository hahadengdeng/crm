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
<form method="post" id="cusForm" action="#">
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
            <td>操作</td>
        </tr>
        <c:forEach items="${list}" var="c">
            <tr>
                <td hidden><input type="text" value="${c.cid}" id="cid" name="cid"></td>
                <td><input type="text" value="${c.cusname}" id="cusname" name="cusname"></td>
                <td><input type="text" value="${c.address}" id="address" name="address"></td>
                <td><input type="text" value="${c.contact}" id="contact" name="contact"></td>
                <td><input type="text" value="${c.tel}" id="tel" name="tel"></td>
                <td><input type="text" value="${c.email}" id="email" name="email"></td>
                <td><a class="btn btn-success" onclick="subCus()">确认修改</a></td>
                    <%--            <td>
                                    <c:forEach items="${c.employees}" var="e">
                                        <input type="text" hidden value="${e.empid}" name="empids">
                                        ${e.name}&nbsp;
                                    </c:forEach>
                                </td>--%>
            </tr>
        </c:forEach>
    </table>
</form>
<form id="empForm" method="post">
    <table class="table table-striped" id="tab2">
        <tr>
            <td colspan="2">
                <center>此处修改对应的专员</center>
            </td>
        </tr>

        <c:forEach items="${list}" var="c">
            <td hidden><input type="text" value="${c.cid}" name="cid"></td>
            <c:forEach items="${c.employees}" var="e">
                <tr>
                    <td>
                        <select name="empids" style="width: 100%;" id="empids">
                            <option value="${e.empid}" selected>${e.username}</option>
                        </select>
                    </td>
                    <td>
                        <a class="btn btn-danger" onclick="deleteLine(this)">删除改专员</a>
                    </td>
                </tr>
            </c:forEach>
        </c:forEach>
        <tr>
            <td><a id="updateMore" class="btn btn-success">确认修改负责专员</a></td>
            <td><a class="btn btn-info" onclick="addLine()">指定新专员</a></td>
        </tr>
    </table>
</form>


<%--<table class="table table-striped" hidden>
    <tr id="copy">
        <td>
            <select name="empids" style="width: 100%" id="empid">

            </select>
        </td>
        <td><a class="btn btn-default" onclick="deleteLine(this)">删除</a></td>
    </tr>
</table>--%>
</body>
<script src="javascript/jQuery-1.12.4.js"></script>
<script src="javascript/bootstrap.js"></script>
<script src="javascript/jquery.validate.js"></script>
<script src="javascript/messages_zh.js"></script>
<script>
    $(function () {
        var $arr = $("select[name ='empids']");

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

    function addLine() {
        var arr = $("select[name ='empids']");
        var copy = $(arr[0].parentElement.parentElement);
        $("#tab2 tr:last").before(copy.clone());
    }

    function deleteLine(obj) {
        var arr = $("select[name ='empids']");
        if (arr.length == 1) {
            alert("这是最后一个，无法删除")
        } else {
            var a = $(obj.parentElement.parentElement);
            a.remove();
        }
    }

    function partern() {
        var arr = $("select[name ='empids']");
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
            /*$("#empForm").submit();*/
            var cid = $("#cid").val();
            $.ajax({
                type: "post",
                url: "${pageContext.request.contextPath}/modifyCs.action",
                data: $("#empForm").serialize(),
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

    $.validator.setDefaults({
        submitHandler: function (form) {
            form.submit();
        }
    });

    $().ready(function () {
        $("#cusForm").validate({
            debug: true,
            rules: {
                cusname: {
                    required: true,
                    remote: {
                        url: "${pageContext.request.contextPath}/findCusByOp.action",
                        type: "post",
                        data: {
                            cusname: function () {
                                return $("#cusname").val();
                            },
                            cid: function () {
                                return $("#cid").val();
                            }

                        }
                    }
                },
                address: "required",
                contact: "required",
                tel: {
                    required: true,
                    tel: true
                },
                email: {
                    required: true,
                    email: true
                }
            },
            messages: {
                cusname: {
                    required: "请输入客户名",
                    remote: "客户已存在"
                },
                address: {
                    required: "请输入地址",
                },
                contact: {
                    required: "请输入联系人",
                },
                tel: {
                    required: "请输入电话号码",
                    tel: "电话号码格式不正确"
                },
                email: {
                    required: "邮箱不能为空",
                    email: "请输入正确的邮箱"
                }
            }
        });
    });
</script>
</html>
