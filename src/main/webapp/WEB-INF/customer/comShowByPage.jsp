<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/9/24
  Time: 16:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<link href="css/bootstrap.min.css" rel="stylesheet">
<style>
    .fixed-table-body{
        height: auto;
    }
</style>
<body>
<div class="form-inline">
    <span>请输入关键字:</span>
    <input type="text" id="cusname">
    <input type="button" class="btn btn-primary" value="查寻" onclick="search()">
</div>
<table  id="tab1">

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
        var t=new TableInit();
        t.Init();
    })

    var TableInit = function () {
        var oTableInit = new Object();
        //初始化Table
        oTableInit.Init = function () {
            $("#tab1").bootstrapTable({
                url:"${pageContext.request.contextPath}/comShowCusByPage.action",
                method:"get",
                queryParams: oTableInit.queryParams,
                striped: true,

                pagination: true,
                sidePagination: "server",
                pageNumber:1,                       //初始化加载第一页，默认第一页
                pageSize:2 ,                       //每页的记录行数（*）
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
                    field: 'contact',
                    title: '联系人'
                },{
                    field: 'tel',
                    title: '联系电话'
                },{
                    field: 'email',
                    title: '电子邮箱'
                }/*,{
                    field: 'cid',
                    title: '操作',
                    formatter:actionFormatter
                }*/]
            });
        };
        oTableInit.queryParams = function (params) {
            var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                limit: params.limit,   //页面大小
                offset: params.offset,  //页码
                "username":"<shiro:principal/>",
                "cusname":$("#cusname").val()
            };
            return temp;
        };
        return oTableInit;
    };


    function search() {
        $("#tab1").bootstrapTable("refresh", {
            query: {
                "offset": "1",
                "limit": "4",
                "username":"<shiro:principal/>",
                "cusname":$("#cusname").val()
            }
        })
    }
/*    function actionFormatter(val,row,index) {
        return "<a><input type='button' class='btn btn-default' value='删除'/></a>" +
            "<a class='btn btn-default'  href=''>修改</a>"
    }*/
</script>
</html>
