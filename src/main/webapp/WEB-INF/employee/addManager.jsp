<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/9/16
  Time: 18:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        .error{
            color:red;
        }
    </style>
</head>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
<body>
<form class="form"  method="post" id="form">
    <div class="form-group">
        <label for="username">Username</label>
        <input type="text" class="form-control" id="username" placeholder="username" name="username">
    </div>
    <div class="form-group">
        <label for="password">Password</label>
        <input type="password" class="form-control" id="password" placeholder="password" name="password">
    </div>
    <div class="form-group">
        <label for="tel">Tel</label>
        <input type="text" class="form-control" id="tel" placeholder="tel" name="tel">
    </div>
    <div class="form-group">
        <label for="name">Name</label>
        <input type="text" class="form-control" id="name" placeholder="name" name="name">
    </div>
    <div class="form-group">
        <label for="email">Email</label>
        <input type="text" class="form-control" id="email" placeholder="email" name="email">
    </div>
    <div class="form-group" hidden>
        <label for="deptid">Dept</label>
        <input type="text" class="form-control" id="deptid" placeholder="deptid" value="1" name="dept.deptid">
    </div>
    <button type="button" class="btn btn-success" onclick="insertMan()">确认添加</button>
</form>
</body>
<script src="${pageContext.request.contextPath}/javascript/jQuery-1.12.4.js"></script>
<script src="${pageContext.request.contextPath}/javascript/bootstrap.js"></script>
<script src="${pageContext.request.contextPath}/javascript/jquery.validate.js"></script>
<script src="${pageContext.request.contextPath}/javascript/messages_zh.js"></script>
<script>

    function insertMan(){
        if ($("#form").valid()){
            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/insertManager.action",
                data: $('#form').serialize(),
                success:function (msg) {
                    if (msg==1){
                        window.location.href="${pageContext.request.contextPath}/goShowManager.action";
                    }
                }
            });
        }
    }

    $.validator.setDefaults({
        submitHandler: function(form) {
            form.submit();
        }
    });

    $().ready(function() {
        $("#form").validate({
            debug:true,
            rules: {
                username: {
                    required:true,
                    remote:{
                        url:"${pageContext.request.contextPath}/checkLoginName.action",
                        type:"post",
                        data:{
                            username:function () {
                                return $("#username").val();
                            }
                        }
                    }
                },
                password: "required",
                tel: {
                    required: true,
                    tel:true
                },
                name: {
                    required: true,
                    minlength: 2,
                },
                email: {
                    email: true
                }
            },
            messages: {
                username: {
                    required:"请注册您的登录名",
                    remote:"用户名已存在"
                },
                password: {
                    required: "请输入密码",
                },
                tel: {
                    required: "请输入电话号码",
                    tel: "电话号码格式不正确"
                },
                name:{
                    required:"请输入您的真实姓名",
                    minlength:"名字的长度必须大于2"
                },
                email:{
                    email:"请输入正确的邮箱"
                }
            }
        });
    });
</script>
</html>
