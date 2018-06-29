<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>17商城</title>
    <link type="text/css" href="${pageContext.request.contextPath}/static/css/css.css" rel="stylesheet"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/js.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/wb.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript">
        $(function () {
            $("#kinMaxShow").kinMaxShow();
        });
    </script>
</head>

<body>
<div class="mianCont">
    <jsp:include page="top.jsp"/>
    <div class="floor" id="floor1">
        <h3 class="floorTitle">
            1F&nbsp;&nbsp;&nbsp;&nbsp;最新上架
            <a href="${pageContext.request.contextPath}/book/list.html" class="more">更多 &gt;</a>
        </h3>
        <div class="floorBox">

                <div class="frProList">
                    <c:forEach var="book" items="${books }" begin="0" end="9" step="1">
                        <dl>
                            <dt><a href="${pageContext.request.contextPath}/book/detail.html?bookid=${book.id}"><img
                                    src="${pageContext.request.contextPath}/static/bookImages/${book.image}" width="132"
                                    height="129"/></a></dt>
                            <dd>${book.bookname }</dd>
                            <dd class="cheng">作者：${book.writer }</dd>
                            <dd class="cheng">￥${book.price }/本</dd>
                        </dl>
                    </c:forEach>
                </div>

        </div><!--floor/-->


    </div><!--mianCont/-->

</body>
</html>
