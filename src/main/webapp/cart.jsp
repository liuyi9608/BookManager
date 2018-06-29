<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
            $(".jia").click(function () {
                var t = $(this).parent().find('input[class=shuliang]');
                t.val(parseInt(t.val()) + 1);
                var bookId = $(this).parent().find('input[id=bookId]').val();
                var price = $("#price" + bookId).html();
                $("#bookItemTotal" + bookId).html(price * t.val());
                refreshSession(bookId, t.val());
                setTotal();
            });

            $(".jian").click(function () {
                var t = $(this).parent().find('input[class=shuliang]');
                t.val(parseInt(t.val()) - 1);
                if (parseInt(t.val()) < 0) {
                    t.val(0);
                }
                var bookId = $(this).parent().find('input[id=bookId]').val();
                var price = $("#price" + bookId).html();
                $("#bookItemTotal" + bookId).html(price * t.val());
                refreshSession(bookId, t.val());
                setTotal();

            });

            function refreshSession(bookId, count) {
                $.post("${pageContext.request.contextPath}/shopping/updateShoppingCartItem.html", {
                        bookId: bookId,
                        count: count
                    },
                    function (result) {
                        if (result != "success") {
                            alert("系统出错！");
                        }
                    }
                );
            }

            function setTotal() {
                var s = 0;
                $(".bookTr").each(function () {
                    var n = $(this).find('input[class=shuliang]').val();
                    var price = $(this).find('label[class=price]').html();
                    s += n * price;

                });


                $("#book_total").html(s);
            }

            setTotal();

        });

        function buy() {

            var receiverAddress = $(" #receiverAddress ").val();
            var receiverName = $(" #receiverName ").val();
            var receiverPhone = $(" #receiverPhone ").val();
            location.href = "${pageContext.request.contextPath}/shopping/buy.html?receiverAddress=" + receiverAddress + "&receiverName=" + receiverName + "&receiverPhone=" + receiverPhone;
        }


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
        当前位置：<a href="index.index.jsp">首页</a> &gt; <a href="#" class="posCur">购物车</a>
    </div><!--positions/-->
    <div class="cont">
        <div class="carImg"><img src="${pageContext.request.contextPath}/static/images/car1.jpg" width="961"
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
                <input type="text" id="receiverAddress" name="receiverAddress"/>
            </div><!--addList-->
            <div class="addList">
                <label><span class="red">* </span>收件人:</label>
                <input type="text" id="receiverName" name="receiverName"/>
            </div><!--addList-->
            <div class="addList">
                <label><span class="red">* </span>手机号码:</label>
                <input type="text" id="receiverPhone" name="receiverPhone"/>
            </div><!--addList-->

        </div><!--address/-->



        </div><!--zhzhifufangshii/-->

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
            <tr>
                <td colspan="6">
                    <div class="shanchu"><img src="${pageContext.request.contextPath}/static/images/lajio.jpg"/> 全部删除
                    </div>
                </td>
            </tr>
        </table><!--orderList/-->
        <div class="zongji">
            总计(不含运费)：<strong class="red">￥<label id="book_total"></label></strong>
        </div><!--zongji/-->
        <div class="jiesuan">
            <a href="${pageContext.request.contextPath}/book/list.html" class="jie_1">继续购物&gt;&gt;</a>
            <a href="javascript:buy()" class="jie_2">立即结算&gt;&gt;</a>
            <div class="clears"></div>
        </div><!--jiesuan/-->
        <div class="clears"></div>
    </div><!--cont/-->

<script type="text/javascript">
    function deleteThisBook(bookId) {
        if (confirm("您确定要删除这个图书吗？")) {
            $.post("${pageContext.request.contextPath}/shopping/removeShoppingCartItem.html", {
                    bookId: bookId,
                },
                function (result) {
                    if (result == "success") {
                        alert("删除成功！");
                        $("#bookTr" + bookId).remove();
                    } else {
                        alert("系统出错！");
                    }
                }
            );
        }
    }
</script>
</body>
</html>
