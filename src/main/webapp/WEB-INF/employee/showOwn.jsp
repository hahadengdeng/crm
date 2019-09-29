<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/9/27
  Time: 9:33
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

<table class="table table-bordered">
    <tr hidden>
        <td>Empid</td>
        <td>${employees.empid}</td>
    </tr>
    <tr>
        <td>Username</td>
        <td>${employees.username}</td>
    </tr>
    <tr>
        <td>Password</td>
        <td>${employees.password}</td>
    </tr>
    <tr>
    <td>Tel</td>
    <td>${employees.tel}</td>
    </tr>
    <tr>
        <td>Name</td>
        <td>${employees.name}</td>
    </tr>
    <tr>
        <td>Email</td>
        <td>${employees.email}</td>
    </tr>
    <tr hidden>
        <td>Dept</td>
        <td>${employees.dept.deptname}</td>
    </tr>
    <tr>
        <td colspan="2"><input type="button" value="修改 " class="btn btn-warning" data-toggle="modal" data-target="#myModal"></td>
    </tr>
</table>

<%--
    <div  hidden>
        <label >Empid</label>
        ${employees.empid}
    </div>
    <div >
        <label >Username</label>
        ${employees.username}
    </div>
    <div hidden>
        <label >Password</label>
        ${employees.password}
    </div>
    <div >
        <label >Tel</label>
        ${employees.tel}
    </div>
    <div >
        <label>Name</label>
        ${employees.name}
    </div>
    <div >
        <label >Email</label>
        ${employees.email}
    </div>
    <div  hidden>
        <label >Dept</label>
        ${employees.dept.deptname}
    </div>

    <input type="button" value="修改 " class="btn btn-warning" data-toggle="modal" data-target="#myModal">--%>

    <!-- Modal -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">此处修改您的个人信息:</h4>
                </div>
                <div class="modal-body">
                    <form class="form" method="post" id="form">
                        <div class="form-group" hidden>
                            <label for="username">Empid</label>
                            <input type="text" class="form-control" id="empid" placeholder="username" name="empid"
                                   value="${employees.empid}">
                        </div>
                        <div class="form-group">
                            <label for="username">Username</label>
                            <input type="text" class="form-control" id="username" placeholder="username" name="username"
                                   value="${employees.username}">
                        </div>
                        <div class="form-group" hidden>
                            <label for="password">Password</label>
                            <input type="password" class="form-control" id="password" placeholder="password" name="password"
                                   value="${employees.password}" readonly>
                        </div>
                        <div class="form-group">
                            <label for="tel">Tel</label>
                            <input type="text" class="form-control" id="tel" placeholder="tel" name="tel"
                                   value="${employees.tel}">
                        </div>
                        <div class="form-group">
                            <label for="name">Name</label>
                            <input type="text" class="form-control" id="name" placeholder="name" name="name"
                                   value="${employees.name}">
                        </div>
                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="text" class="form-control" id="email" placeholder="email" name="email"
                                   value="${employees.email}">
                        </div>
                        <div class="form-group" hidden>
                            <label for="deptid">Dept</label>
                            <input type="text" class="form-control" id="deptid" placeholder="deptid"
                                   value="${employees.dept.deptid}" name="dept.deptid">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn btn-info" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-success" onclick="modify()">确认修改</button>
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
    $(function () {
        if ("${employees.username}" != "<shiro:principal/>") {
            window.location.href = "${pageContext.request.contextPath}/login.action";
        }
    })

    function modify() {
        if ($("#form").valid() == true) {
            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/baseModify.action",
                data: $('#form').serialize(),
                success: function (msg) {
                    if (msg == 1) {
                        alert("修改成功");
                        $("#myModal").hide();
                        window.location.href = "${pageContext.request.contextPath}/showOwn.action?username=<shiro:principal/>";
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
        $("#form").validate({
            debug: true,
            rules: {
                username: {
                    required: true,
                    remote: {
                        url: "${pageContext.request.contextPath}/findModify.action",
                        type: "get",
                        data: {
                            username: function () {
                                return $("#username").val();
                            },
                            empid: function () {
                                return $("#empid").val();
                            }
                        }
                    }
                },
                tel: {
                    required: true,
                    tel: true
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
                    required: "请注册您的登录名",
                    remote: "用户名已存在"
                },
                password: {
                    required: "请输入密码",
                },
                password2: {
                    required: "请输入密码",
                    equalTo: "两次密码输入不一致"
                },
                tel: {
                    required: "请输入电话号码",
                    tel: "电话号码格式不正确"
                },
                name: {
                    required: "请输入您的真实姓名",
                    minlength: "名字的长度必须大于2"
                },
                email: {
                    email: "请输入正确的邮箱"
                }
            }
        });
    });

</script>
</html>
