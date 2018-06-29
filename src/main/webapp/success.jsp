<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
</head>

<body>
<div class="mianCont">
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
                <%--<input type="image" src="${pageContext.request.contextPath}/static/images/subimg.png" width="63"
                       height="34" class="sub"/>--%>
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

                        <a href="order.cart.jsp">去结算</a> <img
                            src="${pageContext.request.contextPath}/static/images/youjian.jpg"
                            width="5" height="8"/>


                        <div class="myChunlv">
                            <a href="vip.usercenter.jsp"><img src="${pageContext.request.contextPath}/static/images/mychunlv.jpg"
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
            <h2 class="Title">所有商品分类
            </h2>
        </div><!--pntLeft/-->
        <div class="pntRight">
            <ul class="nav">
                <li><a href="index.index.jsp">商城首页</a></li>
                <li class="navCur"><a href="product.booklist.jsp">所有图书</a></li>
                <li><a href="login.login.jsp">会员中心</a></li>
                <li><a href="help.html">帮助中心</a></li>
                <div class="clears"></div>
                <div class="phone">TEL：021-12345678</div>
            </ul><!--nav/-->
        </div><!--pntRight/-->
        <div class="clears"></div>
    </div><!--pnt/-->
    <div class="positions">
        当前位置：<a href="index.index.jsp">首页</a> &gt; <a href="#" class="posCur">购物车</a>
    </div><!--positions/-->
    <div class="cont">
        <div class="chenggong">
            <h3>下单成功</h3>

        </div><!--chenggong/-->
    </div><!--cont/-->

</body>
</html>
