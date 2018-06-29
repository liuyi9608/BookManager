<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div class="top">

        <span>您好！欢迎来到17商城 请&nbsp;<a href="${pageContext.request.contextPath}/toLogin.html">[登录]</a>&nbsp;<a
                href="${pageContext.request.contextPath}/toRegister.html">[注册]</a>
        </span>
    <span class="topRight">
            <c:choose>
                <c:when test="${not empty currentUser}">
                    <a href="vip.usercenter.jsp">我的17</a>&nbsp;|
                    <a href="order.cart.jsp">我的订单</a>&nbsp;|
                    <a href="login.login.jsp">会员中心</a>&nbsp;|
                    <a href="contact.html">联系我们</a>
                </c:when>
            </c:choose>
   </span>
</div><!--top/-->
<div class="lsg">
    <h1 class="logo"><a href="${pageContext.request.contextPath}/toIndex.do"><img
            src="${pageContext.request.contextPath}/static/images/logo.png"
            width="217" height="90"/></a></h1>
    <form action="${pageContext.request.contextPath}/book/list.html" method="post" class="subBox">
        <div class="subBoxDiv">
            <input type="text" name="bookname" class="subLeft"/>

            <button type="submit" class="sub">搜索</button>
        </div><!--subBoxDiv/-->
    </form><!--subBox/-->
    <div class="gouwuche">
        <div class="gouCar">
            <c:choose>
                <c:when test="${not empty currentUser}">
                    <a href="${pageContext.request.contextPath}/user/logout.do">退出</a>
                    <img src="${pageContext.request.contextPath}/static/images/gouimg.png" width="19" height="20"
                         style="position:relative;top:6px;"/>&nbsp;|&nbsp;
                    <strong class="red">
                        <c:choose>
                            <c:when test="${empty shoppingCartItemList.size()}">
                                0
                            </c:when>
                            <c:otherwise>
                                ${shoppingCartItemList.size()}
                            </c:otherwise>
                        </c:choose></strong>&nbsp;件&nbsp;|

                    <a href="${pageContext.request.contextPath}/shopping/list.html">去结算</a> <img
                        src="${pageContext.request.contextPath}/static/images/youjian.jpg"
                        width="5" height="8"/>


                    <div class="myChunlv">
                        <a href="${pageContext.request.contextPath}/user/usercenter.html"><img
                                src="${pageContext.request.contextPath}/static/images/mychunlv.jpg"
                                width="112"
                                height="34"/></a>
                    </div>
                    <!--myChunlv/-->

                </c:when>
                <c:otherwise>
                    <strong class="red">您还未登录！请前去<a href="toLogin.html">登陆</a></strong>
                </c:otherwise>
            </c:choose>
        </div><!--gouCar/-->
    </div><!--gouwuche/-->
</div><!--lsg/-->
<div class="pnt">
    <div class="pntLeft">
        <h2 class="Title">热门商品分类</h2>
        <ul class="InPorNav">
            <c:forEach var="category" items="${categorys }" begin="0" end="5" step="1">
                <li>
                    <a href="${pageContext.request.contextPath}/book/list.do?categoryid=${category.id}">${category.categoryname }</a>

                </li>
                <option value="${category.id }"></option>
            </c:forEach>


        </ul><!--InPorNav/-->
    </div><!--pntLeft/-->
    <div class="pntRight">
        <ul class="nav">
            <li><a href="${pageContext.request.contextPath}/toIndex.do">商城首页</a></li>
            <li class="navCur"><a href="${pageContext.request.contextPath}/book/list.html">所有图书</a></li>
            <li><a href="login.login.jsp">会员中心</a></li>
            <li><a href="help.html">帮助中心</a></li>
            <div class="clears"></div>

        </ul><!--nav/-->
        <div class="banner">
            <div id="kinMaxShow">
                <div>
                    <a href="#"><img src="${pageContext.request.contextPath}/static/images/ban1.jpg" height="360"/></a>
                </div>
                <div>
                    <a href="#"><img src="${pageContext.request.contextPath}/static/images/ban2.jpg" height="360"/></a>
                </div>
                <div>
                    <a href="#"><img src="${pageContext.request.contextPath}/static/images/ban3.jpg" height="360"/></a>
                </div>
                <div>
                    <a href="#"><img src="${pageContext.request.contextPath}/static/images/ban4.jpg" height="360"/></a>
                </div>
                <div>
                    <a href="#"><img src="${pageContext.request.contextPath}/static/images/ban5.jpg" height="360"/></a>
                </div>
            </div><!--kinMaxShow/-->
        </div><!--banner/-->
    </div><!--pntRight/-->
    <div class="clears"></div>
</div><!--pnt/-->

</body>
</html>
