<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/9/24
  Time: 18:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<link href="css/bootstrap.min.css" rel="stylesheet">
<style>
    .fixed-table-body {
        height: auto;
    }
</style>
<body>
<div class="form-inline">
    <select class="form-control" style="width: 20%" id="customer">
        <option value="0">请选择客户姓名</option>
    </select>
    <select class="form-control" style="width: 20%" id="employees">
        <option value="0">请选择接待人员</option>
    </select>
    <span>请选择接待日期</span>
    <input type="date" id="date">
    <input type="button" class="btn btn-primary" value="查寻" onclick="searchProduct()">
    <input type="button" value="批量删除" class="btn btn-primary" onclick="deleteMore()">
    <input type="button" value="批量修改" class="btn btn-primary" onclick="readyModifyMore()">
</div>

<table id="tab1">

</table>

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
        $.ajax({
            type: "get",
            url: "${pageContext.request.contextPath}/findAllEmp.action",
            contentType: "application/json;charset=utf-8",
            success: function (result) {
                for (var j = 0; j < result.length; j++) {
                    var a = "<option value='" + result[j].empid + "'>" + result[j].username + "</option>"
                    $("#employees").append(a);
                }
            }
        });
        $.ajax({
            type: "get",
            url: "${pageContext.request.contextPath}/findAllCusNull.action",
            contentType: "application/json;charset=utf-8",
            success: function (msg) {
                for (var i = 0; i < msg.length; i++) {
                    $("#customer").append("<option value='" + msg[i].cid + "'>" + msg[i].cusname + "</option>");
                }
            }
        });
    });


    $(function () {
        var t = new TableInit();
        t.Init();
    })

    var TableInit = function () {
        var oTableInit = new Object();
        //初始化Table
        oTableInit.Init = function () {
            $("#tab1").bootstrapTable({
                url: "${pageContext.request.contextPath}/managerShowCvPage.action",
                method: "get",
                queryParams: oTableInit.queryParams,
                striped: true,

                pagination: true,
                sidePagination: "server",
                pageNumber: 1,                       //初始化加载第一页，默认第一页
                pageSize: 4,                       //每页的记录行数（*）
                pageList: [1, 4, 8],        //可供选择的每页的行数（*）
                columns: [{
                    checkbox: true
                }, {
                    field: 'id',
                    title: 'ID'
                }, {
                    field: 'customer.cusname',
                    title: '客户姓名'
                }, {
                    field: 'employees.username',
                    title: '接待人员'
                }, {
                    field: 'content',
                    title: '访问内容'
                }, {
                    field: 'date',
                    title: '拜访时间'
                }/*,{
                    field: 'id',
                    title: '操作',
                    formatter:actionFormatter
                }*/]
            });
        };
        oTableInit.queryParams = function (params) {
            var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                limit: params.limit,   //页面大小
                offset: params.offset,  //页码
                "customer.cid": $("#customer").val(),
                "employees.empid": $("#employees").val(),
                "date": $("#date").val()
            };
            return temp;
        };
        return oTableInit;
    };

    function searchProduct() {
        $("#tab1").bootstrapTable("refresh", {
            query: {
                "offset": "1",
                "limit": "4",
                "customer.cid": $("#customer").val(),
                "employees.empid": $("#employees").val(),
                "date": $("#date").val()
            }
        })
    }

    /* function actionFormatter(val,row,index) {
         return "<a><input type='button'  class='btn btn-default' value='删除'/></a>" +
             "<a class='btn btn-default'  href=''>修改</a>"
     }*/

    function getId() {
        var rows = $('#tab1').bootstrapTable('getSelections');//行的数据
        var ids = [];
        if (rows.length != 0) {
            for (var i = 0; i < rows.length; i++) {
                ids.push(rows[i].id)
            }
            return ids;
        } else {
            alert("请选中需要批量操作的行")
        }
    }

    function deleteMore() {
        var ids = getId();
        if (ids.length != 0) {
            $.ajax({
                post: "get",
                url: "${pageContext.request.contextPath}/deleteMoreCv.action",
                contentType: "application/json;charset=utf-8",
                data: {
                    ids: ids
                },
                traditional: true,
                success: function (msg) {
                    if (msg == 1) {
                        alert("删除成功");
                        searchProduct();
                    }
                }
            });
        }
    }

    function readyModifyMore() {
        var ids = getId();
        if (ids.length != 0) {
            window.location.href = "${pageContext.request.contextPath}/readyModifyMore.action?ids=" + ids;
        }
    }
</script>
</html>
