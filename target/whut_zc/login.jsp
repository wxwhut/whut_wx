<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>登录页面</title>
    <link rel="stylesheet" type="text/css" href="css/login.css">
    <script src="jquery/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="zTree/layer/layer.js"></script>
    <link rel="stylesheet" href="zTree/layer/theme/default/layer.css">
</head>
<body>
<div class="htmleaf-container">
    <div class="wrapper">
        <div class="container">
            <h1>欢迎您进入儿童预防接种信息管理系统</h1>
            <form class="form">
                <input type="text" id="usernameOrEmailOrPhone" placeholder="用户名/email/手机号码">
                <input type="password" id="password" placeholder="password">
                <button type="submit" id="login-button">登录</button>
                <button type="submit" id="register-button">注册</button>
            </form>
        </div>
        <ul class="bg-bubbles">
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
        </ul>
    </div>
</div>
    <div id="footer" style="text-align:center;margin:630px; font:normal 8px 'MicroSoft YaHei';color:#000000">
    <p>儿童预防接种信息管理系统v1.0  Posted by: whut_zc</p>
    <p>Contact information: <a href="mailto:505724935@qq.com">505724935@qq.com</a>.</p>
</div>

<script>
    $('#login-button').click(function (event) {
        event.preventDefault();
        $.ajax({
            url: "user/login",
            type: "POST",
            data: {
                usernameOrEmailOrPhone:$("#usernameOrEmailOrPhone").val(),
                password:$("#password").val()
            },
            dataType: "text",
            success: function (result) {
                if(result==="200"){
                    $('form').fadeOut(500);//使用淡出效果隐藏表单
                    $('.wrapper').addClass('form-success');
                    syncAllUrlWhenLogin();
                    window.location.href = "user.jsp";
                }
                else if(result==="1"){
                    $('form').fadeOut(500);//使用淡出效果隐藏表单
                    $('.wrapper').addClass('form-success');
                    syncAllUrlWhenLogin();
                    window.location.href = "admin.jsp";
                }
                else if(result==="403"){
                    showMessage("用户不存在",$("#usernameOrEmailOrPhone"));
                }
                else if(result==="404"){
                    showMessage("密码错误",$("#password"));
                }else {
                    showMessage("系统故障，请重试",$("#login-button"));
                    $('form').fadeOut(1000);//使用淡出效果隐藏表单
                    window.location.href = "login.jsp"
                }
            }
        });
    });
    $("#register-button").click(function (event) {
        event.preventDefault();
        $('form').fadeOut(500);//使用淡出效果隐藏表单
        window.location.href="register.jsp";
    });
    function showMessage(msg, domObj) {
        layer.tips(msg, domObj,{tips:[3,'#000000']});//弹出框加回调函数
    }
    function syncAllUrlWhenLogin() {
        $.ajax({
            url: "instance/syncMultiUrl",
            type: "POST",
            data: "",
            dataType: "text",
            success: function (result) {
                if (result==="200") {
                    window.location.href = "main";
                } else {
                    layer.msg("登陆不成功，请重新登陆", {
                        icon: 5,//不成功
                        time: 2000 //2秒关闭（如果不配置，默认是3秒）
                    }, function () {
                        window.location.href = "login.jsp";
                    });
                }
            }
        });
    }
</script>
</body>
</html>