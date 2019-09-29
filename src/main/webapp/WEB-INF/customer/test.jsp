<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/9/18
  Time: 14:26
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

<form class="form-horizontal" role="form" id="form" action="${pageContext.request.contextPath}/aaa.action">
    <div class="form-group">
        <label for="cusname" class="col-sm-1 control-label">客户姓名</label>
        <div class="col-sm-11">
            <input type="text" class="form-control" id="cusname" placeholder="请输入客户姓名" name="cusname">
        </div>
    </div>
    <div class="form-group">
        <label for="address" class="col-sm-1 control-label">地址</label>
        <div class="col-sm-11">
            <input type="text" class="form-control" id="address" placeholder="请输入客户地址" name="address">
        </div>
    </div>
    <div class="form-group">
        <label for="contact" class="col-sm-1 control-label">联系人</label>
        <div class="col-sm-11">
            <input type="text" class="form-control" id="contact" placeholder="请输入联系人" name="contact">
        </div>
    </div>
    <div class="form-group">
        <label for="tel" class="col-sm-1 control-label">电话</label>
        <div class="col-sm-11">
            <input type="text" class="form-control" id="tel" placeholder="请输入联系方式" name="tel">
        </div>
    </div>
    <div class="form-group">
        <label for="email" class="col-sm-1 control-label">电子邮箱</label>
        <div class="col-sm-11">
            <input type="text" class="form-control" id="email" placeholder="请输入电子邮箱" name="email">
        </div>
    </div>

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



</body>
<script src="javascript/jQuery-1.12.4.js"></script>
<script src="javascript/bootstrap.js"></script>
<script src="javascript/jquery.validate.js"></script>
<script src="javascript/messages_zh.js"></script>
<script>




    $("#insertMore").click(function () {

                $("#form").submit();

    })





</script>
</html>
