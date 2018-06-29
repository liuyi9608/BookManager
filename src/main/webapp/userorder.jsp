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
    <script type="text/javascript">
        $(function () {
            $(".vipNav dd:first").show();
        })
    </script>
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

                        <a href="${pageContext.request.contextPath}/shopping/list.html">去结算</a> <img
                            src="${pageContext.request.contextPath}/static/images/youjian.jpg"
                            width="5" height="8"/>


                        <div class="myChunlv">
                            <a href="vip.usercenter.jsp"><img
                                    src="${pageContext.request.contextPath}/static/images/mychunlv.jpg"
                                    width="112"
                                    height="34"/></a>
                        </div>
                        <!--myChunlv/-->

                    </c:when>
                    <c:otherwise>
                        <strong class="red">您还未登录！请前去<a
                                href="${pageContext.request.contextPath}/toLogin.html">登陆</a></strong>
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
        当前位置：<a href="index.index.jsp">首页</a> &gt; <a href="vip.usercenter.jsp">会员中心</a>
        &gt; <a href="#" class="posCur">我的订单</a>
    </div><!--positions/-->
    <div class="cont">
        <div class="contLeft" id="contLeft">
            <h3 class="leftTitle">会员中心</h3>
            <dl class="helpNav vipNav">
                <dt>我的主页</dt>
                <dd>
                    <a href="vip.usercenter.jsp">个人中心</a>
                    <a href="vipOrder.userorder.jsp" class="vipCur">我的订单</a>
                </dd>
                <dt>账户设置</dt>
                <dd>
                    <a href="vipMy.html">个人信息</a>
                    <a href="vipPwd.html">密码修改</a>
                    <a href="vipAdress.html">收货地址</a>
                </dd>
                <dt>客户服务</dt>
                <dd>
                    <a href="vipExit.html">网站使用条款</a>
                    <a href="vipTuihuo.html">网站免责声明</a>
                    <a href="message.html">在线留言</a>
                </dd>


            </dl><!--helpNav/-->
        </div><!--contLeft/-->
        <div class="contRight">
            <h1 class="vipName"><span>用户名：</span>${currentUser.username}</h1>
            <h2 class="oredrName">
                我的订单
            </h2>
            <table class="vipOrder">
                <c:forEach items="${orderList}" var="orderList">
                <tr>
                    <c:forEach items="${orderList.orderItemList}" var="orderItemList">
                    <td><a href="proinfo.bookDetail.html"><img src="${pageContext.request.contextPath}/static/bookImages/${orderItemList.book.image}" width="60" height="55"></a></td>
                        <td>${orderItemList.book.bookname}</td>

                    </c:forEach>
                    <td>${orderList.receiverName}</td>
                    <td>${orderList.orderNo}</td>
                    <td>￥${orderList.totalprices}<br/>支付宝支付</td>
                    <td>${orderList.orderdate}</td>
                    <td><a href="success.success.jsp"><strong>${orderList.orderstatus}</strong></a></td>
                </tr>
                </c:forEach>
            </table><!--vipOrder/-->
            <br/>
            <ul class="nav">
                ${pageCode}
            </ul>
        </div><!--contRight/-->
        <div class="clears"></div>
    </div><!--cont/-->
    <div class="inHelp">
        <div class="inHLeft">
            <h4>帮助中心</h4>
            <ul class="inHeList">
                <li><a href="help.html">购物指南</a></li>
                <li><a href="help.html">支付方式</a></li>
                <li><a href="help.html">售后服务</a></li>
                <li><a href="about.html">企业简介</a></li>
                <div class="clears"></div>
            </ul><!--inHeList/-->
        </div><!--inHLeft/-->
        <div class="inHLeft">
            <h4>会员服务</h4>
            <ul class="inHeList">
                <li><a href="reg.html">会员注册</a></li>
                <li><a href="login.login.jsp">会员登录</a></li>
                <li><a href="order.cart.jsp">购物车</a></li>
                <li><a href="order.cart.jsp">我的订单</a></li>
                <div class="clears"></div>
            </ul><!--inHeList/-->
        </div><!--inHLeft/-->
        <div class="inHRight">
            <h4>全国统一免费服务热线</h4>
            <div class="telBox">400-0000-0000</div>
            <div class="weibo">
                <wb:follow-button uid="2991975565" type="red_1" width="67" height="24"></wb:follow-button>
            </div>
        </div><!--inHRight/-->
        <div class="clears"></div>
    </div><!--inHelp/-->
    <div class="footer">
        <p>
            <a href="#">进入17官网</a>&nbsp;|&nbsp;
            <a href="index.index.jsp">商城首页</a>&nbsp;|&nbsp;
            <a href="product.booklist.jsp">促销中心</a>&nbsp;|&nbsp;
            <a href="order.cart.jsp">我的订单</a>&nbsp;|&nbsp;
            <a href="new.html">新闻动态</a>&nbsp;|&nbsp;
            <a href="login.login.jsp">会员中心</a>&nbsp;|&nbsp;
            <a href="help.htmll">帮助中心</a>
        </p>
        <p>
            版权所有：上海17实业有限公司 版权所有 Copyright 2010-2015 沪ICP备00000000号 <a href="http://www.mycodes.net/" target="_blank">源码之家</a>
        </p>
    </div><!--footer/-->
</div><!--mianCont/-->
<a href="#" class="backTop">&nbsp;</a>
</body>
</html>