<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>疫苗接种时间轴</title>
    <script src="javascript/jquery-1.10.2.js"></script>
    <script src="javascript/bootstrap.js"></script>
    <link href="http://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <link href="http://cdn.bootcss.com/font-awesome/4.4.0/css/font-awesome.min.css" rel="stylesheet">
    <link href="css/main.css" type="text/css" rel="stylesheet" />
</head>
<body>

<br /><br />
<div class="container" id="child" style="text-align: center;font-size: 22px;color: #0E2D5F">
    <span >您的孩子：</span>
</div>
<br /><br />
<div class="container">
    <div class="row">
        <div class="col-md-offset-3 col-md-6">
            <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function() {
        $.ajax({
            type: "GET",
            url: "user/main",
            async: true, //异步or同步
            dataType: "json",
            success: function (data) {
                if(data=='login'){
                    alert("太久未操作，身份已过期，请重新登录");
                    window.location.href="login.jsp";
                }
                var json=JSON.parse(data);
                var childName='<span>'+json[0].name+'的疫苗接种史</span>';
                $('#child').append(childName);
                json=json.sort(sortId);
                for (var i=0;i<json.length;i++){
                    var html='<div class="panel panel-default"><div class="panel-heading" role="tab" id="heading'+i+'">'+
                        '<h4 class="panel-title">'+
                        '<a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse'+i+'" aria-expanded="true" aria-controls="collapse'+i+'">'
                        +getTime(json[i].date)+'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+json[i].vaccinename+
                        '</a></h4></div>'+
                        '<div id="collapse'+i+'" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="heading'+i+'">'+
                        '<div class="panel-body"><p>'
                        +addHtml(json[i])+
                        '</p></div></div></div>';
                    $('#accordion').append(html);
                }
            }
        })
    })

    function sortId(a,b){
        return getSort(a.date)-getSort(b.date);
    }
    function addHtml(json) {
        var html='<span style="font-weight:bold">疫苗编号:</span>&nbsp;&nbsp;'+json.id+'<br />'+
            '<span style="font-weight:bold">疫苗名称:</span>&nbsp;&nbsp;'+json.vaccinename+'<br />'+
            '<span style="font-weight:bold">价格:</span>&nbsp;&nbsp;'+json.price.toFixed(2)+'元'+'<br />'+
            '<span style="font-weight:bold">功能介绍:</span>&nbsp;&nbsp;'+json.introduce+'<br />'+
            '<span style="font-weight:bold">生产日期:</span>&nbsp;&nbsp;'+getTime(json.makeday)+'<br />'+
            '<span style="font-weight:bold">保质日期:</span>&nbsp;&nbsp;'+getTime(json.keepday)+'<br />'+
            '<span style="font-weight:bold">已经注射人数:</span>&nbsp;&nbsp;'+json.vaccineChildCount+'<br />'+
            '<span style="font-weight:bold">注射百分比:</span>&nbsp;&nbsp;'+(json.vaccineChildCount/json.ChildCount)*100+'%';
        return html;
    }
    function getSort(date) {
        var tokens=date.split("-");
        return tokens[0]*10000+tokens[1]*100+tokens[2];
    }
    function getTime(date) {
        var tokens=date.split("-");
        var time=tokens[0]+"年"+tokens[1]+"月"+tokens[2]+"日";
        return time;
    }
</script>
</body>
</html>