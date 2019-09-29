<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/9/22
  Time: 11:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<link href="css/bootstrap.min.css" rel="stylesheet">
<style>
    .error {
        color: red;
    }
</style>
<body>
<table class="table table-striped">
    <tr>
        <td>id</td>
        <td>来访客户</td>
        <td>访问内容</td>
        <td>接待日期</td>
        <td>操作</td>
    </tr>
    <c:forEach items="${list}" var="l">
        <tr>
            <td>${l.id}</td>
            <td>${l.customer.cusname}</td>
            <td>${l.content}</td>
            <td>${l.date}</td>
            <td>
                <a class="btn btn-default" data-toggle="modal" data-target="#myModal" onclick="readyModify(this)">修改</a>
                <a class="btn btn-default" onclick="ManagerDelCus(this)">删除</a>
            </td>
        </tr>
    </c:forEach>
</table>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">Modal title</h4>
            </div>
            <div class="modal-body">
                <form id="form1">
                    <table>
                        <tr hidden>
                            <td>id</td>
                            <td>
                                <input type="text" id="id" name="id">
                            </td>
                            <td>
                                <input type="text" id="empid" name="employees.empid" value="1">
                            </td>
                        </tr>
                        <tr>
                            <td>客户姓名:</td>
                            <td hidden><input type="text" class="form-control" id="cid" name="customer.cid"></td>
                            <td>
                                <input type="text" class="form-control" id="cusname" readonly="readonly" name="cusname">
                            </td>
                        </tr>
                        <tr>
                            <td>访问内容:</td>
                            <td>
                                <input type="text" class="form-control" id="content" name="content">
                            </td>
                        </tr>
                        <tr>
                            <td>访问时间:</td>
                            <td>
                                <input type="text" class="form-control" id="date" name="date">
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
            <div class="modal-footer">

                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" onclick="modifyCs()">Save changes</button>
            </div>
        </div>
    </div>
</div>
</body>
<script src="javascript/jQuery-1.12.4.js"></script>
<script src="javascript/bootstrap.js"></script>
<script src="javascript/jquery.validate.js"></script>
<script src="javascript/messages_zh.js"></script>
<script>
    function readyModify(obj) {
        var id = obj.parentElement.parentElement.firstElementChild.innerHTML;
        $.ajax({
            type: "get",
            url: "${pageContext.request.contextPath}/findCvById.action",
            data: {
                id: id
            },
            contentType: "application/json;charset=utf-8",
            success: function (msg) {
                $("#id").val(msg.id);
                $("#cid").val(msg.customer.cid);
                $("#cusname").val(msg.customer.cusname);
                $("#content").val(msg.content);
                $("#date").val(msg.date);
            }
        });
    }


    function modifyCs() {
        if ($("#form1").valid() == true) {
            $.ajax({
                type: "post",
                url: "${pageContext.request.contextPath}/modifyCsById.action",
                data: $("#form1").serialize(),
                success: function (msg) {
                    window.location.href = "${pageContext.request.contextPath}/findAllByCom.action?employees.username=<shiro:principal/>";
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

    $("#date").mouseover(function () {
        $("#date").attr("type", "date");
    })
    $("#date").mouseout(function () {
        $("#date").attr("type", "text");
    })

    function ManagerDelCus(obj) {
        var id = obj.parentElement.parentElement.firstElementChild.innerHTML;
        $.ajax({
            type: "get",
            url: "${pageContext.request.contextPath}/deleteCusVisit.action",
            data: {
                id: id
            },
            contentType: "application/json;charset=utf-8",
            success:function (msg) {
                window.location.href="${pageContext.request.contextPath}/findAllByCom.action?employees.username=<shiro:principal/>";
            }
        })
    }
</script>
</html>
