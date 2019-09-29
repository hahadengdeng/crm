<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/9/20
  Time: 13:33
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

    .fixed-table-body {
        height: auto;
    }

</style>
<body>
<div class="form-inline">
    <span>请输入关键字:</span>
    <input type="text" id="cusname">
    <input type="button" class="btn btn-primary" value="查寻" onclick="search()">
</div>


<table id="tab1">

</table>

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Modal title</h4>
            </div>
            <div class="modal-body" >
                <table id="tab">

                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>


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
                url: "${pageContext.request.contextPath}/findCustomerByPage.action",
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
                    field: 'cid',
                    title: '客户ID'
                }, {
                    field: 'cusname',
                    title: '客户姓名'
                }, {
                    field: 'address',
                    title: '客户地址'
                }, {
                    field: 'tel',
                    title: '联系电话'
                }, {
                    field: 'email',
                    title: '电子邮箱'
                }, {
                    field: 'cid',
                    title: '操作',
                    formatter: actionFormatter
                }]
            });
        };
        oTableInit.queryParams = function (params) {
            var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                limit: params.limit,   //页面大小
                offset: params.offset,  //页码
                "cusname": $("#cusname").val()
            };
            return temp;
        };
        return oTableInit;
    };


    function actionFormatter(val, row, index) {
        return "<a style='margin-left: 10px'><input type='button' class='btn btn-danger' value='删除' onclick='deleteCus(" + val + ")'/></a>" +
            "<a style='margin-left: 10px' class='btn btn-warning'  href='${pageContext.request.contextPath}/findCusByCid.action?cid=" + val + "'>修改</a>" +
            "<a style='margin-left: 10px' class='btn btn-info'  data-toggle='modal' data-target='#myModal' onclick='showCustomerShare("+val+")'>查看负责专员</a>"
    }

    function deleteCus(obj) {
        var b = confirm("高危操作,确认删除此客户吗?");
        if (b == true) {
            var cid = obj;
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
                        search();
                    } else {
                        alert("删除失败");
                        window.location.href = "${pageContext.request.contextPath}/toShow.action";
                    }
                }
            });
        }
    }

    function search() {
        $("#tab1").bootstrapTable("refresh", {
            query: {
                "offset": "1",
                "limit": "2",
                "cusname": $("#cusname").val()
            }
        })
    }

    function showCustomerShare(obj) {
        $("#tab tr").remove();
        $.ajax({
            type: "get",
            url: "${pageContext.request.contextPath}/customerTranModel.action",
            data: {
                cid: obj
            },
            contentType: "application/json;charset=utf-8",
            success:function (msg) {
                for (var i=0;i<msg.length;i++){
                    $("#tab").append("<tr><td>负责员工:</td><td>"+msg[i].employees.name+"</td></tr>")
                }
            }
        })
    }
</script>
</html>
