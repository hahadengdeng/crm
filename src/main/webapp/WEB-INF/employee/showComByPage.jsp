<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/9/17
  Time: 14:05
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

<div class="form-inline">
    <span>请输入员工名:</span>
    <input type="text" id="username1">
    <input type="button" class="btn btn-primary" value="查寻" onclick="search()">
</div>

<table id="tab1">

</table>

<%--修改专员信息模态框--%>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form id="form" method="post">
                <input type="text" id="empid" name="empid" hidden>
                <div>
                    <span class="input-group-addon">请在此处修改</span>
                </div>


                <div class="input-group input-group-sm">
                    <span class="input-group-addon" id="sizing-addon1">登录名</span>
                    <input type="text" class="form-control" placeholder="username" aria-describedby="sizing-addon1"
                           id="username" name="username">
                </div>

                <div class="input-group input-group-sm">
                    <span class="input-group-addon" id="sizing-addon2">登录密码</span>
                    <input type="text" class="form-control" placeholder="password" aria-describedby="sizing-addon2"
                           id="password" name="password" readonly>
                </div>

                <div class="input-group input-group-sm">
                    <span class="input-group-addon" id="sizing-addon3">联系电话</span>
                    <input type="text" class="form-control" placeholder="tel" aria-describedby="sizing-addon3" id="tel"
                           name="tel">
                </div>

                <div class="input-group input-group-sm">
                    <span class="input-group-addon" id="sizing-addon4">用户姓名</span>
                    <input type="text" class="form-control" placeholder="name" aria-describedby="sizing-addon3"
                           id="name" name="name">
                </div>

                <div class="input-group input-group-sm">
                    <span class="input-group-addon" id="sizing-addon5">电子邮箱</span>
                    <input type="text" class="form-control" placeholder="email" aria-describedby="sizing-addon3"
                           id="email" name="email">
                </div>

                <div readonly>
                    <span class="input-group-addon">请选择职位:</span>
                    <select id="deptid" name="dept.deptid" style="width: 100%">
                        <option value="2">commissioner</option>
                    </select>
                </div>
            </form>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" id="primary">确认修改</button>
            </div>
        </div>
    </div>
</div>
<%---------------------------%>

</body>
<script src="javascript/jQuery-1.12.4.js"></script>
<script src="javascript/bootstrap.js"></script>
<script src="javascript/jquery.validate.js"></script>
<script src="javascript/messages_zh.js"></script>


<script src="${pageContext.request.contextPath}/javascript/table/bootstrap-table.js"></script>
<link href="${pageContext.request.contextPath}/javascript/table/bootstrap-table.css" rel="stylesheet"/>
<script src="${pageContext.request.contextPath}/javascript/table/locale/bootstrap-table-zh-CN.js"></script>
<script>
    $(function () {
        var t = new TableInit();
        t.Init();
    })

    var TableInit = function () {
        var oTableInit = new Object();
        //初始化Table
        oTableInit.Init = function () {
            $("#tab1").bootstrapTable({
                url: "${pageContext.request.contextPath}/findAllCommissionerByPage.action",
                method: "get",
                queryParams: oTableInit.queryParams,
                striped: true,

                pagination: true,
                sidePagination: "server",
                pageNumber: 1,                       //初始化加载第一页，默认第一页
                pageSize: 2,                       //每页的记录行数（*）
                pageList: [1, 2, 4],        //可供选择的每页的行数（*）
                columns: [{
                    checkbox: true
                }, {
                    field: 'empid',
                    title: '员工ID'
                }, {
                    field: 'username',
                    title: '登录账号'
                }, {
                    field: 'password',
                    title: '登录密码'
                }, {
                    field: 'tel',
                    title: '联系电话'
                }, {
                    field: 'name',
                    title: '员工姓名'
                }, {
                    field: 'email',
                    title: '电子邮箱'
                }, {
                    field: 'dept.deptname',
                    title: '部门名称'
                }, {
                    field: 'empid',
                    title: '操作',
                    formatter: actionFormatter
                }]
            });
        };
        oTableInit.queryParams = function (params) {
            var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                limit: params.limit,   //页面大小
                offset: params.offset,  //页码
                "username":$("#username1").val()
            };
            return temp;
        };
        return oTableInit;
    };


    function actionFormatter(val, row, index) {
        return "<a onclick='checkShare(" + val + ")' ><input type='button' value='删除' class='btn btn-danger'/></a>" +
            "<a style='margin-left: 10px' data-toggle='modal' data-target='#myModal' onclick='readyUpdate(" + val + ")'><input type='button' value='修改' class='btn btn-warning'/></a>"
    }

    function search() {
        $("#tab1").bootstrapTable("refresh", {
            query: {
                "offset": "1",
                "limit": "2",
                "username":$("#username1").val()
            }
        })
    }

/*    $(function () {
        $.ajax({
            type: "get",
            url: "${pageContext.request.contextPath}/findAllDept.action",
            contentType: "application/json;charset=utf-8",
            success: function (msg) {
                for (var i = 0; i < msg.length; i++) {
                    var deptname = msg[i].deptname;
                    var deptid = msg[i].deptid;
                    $("#deptid").append("<option selected value='" + deptid + "'>" + deptname + "</option>");
                }

            }
        });
    });*/

    function readyUpdate(obj) {
        var id = obj;
        $.ajax({
            type: "get",
            url: "${pageContext.request.contextPath}/findEmpById.action",
            data: {empid: id},
            contentType: "application/json;charset=utf-8",
            success: function (result) {
                $("#empid").val(result.empid);
                $("#username").val(result.username);
                $("#password").val(result.password);
                $("#tel").val(result.tel);
                $("#name").val(result.name);
                $("#email").val(result.email);
            }
        });
    }

    /*表单验证提交*/

    $("#primary").click(function () {
        if ($("#form").valid() == true) {
            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/modifyCom.action",
                data: $('#form').serialize(),
                success: function (result) {
                    if (result != null) {
                        alert("成功");
                        $('#myModal').modal('hide');
                        $("#tab1").bootstrapTable("refresh");
                    } else {
                        alert("失败");
                    }
                }
            });
        }
    });


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

    function checkShare(obj) {
        var empid = obj;
        $.ajax({
            type: "get",
            url: "${pageContext.request.contextPath}/checkDeleteEmp.action",
            data: {empid: empid},
            contentType: "application/json;charset=utf-8",
            success: function (result) {

                if (result.length == 0) {
                    checkVisit(empid);
                } else {
                    alert("存在客户,请重试");
                }
            }
        });
    }

    function checkVisit(obj) {
        $.ajax({
            type: "get",
            url: "${pageContext.request.contextPath}/checkDeleteEmpCV.action",
            data: {empid: obj},
            contentType: "application/json;charset=utf-8",
            success: function (result) {
                if (result.length == 0) {
                    $.ajax({
                        type: "get",
                        url: "${pageContext.request.contextPath}/deleteCom.action",
                        data: {empid: obj},
                        contentType: "application/json;charset=utf-8",
                        success: function (req) {
                            if (req != null) {
                                alert("删除成功");
                                $("#tab1").bootstrapTable("refresh");
                            } else {
                                alert("删除失败");
                            }
                        }
                    });
                } else {
                    alert("存在访客信息,请重试");
                }
            }
        });
    }

</script>
</html>
