<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/9/22
  Time: 18:56
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
<form class="form-horizontal" role="form" id="form">
    <%-- <tr>
         <td>
             <input type="text" id="id" name="id" >
         </td>
     </tr>

     <div class="form-group">
         <label for="cusname" class="col-sm-1 control-label">客户姓名</label>
         <div class="col-sm-11">
             <input type="text" class="form-control" id="cusname" placeholder="请输入客户姓名" name="cusname">
         </div>
     </div>--%>
    <c:forEach items="${list}" var="c">
        <td><input type="text" value="${c.cid}" name="cid" readonly="readonly"></td>
        <td><input type="text" value="${c.cusname}" name="cid" readonly="readonly"></td>
    </c:forEach>

    <table class="table table-striped" id="tab">

        <tr>
            <td>
                <center>
                    <a class="btn btn-default" onclick="addLine()">增加</a>
                    <a class="btn btn-default" id="insertMore">提交</a>
                </center>
            </td>
        </tr>
    </table>
</form>


<table class="table table-striped" hidden>
    <tr id="copy">
        <td>
            <select name="empids" style="width: 100%" id="empid">
            </select>
        </td>
        <td><a class="btn btn-default" onclick="deleteLine(this)">删除</a></td>
    </tr>
</table>
</body>
<script src="javascript/jQuery-1.12.4.js"></script>
<script src="javascript/bootstrap.js"></script>
<script src="javascript/jquery.validate.js"></script>
<script src="javascript/messages_zh.js"></script>
<script>
    $(function () {
        $.ajax({
            type: "get",
            url: "${pageContext.request.contextPath}/findAllEmp.action",
            contentType: "application/json;charset=utf-8",
            success: function (result) {
                var arrayObj = new Array();
                <c:forEach items="${list}" var="l">
                <c:forEach items="${l.employees}" var="e">
                arrayObj.push("${e.username}");
                </c:forEach>
                </c:forEach>
                for (var i = 0; i < result.length; i++) {
                    var a=result[i].username;
                    var b=$.inArray(a,arrayObj);
                    if (b<0){
                        var a = "<option value='" + result[i].empid + "'>" + result[i].username + "</option>"
                        $("#empid").append(a);
                    }
                }
            }
        });
    });

    function addLine() {
        var tr = $("#copy").clone();
        $("#tab tr:last").before(tr);
    }

    function deleteLine(obj) {
        var a = $(obj.parentElement.parentElement);
        a.remove();
    }


    $("#insertMore").click(function () {
        var a = partern();
        var arr = $("select[name ='empids']");
        var c=empty1();
        if (arr.length >= 2) {
            if (a == true) {
                if (c==true){
                    $.ajax({
                        type: "get",
                        url: "${pageContext.request.contextPath}/shareCustomer.action",
                        data:$("#form").serialize(),
                        contentType: "application/json;charset=utf-8",
                        success:function (msg) {
                            if(msg==1){
                                window.location.href="${pageContext.request.contextPath}/findAllByCom.action?username=<shiro:principal/>";
                            }
                        }
                    })
                }else {
                    alert("该客户已被所有专员共享");
                }
            } else {
                alert("无法将该客户指定给同一专员");
            }
        } else {
            alert("必须将客户指定一名专员");
        }
    })

    function partern() {
        var arr = $("select[name ='empids']");
        for (var i = 0; i < arr.length - 1; i++) {
            for (var j = i + 1; j < arr.length - 1; j++) {
                if (arr[i].value == arr[j].value) {
                    return false;
                }
            }
        }
        return true;
    }

    function empty1() {
        var arr = $("select[name ='empids']");
        if ($(arr[0].options).length==0){
            return false;
        }else {
            return true;
        }
    }
</script>
</html>
