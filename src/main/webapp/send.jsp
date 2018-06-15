<%@ page pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title></title>
    <link href="jquery/layui/css/layui.css" type="text/css" rel="stylesheet" />
    <script src="jquery/jquery-3.3.1.min.js"></script>
</head>
<body>
<form class="layui-form"> <!-- 提示：如果你不想用form，你可以换成div等任何一个普通元素 -->
    <br>
    <div class="layui-form-item">
        <label class="layui-form-label">用户名</label>
        <div class="layui-input-block">
            <input type="text" name="name" placeholder="请输入用户名" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">孩子姓名</label>
        <div class="layui-input-block">
            <input type="text" name="childname" placeholder="请输入孩子姓名" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">疫苗名称</label>
        <div class="layui-input-block">
            <input type="text" name="vaccinename" placeholder="请输入疫苗名称" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">手机号码</label>
        <div class="layui-input-block">
            <input type="text" name="phone" placeholder="请输入手机号" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">注射时间</label>
        <div class="layui-input-block">
            <input type="text" name="time" placeholder="请输入注射时间(格式：xxxx年xx月xx日)" autocomplete="off" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit lay-filter="submit">立即发送</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>

</form>
<script src="jquery/layui/layui.all.js"></script>
<script>
    layui.use('form', function(){
        var form = layui.form;
        form.on('submit(submit)', function(data){
            $.ajax({
                type: "POST",
                url: "admin/send",
                async: true, //异步
                data: data.field,
                contentType: "application/x-www-form-urlencoded",
                dataType:"text",
                success: function (data) {
                    if(data.indexOf("OK")>-1){
                        layer.msg('发送成功!');
                    }else {
                        layer.msg('发送失败!，请核对信息');
                    }

                }
            })
            return false;
        });
    });
</script>