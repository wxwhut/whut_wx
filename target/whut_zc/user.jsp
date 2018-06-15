<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <script src="javascript/jquery-1.10.2.js"></script>
    <title></title>
</head>
<body>

<br /><br />
<div class="container">

</div>
<script>
    $.ajax({
        type: "GET",
        url: "user/main",
        async: true, //异步or同步
        dataType: "json",
        success: function (data) {
            if(data=='login'){
                window.location.href="login.jsp";
            }else{
                if(data!==''&&data!==null){
                    window.location.href="main.jsp";
                }else{
                    window.location.href="addChild.jsp";
                }
            }
        }
    })


</script>
</body>
</html>