<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>添加图书页面</title>
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
        function submitForm() {
            $("#ff").form("submit",{
                url:"${pageContext.request.contextPath}/admin/book/save.do",
                onSubmit:function(){

                },
                success:function(result){
                    var result=eval('('+result+')');
                    if(result.success){
                        $.messager.alert("系统提示","图书发布成功");
                        resultValue();
                    }else{
                        $.messager.alert("系统提示","图书发布失败");
                        return;
                    }
                }
            });

        }

        function clearForm() {
            $('#ff').form('clear');
        }
        function resultValue() {
            $("#bookname").val("");
            $("#categoryId").combobox("setValue", "");
            $("#price").val("");
            $("#writer").val("");
            $("#uploadFile").val("");9

        }
    </script>
</head>
<body style="margin: 10px">

<div id="p" class="easyui-panel" title="添加书籍" style="padding: 10px">
    <form id="ff"   method="post" enctype="multipart/form-data">
        <table cellpadding="5">
            <tr>
                <td width="80px">书籍名称：</td>
                <td>
                    <input type="text" id="bookname" name="bookname" style="width: 400px"/>
                </td>

            </tr>
            <tr>
                <td>所属类别：</td>
                <td>
                    <select class="easyui-combobox" style="width: 154px" id="categoryId" name="category.id"
                            editable="false" panelHeight="auto">
                        <option value="">请选择图书类别...</option>
                        <c:forEach var="category" items="${categorys }">
                            <option value="${category.id }">${category.categoryname }</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                <td>作者：</td>
                <td><input type="text" id="writer" name="writer" style="width: 400px" />&nbsp;</td>
            </tr>
            <br>
            <tr>
                <td>价格：</td>
                <td><input type="text" id="price" name="price" style="width: 400px"/>&nbsp;</td>
            </tr>
            <tr>
                 <td>图片：</td>
                 <td><input type="file" id="uploadFile"  name="uploadFile" style="width: 400px"/>&nbsp;</td>
             </tr>


        </table>
    </form>
    <div style="padding:5px">
        <a href="javascript:submitForm()" class="easyui-linkbutton">提交</a>
        <a href="javascript:clearForm()" class="easyui-linkbutton">清空</a>
    </div>
</div>

</body>
</html>