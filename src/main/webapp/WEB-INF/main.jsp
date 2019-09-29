<%@ page import="java.util.List" %>
<%@ page import="crm.entity.Permission" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>

<html>
<head>
    <meta charset="UTF-8">
    <title></title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <style>
        .error {
            color: red;
        }
    </style>

</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
         <%--   <div class="navbar" style="margin-bottom: 5px;">
                <center><font size="5px">欢迎使用*********系统</font></center>
                <button id="loginout" type="button" class="btn btn-default" aria-label="Left Align"
                        style="margin-left: 95%;">
                    <span class="glyphicon glyphicon-off" aria-hidden="true"></span>
                </button>
            </div>--%>
             <nav class="navbar">
                 <div class="container-fluid" style="padding-right: 0px;">
                     <!-- Brand and toggle get grouped for better mobile display -->
                     <div class="navbar-header">
                         <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                             <span class="sr-only">Toggle navigation</span>
                             <span class="icon-bar"></span>
                             <span class="icon-bar"></span>
                             <span class="icon-bar"></span>
                         </button>
                         <a class="navbar-brand" style="margin-left: 600px;font-size: 30px">欢迎使用天眼客户管理系统</a>
                     </div>
                     <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                         <ul class="nav navbar-nav navbar-right">
                             <li class="dropdown">
                                 <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><span class="glyphicon glyphicon-user" aria-hidden="true"/> <shiro:principal/></a>
                                 <ul class="dropdown-menu">
                                     <li><a href="${pageContext.request.contextPath}/showOwn.action?username=<shiro:principal/>" target="action"><span class="glyphicon glyphicon-cog" aria-hidden="true"/><span style="margin-left: 10px">查看个人信息</span></a></li>
                                     <li role="separator" class="divider"></li>

                                     <li><a href="#" data-toggle="modal" data-target="#myModal"><span class="glyphicon glyphicon-pencil" aria-hidden="true"/><span style="margin-left: 10px">修改密码</span></a></li>
                                     <li role="separator" class="divider"></li>

                                     <li><a href="#" id="loginout" class="form-inline"><span class="glyphicon glyphicon-off" aria-hidden="true"/><span style="margin-left: 10px">退出登录</span></a></li>
                                 </ul>
                             </li>
                         </ul>
                     </div>
                 </div>
             </nav>

        </div>
    </div>
    <div class="row">
        <div class="col-md-2">
            <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                <c:forEach items="${list}" var="p" varStatus="v">
                    <shiro:hasPermission name="${p.pname}">
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="heading${v.index}">
                                <h4 class="panel-title">
                                    <a role="button" data-toggle="collapse" data-parent="#accordion"
                                       href="#collapse${v.index}" aria-expanded="true"
                                       aria-controls="collapse${v.index}">
                                        <span class="glyphicon glyphicon-grain" aria-hidden="true"></span>
                                        <span style="margin-left: 20px">${p.pinfo}</span>
                                    </a>
                                </h4>
                            </div>
                            <div id="collapse${v.index}" class="panel-collapse collapse" role="tabpanel"
                                 aria-labelledby="heading${v.index}">
                                <div class="panel-body">
                                    <c:if test="${p.list!=null}">
                                        <c:forEach items="${p.list}" var="m">
                                            <shiro:hasPermission name="${m.pname}">
                                                <c:choose>
                                                    <c:when test="${m.purl eq 'findCusByCom.action'}">
                                                        <a class=" btn btn-block btn-primary"
                                                           href="${pageContext.request.contextPath}/${m.purl}?username=<shiro:principal/>"
                                                           target="action">${m.pinfo}</a>
                                                    </c:when>
                                                    <c:when test="${m.purl eq 'findAllByCom.action'}">
                                                        <a class=" btn btn-block btn-primary"
                                                           href="${pageContext.request.contextPath}/${m.purl}?employees.username=<shiro:principal/>"
                                                           target="action">${m.pinfo}</a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a class=" btn btn-block btn-primary"
                                                           href="${pageContext.request.contextPath}/${m.purl}"
                                                           target="action">${m.pinfo}</a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </shiro:hasPermission>
                                        </c:forEach>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </shiro:hasPermission>
                </c:forEach>

               <%-- <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="headingTwo">
                        <h4 class="panel-title">
                            <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion"
                               href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                系统管理
                            </a>
                        </h4>
                    </div>
                    <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                        <div class="panel-body">
                            <button type="button" class="btn btn-block btn-primary" data-toggle="modal"
                                    data-target="#myModal">
                                修改密码
                            </button>
                        </div>
                    </div>
                </div>--%>

            </div>
        </div>
        <div class="col-md-10" style="padding: 0;" >
            <iframe src="${pageContext.request.contextPath}/welcome.jsp" width="1268px" height="650px" name="action">
            </iframe>
        </div>
    </div>
</div>


<%--	<button type="button" class="btn btn-block btn-primary" data-toggle="modal" data-target="#myModal">
        修改密码
    </button>--%>
<%--修改密码的模态框--%>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">

            <form id="form" method="post" action="${pageContext.request.contextPath}/modifyPassword.action">
                <div>
                    <p>请在此处修改你的密码:</p>
                    <input type="text" value="<shiro:principal/>" hidden id="username" name="username"/>
                </div>
                <div class="form-group">
                    <label for="oldPassword">请输入原来的密码:</label>
                    <input type="password" class="form-control" id="oldPassword" placeholder="OldPassword"
                           name="oldPassword">
                </div>
                <div class="form-group">
                    <label for="password">请输入您要修改的密码:</label>
                    <input type="password" class="form-control" id="password" placeholder="Password" name="password">
                </div>
                <div class="form-group">
                    <label for="newPassword">请再次确认您要修改的密码:</label>
                    <input type="password" class="form-control" id="newPassword" placeholder="NewPassword"
                           name="newPassword">
                </div>
            </form>

            <div class="modal-footer">
                <input type="button" class="btn btn-primary" value="重置" onclick="res()">
                <button type="button" class="btn btn-primary" id="primary">确认修改</button>
            </div>
        </div>
    </div>
</div>
<%---------------------------%>
</body>
<script src="javascript/jQuery-1.12.4.js"></script>
<script src="javascript/bootstrap.js"></script>
<script src="${pageContext.request.contextPath}/javascript/jquery.validate.js"></script>
<script src="${pageContext.request.contextPath}/javascript/messages_zh.js"></script>
<script>
    $("#loginout").click(function () {
        window.location.href = "${pageContext.request.contextPath}/loginOut.action";
    })

    $("#primary").click(function () {
        $("#form").submit();
    })

    $.validator.setDefaults({
        submitHandler: function (form) {
            form.submit();
        }
    });


    $().ready(function () {
        $("#form").validate({
            rules: {
                oldPassword: {
                    required: true,
                    remote: {
                        url: "${pageContext.request.contextPath}/checkPassword.action",
                        type: "post",
                        data: {
                            username: function () {
                                return $("#username").val();
                            },
                            password: function () {
                                return $("#oldPassword").val();
                            }
                        }
                    }
                },
                password: "required",
                newPassword: {
                    required: true,
                    equalTo: "#password"
                },
            },
            messages: {
                oldPassword: {
                    required: "请输入原密码",
                    remote: "与原密码不符"
                },
                password: {
                    required: "请输入密码",
                },
                password2: {
                    required: "请输入密码",
                    equalTo: "两次密码输入不一致"
                }
            },
        });
    });

    function res() {
        $("#form")[0].reset();
    }
</script>
</html>
