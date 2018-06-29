<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>图书管理页面</title>
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
        function formatProPic(val, row) {
            return "<img width=70 height=70 src='${pageContext.request.contextPath}/static/bookImages/" + val + "'>";
        }

        function formatCagetory(val, row) {
            return val.categoryname;
        }

        function searchBook() {
            $("#dg").datagrid('load', {
                "bookname": $("#s_bookname").val()
            });
        }

        function deleteBook() {
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
                    $.post("${pageContext.request.contextPath}/admin/book/delete.do", {ids: ids}, function (result) {
                        if (result.success) {
                            $.messager.alert("系统提示", "数据已成功删除！");
                            $("#dg").datagrid("reload");
                        } else {
                            $.messager.alert("系统提示", "数据删除失败！");
                        }
                    }, "json");
                }
            });
        }

        function openBookModifyTab() {

            var selectedRows = $("#dg").datagrid("getSelections");
            if (selectedRows.length != 1) {
                $.messager.alert("系统提示", "请选择一个要修改的图书！");
                return;
            }
            var row = selectedRows[0];
            $("#dlg").dialog("open").dialog("setTitle", "修改图书信息");
            $("#fm").form("load", row);
            url = "${pageContext.request.contextPath}/admin/book/save.do?id=" + row.id;
        }

        function saveBook() {
            $("#fm").form("submit", {
                url: url,
                onSubmit: function () {
                    return $(this).form("validate");
                },
                success: function (result) {
                    var result = eval('(' + result + ')');
                    if (result.success) {
                        $.messager.alert("系统提示", "保存成功！");
                        resetValue();
                        $("#dlg").dialog("close");
                        $("#dg").datagrid("reload");
                    } else {
                        $.messager.alert("系统提示", "保存失败！");
                        return;
                    }
                }
            });
        }

        function closeBookDialog() {
            $("#dlg").dialog("close");
            resetValue();
        }

        function resetValue() {
            $("#bookname").val("");
            $("#writer").val("");
            $("#price").val("");
            $("#categoryname").val("");
            $("#uploadFile").val("");
        }
        function exportExcel(){
            var myurl="${pageContext.request.contextPath}/admin/book/export.do";
            var form=$("<form>");
            form.attr("style","display:none");
            form.attr("method","post");
            form.attr("action",myurl);
            $("body").append(form);
        }
    </script>
</head>
<body style="margin: 1px">
<table id="dg" title="博客管理" class="easyui-datagrid"
       fitColumns="true" pagination="true" rownumbers="true"
       url="${pageContext.request.contextPath}/admin/book/list.do" fit="true" toolbar="#tb">
    <thead>
    <tr>
        <th field="cb" checkbox="true" align="center"></th>
        <%--<th field="id" width="20" align="center">编号</th>--%>
        <th field="bookname" width="100" align="center">书名</th>
        <th field="writer" width="100" align="center">作者</th>
        <th field="price" width="50" align="center">单价</th>
        <th field="image" width="40" align="center" formatter="formatProPic">图片</th>
        <th field="category" width="50" align="center" formatter="formatCagetory">书籍类型</th>
        <th field="createTime" width="50" align="center">上架时间</th>
    </tr>
    </thead>
</table>
<div id="tb">
    <div>
        <a href="javascript:openBookModifyTab()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
        <a href="javascript:deleteBook()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
        <a href="${pageContext.request.contextPath}/admin/book/export.do" class="easyui-linkbutton"  plain="true">信息导出</a>
    </div>
    <div>
        &nbsp;标题&nbsp;<input type="text" id="s_bookname" size="20" onkeydown="if(event.keyCode==13) searchBook()"/>
        <a href="javascript:searchBook()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
    </div>
</div>

<div id="dlg" class="easyui-dialog" style="width: 500px;height: 500px;padding: 10px 20px" closed="true"
     buttons="#dlg-buttons">
    <form id="fm" method="post" enctype="multipart/form-data">
        <table cellspacing="8px">
            <tr>
                <td>图书名称：</td>
                <td>
                    <input type="text" id="bookname" name="bookname" class="easyui-validatebox" required="true"/>
                </td>
            </tr>
            <tr>
                <td>图书作者：</td>
                <td>
                    <input type="text" id="writer" name="writer" class="easyui-validatebox" required="true"/>
                </td>
            </tr>
            <tr>
                <td>图书单价：</td>
                <td>
                    <input type="text" id="price" name="price" class="easyui-validatebox" required="true"/>
                </td>
            </tr>
            <tr>
                <td>图书图片：</td>
                <td>
                    <input type="file" id="uploadFile" name="uploadFile" class="easyui-validatebox"/>
                </td>
            </tr>
            <tr>
                <td>图书分类：</td>
                <td>
                    <select class="easyui-combobox" style="width: 154px" id="categoryId" name="category.id"
                            editable="false" panelHeight="auto">
                        <option value="">请选择分类...</option>
                        <c:forEach var="category" items="${categorys }">
                            <option value="${category.id }">${category.categoryname }</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
        </table>
    </form>

</div>
<div id="dlg-buttons">
    <a href="javascript:saveBook()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
    <a href="javascript:closeBookDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
</div>
</body>
</html>