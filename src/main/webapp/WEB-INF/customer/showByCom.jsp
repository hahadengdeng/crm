<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
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
<table class="table table-striped">
    <tr>
        <td>客户id</td>
        <td>客户名</td>
        <td>客户地址</td>
        <td>联系人</td>
        <td>客户电话</td>
        <td>客户邮箱</td>
        <td>操作</td>
    </tr>
    <c:forEach items="${list}" var="c">
        <tr>
            <td>${c.cid}</td>
            <td>${c.cusname}</td>
            <td>${c.address}</td>
            <td>${c.contact}</td>
            <td>${c.tel}</td>
            <td>${c.email}</td>
            <td>
                <a type="button" class="btn btn-default" onclick="readyModify(this)" data-toggle="modal"
                   data-target="#myModal">修改</a>
                <a class="btn btn-default"
                   href="${pageContext.request.contextPath}/comFindCusByCid.action?cid=${c.cid}">共享</a>
                <a class="btn btn-default" onclick="deleteCus(this)">删除</a>
            </td>
        </tr>
    </c:forEach>
</table>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form id="form">
                <input type="text" id="cid" name="cid" hidden>
                <div>
                    <span class="input-group-addon">请在此处修改</span>
                </div>
                <div class="input-group input-group-sm">
                    <span class="input-group-addon" id="sizing-addon1">客户名</span>
                    <input type="cusname" class="form-control" placeholder="cusname" aria-describedby="sizing-addon1"
                           id="cusname" name="cusname">
                </div>

                <div class="input-group input-group-sm">
                    <span class="input-group-addon" id="sizing-addon2">客户地址</span>
                    <input type="text" class="form-control" placeholder="address" aria-describedby="sizing-addon2"
                           id="address" name="address">
                </div>

                <div class="input-group input-group-sm">
                    <span class="input-group-addon" id="sizing-addon3">接待内容</span>
                    <input type="text" class="form-control" placeholder="contact" aria-describedby="sizing-addon3"
                           id="contact"
                           name="contact">
                </div>

                <div class="input-group input-group-sm">
                    <span class="input-group-addon" id="sizing-addon4">联系电话</span>
                    <input type="text" class="form-control" placeholder="tel" aria-describedby="sizing-addon3"
                           id="tel" name="tel">
                </div>

                <div class="input-group input-group-sm">
                    <span class="input-group-addon" id="sizing-addon5">电子邮箱</span>
                    <input type="text" class="form-control" placeholder="email" aria-describedby="sizing-addon3"
                           id="email" name="email">
                </div>
            </form>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="primary" onclick="subCus()">确认修改</button>
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
<script>
    function deleteCus(obj) {
        var b = confirm("高危操作,确认删除此客户吗?")
        if (b == true) {
            var cid = obj.parentElement.parentElement.firstElementChild.innerHTML;
            $.ajax({
                type: "get",
                url: "${pageContext.request.contextPath}/deleteCustomer.action",
                data: {
                    cid: cid
                },
                contentType: "application/json;charset=utf-8",
                success: function (result) {
                    if (result == true) {
                        alert("删除成功");
                        window.location.href = "${pageContext.request.contextPath}/findCusByCom.action?username=<shiro:principal/>";
                    } else {
                        alert("删除失败");
                        window.location.href = "${pageContext.request.contextPath}/findCusByCom.action?username=<shiro:principal/>";
                    }
                }
            });
        }
    }

    function readyModify(obj) {
        var cid = obj.parentElement.parentElement.firstElementChild.innerHTML;
        $.ajax({
            type: "get",
            url: "${pageContext.request.contextPath}/findCusByCidModel.action",
            data: {
                cid: cid
            },
            contentType: "application/json;charset=utf-8",
            success: function (msg) {
                $("#cid").val(msg[0].cid);
                $("#cusname").val(msg[0].cusname);
                $("#address").val(msg[0].address);
                $("#contact").val(msg[0].contact);
                $("#tel").val(msg[0].tel);
                $("#email").val(msg[0].email);
            }
        });
    }

    function subCus() {
        if ($("#form").valid() == true) {
            $.ajax({
                type: "post",
                url: "${pageContext.request.contextPath}/modifyCus.action",
                data: $("#form").serialize(),
                success: function (msg) {
                    window.location.href = "${pageContext.request.contextPath}/findCusByCom.action?username=<shiro:principal/>";
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
                cusname: {
                    required: true,
                    remote: {
                        url: "${pageContext.request.contextPath}/findCusByOp.action",
                        async: false,
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
