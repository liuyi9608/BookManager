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
    <script src="${pageContext.request.contextPath}/static/js/MagicZoom.js" type="text/javascript"></script>
    <script type="text/javascript">
        function addShoppingCart(bookid) {
            if ('${currentUser.username}' == '') {
                alert("请先登录，然后购物！");
            } else {
                $.post("${pageContext.request.contextPath}/shopping/cart.html", {bookid: bookid},
                    function (result) {
                        if (result == "success") {
                            alert("已成功加入购物车！");
                            location.reload();
                        }
                    }
                );
            }
        }

        /* function goBuy(productId){
             if('${currentUser.username}'==''){
                alert("请先登录，然后购物！");
            }else{
                window.location.href="shopping_buy.action?productId="+productId;
            }
        }*/
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
                            <a href="vip.usercenter.jsp"><img src="${pageContext.request.contextPath}/static/images/mychunlv.jpg"
                                                              width="112"
                                                              height="34"/></a>
                        </div>
                        <!--myChunlv/-->

                    </c:when>
                    <c:otherwise>
                        <strong class="red">您还未登录！请前去<a href="${pageContext.request.contextPath}/toLogin.html">登陆</a></strong>
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
        当前位置：<a href="${pageContext.request.contextPath}/toIndex.html">首页</a> &gt; <a href="#" class="posCur">商品详情</a>
    </div><!--positions/-->
    <div class="cont">
        <div class="contLeft">
            <ul class="leftPorNav">
                <c:forEach var="category" items="${categorys }">
                    <li>
                        <a href="${pageContext.request.contextPath}/book/list.html?categoryid=${category.id}">${category.categoryname }</a>
                    </li>
                    <option value="${category.id }"></option>
                </c:forEach>

            </ul><!--InPorNav/-->
        </div><!--contLeft/-->
        <div class="contRight" style="border:0;">
            <div class="proBox">
                <div id="tsShopContainer">
                    <div id="tsImgS"><a href="images/01.jpg" title="Images" class="MagicZoom" id="MagicZoom"><img
                            width="300" height="300"
                            src="${pageContext.request.contextPath}/static/bookImages/${currentBook.image}"/></a>
                    </div>
                    <div id="tsPicContainer">
                        <div id="tsImgSArrL" onclick="tsScrollArrLeft()"></div>
                        <div id="tsImgSCon">
                            <ul>

                                <li onclick="showPic(1)" rel="MagicZoom"><img height="42" width="42"
                                                                              src="${pageContext.request.contextPath}/static/bookImages/${currentBook.image}"
                                                                              tsImgS="${pageContext.request.contextPath}/static/bookImages/${currentBook.image}"/>
                                </li>

                            </ul>
                        </div>
                        <div id="tsImgSArrR" onclick="tsScrollArrRight()"></div>
                    </div>
                    <img class="MagicZoomLoading" width="16" height="16"
                         src="${pageContext.request.contextPath}/static/images/loading.gif" alt="Loading..."/>
                    <script src="${pageContext.request.contextPath}/static/js/ShopShow.js"></script>
                </div><!--tsShopContainer/-->
                <div class="proBoxRight">
                    <h3 class="proTitle">${currentBook.bookname}</h3>
                    <div>商品编号： ${currentBook.id}</div>
                    <div>会员价：<strong class="red">¥${currentBook.price}</strong></div>
                    <div>单位：本</div>
                    <div>作者：${currentBook.writer}</div>
                    <div>库存：<strong class="red">[有货] </strong> 从上海发货</div>

                    <div class="shuliang2">
                        数量： <input type="text" value="1"/>
                    </div><!--shuliang2/-->
                    <div class="gc">
                        <a href="javascript:addShoppingCart(${currentBook.id })"><img
                                src="${pageContext.request.contextPath}/static/images/goumai.png"
                                width="117" height="36"/></a>&nbsp;&nbsp;

                    </div><!--gc/-->
                </div><!--proRight/-->
                <div class="clears"></div>
            </div><!--proBox/-->

        </div><!--fangList/-->


    </div><!--contRight/-->
    <div class="clears"></div>



</div><!--mianCont/-->
</body>
</html>
