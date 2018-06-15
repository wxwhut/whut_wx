<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>注册用户</title>
    <link rel="stylesheet" type="text/css" href="css/register.css">
    <script src="jquery/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="zTree/layer/layer.js"></script>
    <link rel="stylesheet" href="zTree/layer/theme/default/layer.css">
</head>
<body>
<div class="htmleaf-container">
    <div class="wrapper">
        <div class="container">
            <h1>您好，防范以未然，欢迎您注册</h1>
            <form class="form">
                <input type="text" id="username" placeholder="用户名">
                <input type="password" id="password" placeholder="输入密码">
                <input type="password" id="passwordconfirm" placeholder="确认密码">
                <input type="text" id="email" placeholder="电子邮件">
                <input type="text" id="phone" placeholder="手机电话">
                <button type="submit" id="register-button">注册</button>
                <button type="button" id="login-button">登录</button>
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
</div>
<div id="footer" style="text-align:center;margin:685px; font:normal 8px 'MicroSoft YaHei';color:#000000">
    <p>儿童预防接种信息管理系统v1.0  Posted by: whut_zc</p>
    <p>Contact information: <a href="mailto:505724935@qq.com">505724935@qq.com</a>.</p>
</div>


<script>
    $('#login-button').click(function () {
        window.location.href="login.jsp";
    })
    $('#register-button').click(function (event) {
        if(!checkRegister($("#username"),$("#password"),$("#email"),$("#phone"),$("#passwordconfirm"))) {
            return false;
        }
        event.preventDefault();
        $.ajax({
            url: "user/register",
            type: "POST",
            data: {
                username:$("#username").val(),
                password: $("#password").val(),
                phone:$("#phone").val(),
                email:$("#email").val()
            },
            dataType: "text",
            success: function (result) {
                if(result==="200"){
                    $('form').fadeOut(500);//使用淡出效果隐藏表单
                    $('.wrapper').addClass('form-success');
                    window.location.href="login.jsp";
                }else if(result==="400"){
                    showMessage("用户名已注册",$("#username"));
                } else if(result==="401"){
                    showMessage("手机号已注册",$("#email"));
                }
                else if(result==="402"){
                    showMessage("邮箱已注册",$("#phone"));
                }else {
                    showMessage("注册失败，请稍后再试",$("#register-button"));
                }
            }
        });
    });
    function checkRegister(username,password,email,phone,passwordconfirm) {
        var emailRegex = /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
        if(!checkLength(username, "用户名", 5, 20)) {
            return false;
        }else if(!checkLength(password, "密码", 5, 20)) {
            return false;
        }else if(!checkLength(email, "邮箱", 5, 20)||!checkRegexp(email, emailRegex, "邮箱输入不合法，请输入合法邮箱")) {
            return false;
        }else if(!checkLength(phone, "手机号码", 11, 11)){
            return false;
        }else if(!check(password,passwordconfirm)){
            return false;
        }else return checkRegexp(password, /^([0-9a-zA-Z])+$/, "密码只允许由字母和数字组成");
    }
    function check(p,pf) {
        if(p.val()!=pf.val()){
            showMessage("请输入一致密码",p);
            return false;
        }else {
            return true;
        }
    }
    function checkLength( o, n, min, max ) {
        if ( o.val().length > max || o.val().length < min ) {
            if(min!=max) {
                showMessage(n + "的长度应该在" + min + "和" + max + "之间", o);
            }else {
                showMessage(n + "的长度应该为" + min + "位", o);
            }
            return false;
        } else {
            return true;
        }
    }
    function checkRegexp(o, regexp, tip ) {
        if (!(regexp.test(o.val()))) {
            showMessage(tip,o);
            return false;
        } else {
            return true;
        }
    }
    function showMessage(msg, domObj) {
        layer.tips(msg, domObj,{tips:[3,'#000000']});//弹出框加回调函数
    }

</script>

</body>
</html>