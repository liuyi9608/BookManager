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
                <li><a href="${pageContext.request.contextPath}/toIndex.do">商城首页</a></li>
                <li class="navCur"><a href="${pageContext.request.contextPath}/book/list.html">所有图书</a></li>
                <li><a href="login.login.jsp">会员中心</a></li>
                <li><a href="help.html">帮助中心</a></li>
                <div class="clears"></div>
            </ul><!--nav/-->
        </div><!--pntRight/-->
        <div class="clears"></div>
    </div><!--pnt/-->
    <div class="positions">
        当前位置：<a href="index.index.jsp">首页</a> &gt; <a href="#" class="posCur">填写核对订单</a>
    </div><!--positions/-->
    <div class="cont">
        <div class="carImg"><img src="${pageContext.request.contextPath}/static/images/car2.jpg" width="961"
                                 height="27"/></div>
        <h4 class="orderTitle">收货地址</h4>
        <table class="ord">
            <tr>
                <td width="30%">
                    <input type="radio"/> ${currentUser.username}
                </td>
                <td width="50%">
                    ${currentUser.address} ,${currentUser.address}
                </td>
                <td>
                    <span class="green upd">[修改]</span> | <span class="green add">[添加]</span>
                </td>
            </tr>
        </table><!--ord/-->
        <div class="address">

            <div class="addList">
                <label><span class="red">* </span>详细地址:</label>
                <input type="text" name="receiverAddress"/>
            </div><!--addList-->
            <div class="addList">
                <label><span class="red">* </span>收件人:</label>
                <input type="text" name="receiverName"/>
            </div><!--addList-->
            <div class="addList">
                <label><span class="red">* </span>手机号码:</label>
                <input type="text" name="receiverPhone"/>
            </div><!--addList-->

        </div><!--address/-->
        <h4 class="orderTitle">支付方式</h4>
        <ul class="zhiList">
            <li>支付宝-余额支付</li>
            <div class="clears"></div>
        </ul><!--zhiList/-->

        <div class="zhifufangshi">
            <ul class="yinhang">
                <li><input type="radio"/><img src="${pageContext.request.contextPath}/static/images/zhifubao.jpg"/></li>
                <div class="clear"></div>
            </ul>
        </div><!--zhzhifufangshii/-->
        <h4 class="orderTitle">购物清单</h4>
        <table class="orderList">
            <tr>
                <th width="430">商品</th>
                <th width="135">单价</th>
                <th width="135">数量</th>
                <th width="135">总金额</th>
                <th>操作</th>
            </tr>
            <c:forEach items="${shoppingCart.shoppingCartItems }" var="shoppingCartItem">
                <tr class="bookTr" id="bookTr${shoppingCartItem.book.id}">
                    <td>
                        <dl>
                            <dt><a href="proinfo.bookDetail.html"><img
                                    src="${pageContext.request.contextPath}/static/bookImages/${shoppingCartItem.book.image}"
                                    width="85" height="85"/></a>
                            </dt>
                            <dd>${shoppingCartItem.book.bookname}<br/>作者:${shoppingCartItem.book.writer}<br/><span
                                    class="red">有货：</span>从上海出发
                            </dd>
                            <div class="clears"></div>
                        </dl>
                    </td>
                    <td><strong class="red">￥
                        <label class="price"
                               id="price${shoppingCartItem.book.id}">${shoppingCartItem.book.price}</label>
                    </strong></td>
                    <td>

                        <div class="jia_jian">
                            <input type="hidden" id="bookId" value="${shoppingCartItem.book.id }"/>
                            <img src="${pageContext.request.contextPath}/static/images/jian.jpg" width="21" height="25"
                                 class="jian" id="jian"/>
                            <input type="text" class="shuliang" value="${shoppingCartItem.count }"/>
                            <img src="${pageContext.request.contextPath}/static/images/jia.jpg" width="21" height="25"
                                 class="jia" id="jia"/>
                        </div>
                    </td>
                    <td><strong class="red">￥
                        <label class="bookItemTotal"
                               id="bookItemTotal${shoppingCartItem.book.id}">${shoppingCartItem.book.price*shoppingCartItem.count }</label>
                    </strong></td>
                    <td>
                        <a href="javascript:deleteThisBook(${shoppingCartItem.book.id})" class="green">删除</a></td>
                </tr>
            </c:forEach>
        </table><!--orderList/-->
        <table class="zongjia" align="right">
            <tr>
                <td width="120" align="left">商品总价：</td>
                <td width="60"><strong class="red">+7.88</strong></td>
            </tr>
            <tr>
                <td width="120" align="left">合计：</td>
                <td><strong class="red">+2271.88</strong></td>
            </tr>
            <tr>
                <td colspan="2" style="height:50px;">
                    <a href="success.success.jsp"><img src="${pageContext.request.contextPath}/static/images/tijao.png"
                                                       width="142" height="32"/></a>
                </td>
            </tr>
        </table><!--zongjia/-->
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
