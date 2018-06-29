<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>注册界面</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/reset.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/common.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/font-awesome.min.css"/>
    <script type="text/javascript">
        function checkIsExist() {
            var username = $.trim($("#username").val());
            $("#userErrorInfo").html("");

            $.post("${pageContext.request.contextPath}/user/isExist.do",
                {username: username},
                function (data) {
                    var data = eval('(' + data + ')');
                if (data == "success") {
                    $("#userErrorInfo").html("用户名可用");
                } else {
                    $("#userErrorInfo").html("用户名已存在，请重新输入！");
                    $("#username").focus();

                }
            });


        }

        function checkForm() {
            var username = $("#username").val();
            var password = $("#password").val();
            var repassword = $("#repassword").val();
            var email = $("#email").val();
            var myemail = /^[a-zA-Z0-9_-]+@([a-zA-Z0-9]+\.)+(com|cn|net|org)$/;
            if (username == null || username == "") {
                $("#error").html("用户名不能为空！");
                return false;
            }
            if (password == null || password == "") {
                $("#error").html("密码不能为空！");
                return false;
            }
            if (repassword != password) {
                $("#error").html("两次密码输入不一样！");
                return false;
            }
            if (!myemail.test(email)) {
                $("#error").html("邮箱格式不正确！");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
<div class="wrap login_wrap">
    <div class="content">

        <div class="logo"></div>

        <div class="login_box">

            <div class="login_form">
                <div class="login_title">
                    注册
                </div>
                <form action="${pageContext.request.contextPath}/user/register.do" method="post"
                      onsubmit="return checkForm()">

                    <div class="form_text_ipt">
                        <input onblur="checkIsExist();" id="username" name="username" type="text" placeholder="用户名">
                        <font id="userErrorInfo" color="red"></font>
                    </div>
                    <div class="ececk_warning"><span>用户名不能为空</span></div>
                    <div class="form_text_ipt">
                        <input id="password" name="password" type="password" placeholder="密码">
                    </div>
                    <div class="ececk_warning"><span>密码不能为空</span></div>
                    <div class="form_text_ipt">
                        <input id="repassword" name="repassword" type="password" placeholder="重复密码">
                    </div>
                    <div class="ececk_warning"><span>密码不能为空</span></div>
                    <div class="form_text_ipt">
                        <input id="email" name="email" type="text" placeholder="邮箱">
                    </div>
                    <div class="ececk_warning"><span>邮箱不能为空</span></div>
                    <div class="form_text_ipt">
                        <input id="address" name="address" type="text" placeholder="收货地址">
                    </div>
                    <div class="ececk_warning"><span>收货地址不能为空</span></div>
                    <div class="form_text_ipt">
                        <input id="tel" name="tel" type="text" placeholder="联系方式">
                    </div>
                    <div class="ececk_warning"><span>验证码不能为空</span></div>

                    <div class="form_btn">
                        <button type="submit">注册</button>
                    </div>
                    <div class="form_reg_btn">
                        <span><font color="red" id="error">${errorInfo }</font></span>
                    </div>

                    <div class="form_reg_btn">
                        <span>已有帐号？</span><a href="${pageContext.request.contextPath}/toLogin.html">马上登录</a>
                    </div>
                </form>
                <div class="other_login">
                    <div class="left other_left">
                        <span>其它登录方式</span>
                    </div>
                    <div class="right other_right">
                        <a href="#"><i class="fa fa-qq fa-2x"></i></a>
                        <a href="#"><i class="fa fa-weixin fa-2x"></i></a>
                        <a href="#"><i class="fa fa-weibo fa-2x"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/common.js"></script>

</body>
</html>
