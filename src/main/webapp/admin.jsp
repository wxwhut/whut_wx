<%@ page pageEncoding="UTF-8"%>
<!doctype html public "-//w3c//dtd xhtml 1.0 transitional//en">
<html>

<head>
	<title>系统管理</title>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<link href="css/base.css" type="text/css" rel="stylesheet" />
	<link href="css/editTable.css" type="text/css" rel="stylesheet" />
	<script src="jquery/jquery-3.3.1.min.js"></script>
	<script language="javascript" type="text/javascript" src="javascript/editTable.js"></script>
</head>

<body>
<table class="edtitable">
	<thead>
	<tr>
		<th colspan="8">疫苗管理</th>
	</tr>
	</thead>

	<table class="edtitable" id = "table">
		<tr >
			<th data-override="id">疫苗编号</th>
			<th data-override="vaccinename">疫苗名称</th>
			<th data-override="makeday">生产日期</th>
			<th data-override="keepday">保质日期</th>
			<th data-override="price">价格</th>
			<th data-override="introduce">功能介绍</th>
			<th data-override="pnumber">已接种人数</th>
			<th class="del-col">操作</th>
		</tr>
	</table>

	<table class="edtitable" id = "table2">
		<tr class="append-row">
			<td colspan="8" align="right" id="buttons">
				<input type="button" id="addBtn" value="新 增" />
				<input type="button" id="button-save" value="保 存"/>
				<input type="button" id="button-quit" value="退 出"/>
			</td>
		</tr>
	</table>
</table>
</body>
<script>
    $(document).ready(function(){
        $.ajax({
            type: "GET",
            url: "admin/show",
            async: true, //异步or同步
            dataType:"json",
            success: function (json) {
                var tab="";
                for (var i = 0; i < json.length; i++){
                    tab+="<tr><td class='id'>"+json[i].id+"</td>"
                        +"<td class='vaccinemname'>"+json[i].vaccinename+"</td>"
                        +"<td class='makeday'>"+json[i].makeday+"</td>"
                        +"<td class='keppday'>"+json[i].keepday+"</td>"
                        +"<td class='price'>"+json[i].price+"</td>"
                        +"<td class='introduce'>"+json[i].introduce+"</td>"
                        +"<td class='pnumber'>"+json[i].pnumber+""+"</td><td class='del-col'><a href='javascript:void(0);' class='delBtn'>删除</a></td></tr>";
                };
                $('#table').append(tab);
                $("tbody tr:odd").css("background-color","#EEEEEE");
                var del='"delete":[';
                $(".delBtn").click(function(){
                    var td=$(this).parent().parent().find('.id').html();
                    del+=td+',';
                    $(this).parent().parent().remove();
                });
                $('#button-quit').click(function(){
                    $.ajax({
                        url: "user/quit",
                        type: "GET",
                        data:"",
                        success:function () {
                            window.location.href="login.jsp";
                        }
                    });

                });
                $('#button-save').click( function() {
                    var flagSum=1;
                    var tab = $('#table2').find("input").not("#addBtn").not("#button-quit").not("#button-save");
                    var tds = $('#table2').find("td").not(".del-col").not("#buttons");
                    if (tds.length==tab.length){
                        if(tab.length>=7) {
                            for (var i = 0; i < (tab.length) / 7; i++) {
                                if (tab[i * 7].value == "" ||
                                    tab[i * 7 + 1].value == "" ||
                                    tab[i * 7 + 2].value == "" ||
                                    tab[i * 7 + 3].value == "" ||
                                    tab[i * 7 + 4].value == "" ||
                                    tab[i * 7 + 5].value == "" ||
                                    tab[i * 7 + 6].value == "") {
                                    flagSum = 0;
                                }
                            }
                        }
                        if(flagSum){
                            if(del.length!=10&&del!=''){
                                del=del.substr(0,del.length-1);
                                del+=']';
                                var tableJSON='{'+del+',';
                            }else{
                                del='';
                                var tableJSON='{';
                            }
                            tableJSON=tableToJSON($('#table2')).length?tableJSON+tableToJSON($('#table2')):((tableJSON.length==1)?tableJSON:tableJSON.substr(0,tableJSON.length-1));
                            tableJSON+='}';
                            $.ajax({
                                type: "POST",
                                url: "admin/changeVaccine",
                                async: true, //异步or同步
                                dataType:"text",
                                contentType:"application/json",
                                data: tableJSON,
                                success:function (result) {
                                    result=result.substr(1,result.length-2);
                                    if (result=="404"){
                                        window.location.href="error.jsp";
                                    }else if(result=="have"){
                                        alert("该ID已存在，请核实ID后重试");
                                    } else if(result=="none"){
                                        alert("您未做任何修改");
                                    } else{
                                        var flag=result.split(".");
                                        if(flag[0]==0&&flag[1]!=0){
                                            alert("成功删除"+flag[1]+"条记录");
                                            location.reload();
                                        }else if(flag[0]!=0&&flag[1]==0){
                                            alert("成功新增"+flag[0]+"条记录");
                                            location.reload();
                                        }else{
                                            alert("成功新增"+flag[0]+"条记录,成功删除"+flag[1]+"条记录");
                                            location.reload();
                                        }
                                    }
                                }
                            });
                            del='"delete":[';
                        }else alert("请输入完整信息");
                    }else alert("请输入完整信息");
                });
                function tableToJSON(table) {
                    var tab = table.find("input").not("#addBtn").not("#button-quit").not("#button-save");
                    var json='"add":';
                    if(tab.length>=7){
                        json+='[';
                        for (var i = 0; i < (tab.length)/7; i++) {
                            json+='{"id": "'+tab[i*7].value+'",'+
                                '"vaccinename":"'+tab[i*7+1].value+'",'+
                                '"makeday":"'+tab[i*7+2].value+'",'+
                                '"keepday":"'+tab[i*7+3].value+'",'+
                                '"price":"'+tab[i*7+4].value+'",'+
                                '"introduce":"'+tab[i*7+5].value+'",'+
                                '"pnumber":"'+tab[i*7+6].value+'"},';
                        }
                        json=json.substr(0,json.length-1);
                        json+=']';

                    }
                    if (json.length==6)json='';
                    return json;
                }
            }
        });
    });


</script>
</html>