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

<form class="form-horizontal" role="form" id="form" action="${pageContext.request.contextPath}/insertCustomer.action">
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
        <%--        <tr>
                    <td>
                        <select name="empid" style="width: 100%">
                            <option></option>
                        </select>
                    </td>
                    <td><a onclick="deleteLine(this)">删除</a></td>
                </tr>--%>
        <tr>
            <td>
                <center>
                    <a class="btn btn-info" onclick="addLine()">指定专员</a>
                    <a class="btn btn-success" id="insertMore">提交</a>
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
        <td><a class="btn btn-danger" onclick="deleteLine(this)">删除</a></td>
    </tr>
</table>
</body>
<script src="javascript/jQuery-1.12.4.js"></script>
<script src="javascript/bootstrap.js"></script>
<script src="javascript/jquery.validate.js"></script>
<script src="javascript/messages_zh.js"></script>
<script>
    function addLine() {
        var tr = $("#copy").clone();
        $("#tab tr:last").before(tr);
    }

    function deleteLine(obj) {
        var a = $(obj.parentElement.parentElement);
        a.remove();
    }

    $(function () {
        $.ajax({
            type: "get",
            url: "${pageContext.request.contextPath}/findAllEmp.action",
            contentType: "application/json;charset=utf-8",
            success: function (result) {
                for (var i = 0; i < result.length; i++) {
                    var a = "<option value='" + result[i].empid + "'>" + result[i].username + "</option>"
                    $("#empid").append(a);
                }
            }
        });
    });

    $("#insertMore").click(function () {
        var a = partern();
        var arr = $("select[name ='empids']");
        if (arr.length >= 2) {
            if (a == true) {
                $("#form").submit();
            } else {
                alert("无法将该客户指定给同一专员");
            }
        } else {
            alert("必须将客户指定一名专员");
        }
    })

    //表单验证
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


    $.validator.setDefaults({
        submitHandler: function (form) {
            form.submit();
        }
    });

    $().ready(function () {
        $("#form").validate({
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
