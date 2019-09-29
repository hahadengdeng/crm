<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/9/21
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

<form class="form-horizontal" role="form" id="form" >
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
    <div class="form-group" hidden>
        <input type="text" class="form-control" id="username"  name="username" value="<shiro:principal/>">
    </div>
    <a onclick="add()" class="btn btn-default" >增加 </a>
</form>
</body>
<script src="javascript/jQuery-1.12.4.js"></script>
<script src="javascript/bootstrap.js"></script>
<script src="javascript/jquery.validate.js"></script>
<script src="javascript/messages_zh.js"></script>

<script>

   function add(){
       if ($("#form").valid()){
           $.ajax({
               type: "get",
               url: "${pageContext.request.contextPath}/comAddCustomer.action",
               data: $("#form").serialize(),
               contentType: "application/json;charset=utf-8",
               success:function (msg) {
                   if (msg==1){
                       window.location.href="${pageContext.request.contextPath}/findCusByCom.action?username=<shiro:principal/>";
                   }
               }
           })
       }
   }

    $.validator.setDefaults({
        submitHandler: function (form) {
            form.submit();
        }
    });

    $().ready(function () {
        $("#form").validate({
            debug:true,
            rules: {
                cusname: {
                    required: true,
                    remote: {
                        url: "${pageContext.request.contextPath}/findCusByName.action",
                        type: "post",
                        data: {
                            username: function () {
                                return $("#cusname").val();
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
                },
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
