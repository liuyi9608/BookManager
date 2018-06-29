<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>登录界面</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/reset.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/common.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/font-awesome.min.css"/>
</head>
<SCRIPT type="text/javascript">

    function checkForm(){
        var username=$("#username").val();
        var password=$("#password").val();
        if(username==null||username==""){
            $("#error").html("用户名不能为空！");
            return false;
        }
        if(password==null||password==""){
            $("#error").html("密码不能为空！");
            return false;
        }
        return true;
    }
</SCRIPT>
<body>
<div class="wrap login_wrap">
    <div class="content">
        <div class="logo"></div>
        <div class="login_box">

            <div class="login_form">
                <div class="login_title">
                    管理员登录
                </div>
                <form action="${pageContext.request.contextPath}/user/admin/login.html" method="post" onsubmit="return checkForm()">

                    <div class="form_text_ipt">
                        <input id="username" name="username" type="text" placeholder="用戶名">
                    </div>
                    <div class="ececk_warning"><span>用戶名</span></div>
                    <div class="form_text_ipt">
                        <input id="password" name="password" type="password" placeholder="密码">
                    </div>
                    <div class="ececk_warning"><span>密码不能为空</span></div>
                    <div class="form_check_ipt">
                        <div class="left check_left">
                            <label><input name="" type="checkbox"> 下次自动登录</label>
                        </div>

                    </div>
                    <div class="form_btn">
                        <button type="submit">登录</button>
                    </div>
                    <div class="form_btn">
                        <span><font color="red"  id="error">${errorInfo }</font></span>
                    </div>
                    <div class="form_reg_btn">
                        <span>还没有帐号？</span><a href="${pageContext.request.contextPath}/toRegister.html">马上注册（普通用户）</a>
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
