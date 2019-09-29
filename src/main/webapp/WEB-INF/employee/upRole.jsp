<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/9/27
  Time: 11:41
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

<div>
    <div>
        需要操作的职员:
    </div>
    <div>
        <span class="label label-primary"><font size="2px">在此处选择职员，(:)前后分别为职员工号及现有角色:</font></span>
    </div>
    <div>
        <select id="empid" name="empid" style="margin-top: 20px;margin-bottom: 20px" class="form-control">
            <option value="">请选择</option>
        </select>
    </div>
</div>

<hr class="simple" color="#6f5499"/>

<div>
    <div>
        修改权限信息:
    </div>
    <div>
        <span class="label label-primary"><font size="2px">在此处选择改变后的角色</font></span>
    </div>
    <div>
        <select id="deptid" name="deptid" style="margin-top: 20px" class="form-control">
            <option value="">请选择</option>
        </select>
    </div>
</div>

<div>
    <button onclick="checkShare()" style="margin-top: 20px" class="btn btn-success">确认</button>
</div>

<hr class="simple" color="#6f5499"/>
<div>
    <div>
        <button class="btn btn-danger" onclick="" style="margin-top: 20px" onblur="resetPsd()">一键重置密码</button>
    </div>
</div>

</body>
<script src="javascript/jQuery-1.12.4.js"></script>
<script src="javascript/bootstrap.js"></script>
<script src="javascript/jquery.validate.js"></script>
<script src="javascript/messages_zh.js"></script>
<script>
    $(function () {
        $.ajax({
            type: "get",
            url: "${pageContext.request.contextPath}/findAllDept.action",
            contentType: "application/json;charset=utf-8",
            success: function (msg) {
                for (var i = 0; i < msg.length; i++) {
                    var deptname = msg[i].deptname;
                    var deptid = msg[i].deptid;
                    if (deptid != 3) {
                        $("#deptid").append("<option selected value='" + deptid + "'>" + deptname + "</option>");
                    }
                }

            }
        });

        $.ajax({
            type: "get",
            url: "${pageContext.request.contextPath}/findEmpNotAdmin.action",
            contentType: "application/json;charset=utf-8",
            success: function (msg) {
                for (var i = 0; i < msg.length; i++) {
                    var deptname = msg[i].dept.deptname;
                    var empid = msg[i].empid;
                    var username = msg[i].username;
                    $("#empid").append("<option selected value='" + empid + "'>" + username + ":" + deptname + "</option>");
                }
            }
        });
    });


    function checkShare() {
        $.ajax({
            type: "get",
            url: "${pageContext.request.contextPath}/checkDeleteEmp.action",
            data: {
                empid: $("#empid").val()
            },
            contentType: "application/json;charset=utf-8",
            success: function (result) {

                if (result.length == 0) {
                    checkVisit();
                } else {
                    alert("该职员名下存在客户,请将该职员下的客户转移以后重试");
                }
            }
        });
    }

    function checkVisit() {
        $.ajax({
            type: "get",
            url: "${pageContext.request.contextPath}/checkDeleteEmpCV.action",
            data: {
                empid: $("#empid").val()
            },
            contentType: "application/json;charset=utf-8",
            success: function (result) {
                if (result.length == 0) {
                    modify();
                } else {
                    alert("该职员名下存在客户,请将该职员下的访问记录转移以后重试");
                }
            }
        });
    }


    function modify() {
        $.ajax({
            type: "get",
            url: "${pageContext.request.contextPath}/modifyRole.action",
            contentType: "application/json;charset=utf-8",
            data: {
                "empid": $("#empid").val(),
                "dept.deptid": $("#deptid").val()
            },
            success: function (msg) {
                if (msg > 0) {
                    alert("操作成功");
                    window.location.href = "welcome.jsp";
                }
            }
        })
    }

    function resetPsd() {
        $.ajax({
            type: "get",
            url: "${pageContext.request.contextPath}/adminModifyPassword.action",
            contentType: "application/json;charset=utf-8",
            data: {
                "empid": $("#empid").val(),
            },
            success: function (msg) {
                if (msg > 0) {
                    alert("密码重置成功,请通知相关职员");
                    tos();
                }
            }
        })
    }

    function tos() {
        window.location.href = "welcome.jsp";
    }
</script>
</html>
