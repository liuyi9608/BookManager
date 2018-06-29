<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>订单管理页面</title>
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/static/jquery-easyui-1.5.5.1/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/static/jquery-easyui-1.5.5.1/themes/icon.css">
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/jquery-easyui-1.5.5.1/jquery.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/jquery-easyui-1.5.5.1/jquery.easyui.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/jquery-easyui-1.5.5.1/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript">
        function searchOrder() {
            $("#dg").datagrid('load', {
                "orderNo": $("#s_orderNo").val()
            });
        }

        function formatImage(val, row) {
            return "<img width=100 height=100 src='${pageContext.request.contextPath}/static/bookImages/" + val + "'>";
        }

        function formatuserName(val, row) {
            return val.username;
        }

        /*function formattotalprices(val, row) {
            return val.orderList.totalPrices;
        }
        function formatorderdate(val, row) {
            return val.orderList.orderdate;
        }
        function formatorderstatus(val, row) {
            return val.orderList.orderstatus;
        }
        function formatreceiverAddress(val, row) {
            return val.orderList.receiverAddress;
        }
        function formatreceiverName(val, row) {
            return val.orderList.receiverName;
        }
        function formatreceiverPhone(val, row) {
            return val.orderList.receiverPhone;
        }*/

        function formatBook(val, row) {
            return val.book.bookname;
        }


        function deleteOrder() {
            var selectedRows = $("#dg").datagrid("getSelections");
            if (selectedRows.length == 0) {
                $.messager.alert("系统提示", "请选择要删除的数据！");
                return;
            }
            var strIds = [];
            for (var i = 0; i < selectedRows.length; i++) {
                strIds.push(selectedRows[i].id);
            }
            var ids = strIds.join(",");
            $.messager.confirm("系统提示", "您确定要删除这<font color=red>" + selectedRows.length + "</font>条数据吗？", function (r) {
                if (r) {
                    $.post("${pageContext.request.contextPath}/admin/order/delete.do", {ids: ids}, function (result) {
                        if (result.success) {
                            if (result.exist) {
                                $.messager.alert("系统提示", result.exist);
                            } else {
                                $.messager.alert("系统提示", "数据已成功删除！");
                            }
                            $("#dg").datagrid("reload");
                        } else {
                            $.messager.alert("系统提示", "数据删除失败！");
                        }
                    }, "json");
                }
            });
        }

        function openOrderDetailDialog() {
            var selectedRows = $("#dg").datagrid('getSelections');
            if (selectedRows.length != 1) {
                $.messager.alert("系统提示", "请选择一条要查看的数据！");
                return;
            }
            var row = selectedRows[0];
            $("#dg2").datagrid('load', {
                "id": row.id
            });
            $("#orderNo").val(row.orderNo);
            $("#user").val(row.user.username + "(ID:" + row.user.id + ")");
            $("#totalprices").val(row.totalprices + "(元)");
            $("#orderstatus").val(row.orderstatus);
            $("#dlg").dialog("open").dialog("setTitle", "订单详情");
        }

        function closeOrderDetailDialog() {
            $("#dlg").dialog("close");
        }

        function formatProPic(val, row) {
            return "<img width=100 height=100 src='${pageContext.request.contextPath}/" + val + "'>";
        }
    </script>
</head>
<body style="margin: 1px">
<table id="dg" title="博客管理" class="easyui-datagrid"
       fitColumns="true" pagination="true" rownumbers="true"
       url="${pageContext.request.contextPath}/admin/order/list.do" fit="true" toolbar="#tb">
    <thead>
    <tr>
        <th field="cb" checkbox="true" align="center"></th>
        <th field="id" width="20" align="center">编号</th>
        <th field="orderNo" width="100" align="center">订单号</th>
        <th field="user" width="50" align="center" formatter="formatuserName">用户名</th>
        <th field="totalprices" width="100" align="center">总价</th>
        <th field="orderdate" width="50" align="center">创建时间</th>
        <th field="orderstatus" width="50" align="center">订单状态</th>
        <th field="receiverAddress" width="50" align="center">收货地址</th>
        <th field="receiverName" width="50" align="center">收货人</th>
        <th field="receiverPhone" width="50" align="center">联系方式</th>
    </tr>
    </thead>
</table>
<div id="tb">
    <div>
        <a href="javascript:openOrderDetailDialog()" class="easyui-linkbutton" iconCls="icon-detail"
           plain="true">查看订单详情</a>
        <a href="javascript:deleteOrder()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
    </div>
    <div>
        &nbsp;订单号：&nbsp;<input type="text" id="s_orderNo" size="20" onkeydown="if(event.keyCode==13) searchOrder()"/>
        <a href="javascript:searchOrder()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
    </div>
</div>

<div id="dlg" class="easyui-dialog"
     style="width: 750px; height: 400px; padding: 10px 30px ;overflow:auto" closed="true"
     buttons="#dlg-buttons">
    <table cellspacing="8px">
        <tr>
            <td>订单号：</td>
            <td><input type="text" id="orderNo" readonly="readonly"/></td>
            <td>&nbsp;</td>
            <td>订单人：</td>
            <td><input type="text" id="user" readonly="readonly"/></td>
        </tr>
        <tr>
            <td>总金额：</td>
            <td><input ty9pe="text" id="totalprices" readonly="readonly"/></td>
            <td>&nbsp;</td>
            <td>订单状态：</td>
            <td><input type="text" id="orderstatus" readonly="readonly"/></td>
        </tr>
    </table>
    <br/>
   <table id="dg2" title="订单详情列表" class="easyui-datagrid"
           fitColumns="true" rownumbers="true"
           url="${pageContext.request.contextPath}/admin/order/findOrderById.do" fit="true">
        <thead>
        <tr>
            <th field="cb" checkbox="true" align="center"></th>
            <th field="bookname" width="100" align="center">商品名称</th>
            <th field="image" width="100" align="center"
                formatter="formatImage">商品图片
            </th>
            <th field="num" width="50" align="center">购买数量</th>
            <th field="price" width="50" align="center">单价价格</th>
        </tr>
        </thead>
    </table>
</div>

<div id="dlg-buttons">
    <a href="javascript:closeOrderDetailDialog()"
       class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
</div>
</body>
</html>