//根据DOM元素的id构造出一个编辑器
var myTextArea=document.getElementById("code");
var editor = CodeMirror.fromTextArea(myTextArea, {
    //实现Java代码高亮
    mode: "text/x-python",
    //显示行号
    lineNumbers: true,
    //设置主题
    theme:"seti",
    //代码折叠
    lineWrapping: true,
    foldGutter: true,
    gutters: ["CodeMirror-linenumbers", "CodeMirror-foldgutter"],
    //括号匹配
    matchBrackets:true,
    //智能提示
    extraKeys:{"Tab":"autocomplete"}//ctrl-space唤起智能提示
});
//根据DOM元素的id构造出一个编辑器
var myConsole=document.getElementById("console");
var consoleShow = CodeMirror.fromTextArea(myConsole, {
    //实现shell代码高亮
    mode: "shell",
    //显示行号
    lineNumbers: true,
    //设置主题
    theme:"seti"
});
consoleShow.setOption("readOnly", true);    //设置只读
//文件目录部分
var zTreeObj,
    setting = {
    view: {
        selectedMulti: true,
        showLine: true,
        fontCss : {}
    },
    edit: {
        drag: {
            isMove: true,
            inner:true//拖拽后为同级节点，
        },//托拽操作配置
        enable: true,//节点可编辑
        showRemoveBtn: false,
        showRenameBtn: false,
        removeTitle:"删除",
        renameTitle:"重命名",
        editNameSelectAll: true
    },
    data: {
        keep: {
            parent:true, //删除子节点后父节点不变为叶子节点
            leaf:true
        }
    },
    treeNode: {
        checked:true
    },
    callback: {
        onDblClick: getFileTextByDbClick,//双击打开文件
        onRightClick: zTreeOnRightClick,//右键方法
        beforeRename: beforeRename
    }
};
$(function(){
    $.ajax({													// 请求MD5
        cache: false,
        url: "spark/getSimpleMd5",
        data: "",
        type: "POST",
        dataType: "text",
        success: function (result) {
            if(result.length===10)
            {
                webSocketSet(result.substring(1,9));
            }
            else {
                webSocketSet(result);
            }
        }
    });
});
var lineCount=0;
function webSocketSet(result) {

    var wsPath = "ws://59.69.101.206:30480/cloud";
    var webSocket = new WebSocket(wsPath + '/websocket/'+ result);
    webSocket.onerror = function (event) {
    };
    webSocket.onopen = function (event) {
    };
    webSocket.onmessage = function (event) {
        // 选中替换，一条根多条都替换，不选中则在光标处插入
        editor.setCursor(lineCount);
        consoleShow.replaceSelection(JSON.parse(event.data).value+"\r\n");
        lineCount++;
    };
}
$(function () {
    var zTreeNodes="";
    $.ajax({
        url: "spark/openAllProject",
        type: "POST",
        data: {},
        async: false,
        dataType: "json",
        success: function (data) {
            zTreeNodes = JSON.parse(data);
        }
    });
    zTreeObj = $.fn.zTree.init($("#tree"), setting, zTreeNodes);
});
//删除项目
function zTreeDelProject(node) {
    layer.confirm('确定要删除吗，不能恢复的哟，可不要怪我哦！', {icon: 6, title:'提示'}, function(index){
        $.ajax({
            url: "spark/deleteProject",
            type: "POST",
            data: {
                projectName:node.name
            },
            dataType: "text",
            success: function(data) {
                if (data==="false") {
                    layer.msg("删除失败!服务器开小差啦", {
                        icon: 5,//哭脸
                        time: 2000 //2秒关闭（如果不配置，默认是3秒）
                    });
                }else
                    zTreeObj.removeNode(node);
            }
        });
        layer.close(index);
    });
}
//删除文件夹
function zTreeDelFold(node) {
    var  path = getNodePath(node);
    layer.confirm('确定要删除吗，不能恢复的哟，可不要怪我哦！', {icon: 6, title:'提示'}, function(index){
        $.ajax({
            url: "spark/deleteFolder",
            type: "POST",
            data: {
                relativePath:path
            },
            dataType: "text",
            success: function(data) {
                if (data==="false") {
                    layer.msg("删除失败!服务器开小差啦", {
                        icon: 5,//哭脸
                        time: 2000 //2秒关闭（如果不配置，默认是3秒）
                    });
                }else
                    zTreeObj.removeNode(node);
            }
        });
        layer.close(index);
    });
}
//删除文件
function zTreeDelFile(node) {
    var  path = getNodePath(node);
    layer.confirm('确定要删除吗，不能恢复的哟，可不要怪我哦！', {icon: 6, title:'提示'}, function(index){
        $.ajax({
            url: "spark/deleteFile",
            type: "POST",
            data: {
                relativePath:path
            },
            dataType: "text",
            success: function(data) {
                if (data==="false") {
                    layer.msg("删除失败!服务器开小差啦", {
                        icon: 5,//哭脸
                        time: 2000 //2秒关闭（如果不配置，默认是3秒）
                    });
                }else
                    zTreeObj.removeNode(node);
            }
        });
        layer.close(index);
    });
}
//节点重命名
function zTreeReName(node) {
    zTreeObj.editName(node);
}
//重命名前判断输入是否为空以及文件名是否已存在
function beforeRename(treeId, treeNode,newName) {
    if (newName.length===0) {
        layer.alert('名字不能为空', {icon: 5},function(index){
            //do something
            layer.close(index);
        });
        setTimeout(function(){zTreeObj.editName(treeNode)}, 10);
    }
    var path = getNodePath(treeNode);
    //判断新文件名是否已存在
    $.ajax({
        url: "spark/renameFile",
        async:false,
        type: "POST",
        data: {
            relativePath : path,
            newName : newName
        },
        dataType: "text",
        success: function (data) {
            if (data==="400") {
                layer.alert('名字不能重复', {icon: 5});
            } else if (data==="201") {
                layer.alert("旧文件不存在", {icon: 5});
            }
        }
    });
}
//新建项目
function zTreeAddProject(parent) {
    layer.prompt({
        formType: 0,
        title: '请输入新的项目名'
    }, function(value, index, elem){
        $.ajax({
            url: "spark/createProject",
            type: "POST",
            data: {
                projectName:value
            },
            dataType: "text",
            success: function(data) {
                if (data==="400") {
                    layer.msg('项目已存在', {
                        icon: 5,
                        time: 2000 //2秒关闭（如果不配置，默认是3秒）
                    });
                }else if(data==="500") {
                    layer.msg('服务器开小差啦', {
                        icon: 5,
                        time: 2000 //2秒关闭（如果不配置，默认是3秒）
                    });
                }else if(data==="200") {
                    //拼装新节点对象
                    var nodes = {"name": value,"isParent": true };
                    zTreeObj.addNodes(parent, nodes);
                }
            }
        });
        layer.close(index);
    });
}
//新增文件夹
function zTreeAddFold(parent) {
    layer.prompt({
        formType: 0,
        title: '请输入新的文件夹名'
    }, function(value, index, elem){
        var relativePath = getNodePath(parent)+"/"+value;
        $.ajax({
            url: "spark/createFolder",
            type: "POST",
            data: {
                relativePath:relativePath
            },
            dataType: "text",
            success: function(data) {
                if (data==="400") {
                    layer.msg('文件夹已存在', {
                        icon: 5,
                        time: 2000 //2秒关闭（如果不配置，默认是3秒）
                    });
                }else if(data==="500") {
                    layer.msg('服务器开小差啦', {
                        icon: 5,
                        time: 2000 //2秒关闭（如果不配置，默认是3秒）
                    });
                }else if(data==="200") {
                    //拼装新节点对象
                    var nodes = {"name": value,"isParent": true };
                    zTreeObj.addNodes(parent, nodes);
                }
            }
        });
        layer.close(index);
    });
}
//新增文件
function zTreeAddFile(parent) {
    layer.prompt({
        formType: 0,
        title: '请输入新的文件名'
    }, function(value, index, elem){
        var relativePath = getNodePath(parent)+"/"+value;
        $.ajax({
            url: "spark/createFile",
            type: "POST",
            data: {
                relativePath:relativePath
            },
            dataType: "text",
            success: function(data) {
                if (data==="400") {
                    layer.msg('文件已存在', {
                        icon: 5,
                        time: 2000 //2秒关闭（如果不配置，默认是3秒）
                    });
                }else if(data==="500") {
                    layer.msg('服务器开小差啦', {
                        icon: 5,
                        time: 2000 //2秒关闭（如果不配置，默认是3秒）
                    });
                }else if(data==="200") {
                    //拼装新节点对象
                    var nodes = {"name": value,"isParent": false };
                    zTreeObj.addNodes(parent, nodes);
                }
            }
        });
        layer.close(index);
    });
}
function  zTreeSaveFile(node) {
    var filePath=getNodePath(node);
    var fileText = editor.getValue();
    $.ajax({
        url: "spark/createFileByCover",
        type: "POST",
        data: {
            relativePath:filePath,
            fileText:fileText
        },
        dataType: "json",
        success: function(data) {
            if (data!=="200") {
                layer.msg("保存失败", {
                    icon: 2,//不成功
                    time: 2000 //2秒关闭（如果不配置，默认是3秒）
                });
                return false;
            }
            layer.msg("保存成功", {
                icon: 1,//不成功
                time: 2000 //2秒关闭（如果不配置，默认是3秒）
            });
        }
    });
}
//获取鼠标实时位置
var leftX = 0;
var topY = 0;
function mousePosition(ev) {
    if (ev.pageX || ev.pageY) {
        return { x: ev.pageX, y: ev.pageY };
    }
    return {
        x: ev.clientX + document.body.scrollLeft - document.body.clientLeft,
        y: ev.clientY + document.body.scrollTop - document.body.clientTop
    };
}
function mouseMove(ev) {
    ev = ev || window.event;
    var mousePos = mousePosition(ev);
    leftX = mousePos.x;
    topY = mousePos.y;
}
document.onmousemove = mouseMove;
//右键方法
function zTreeOnRightClick() {
    var treeObj = $.fn.zTree.getZTreeObj("tree");
    var nodes = treeObj.getSelectedNodes();
    if(nodes.length>0)
    {
        $("#rMenu").css({
            top: topY + "px",
            left:leftX+"px",
            display: "block",
            "z-index": 1
        });
        if(nodes[0].level===0) {
            operateNode(nodes[0],["#newProject"]);
        }else if(nodes[0].level===1) {
            operateNode(nodes[0],["#newFold","#newFile","#reName","#delProject"])
        }
        else if (nodes[0].isParent) {
            operateNode(nodes[0],["#newFold","#newFile","#reName","#delFold"]);
        } else {
            operateNode(nodes[0],["#saveFile","#reName","#delFile","#runFile"]);
        }
    }
}
//显示右键菜单
function operateNode(node,operateArray) {
    for (var i = 0; i < operateArray.length; i++) {
        $(operateArray[i]).show();
    }
    $("#rMenu").hover(function () {
        $("#newProject").unbind("click");
        $("#newProject").click(function () {
            zTreeAddProject(node);
            $("#rMenu").hide();
        });
        $("#delProject").unbind("click");
        $("#delProject").click(function () {
            zTreeDelProject(node);
            $("#rMenu").hide();
        });
        $("#newFold").unbind("click");
        $("#newFold").click(function () {
            zTreeAddFold(node);
            $("#rMenu").hide();
        });
        $("#delFold").unbind("click");
        $("#delFold").click(function () {
            zTreeDelFold(node);
            $("#rMenu").hide();
        });
        $("#newFile").unbind("click");
        $("#newFile").click(function () {
            zTreeAddFile(node);
            $("#rMenu").hide();
        });
        $("#delFile").unbind("click");
        $("#delFile").click(function () {
            zTreeDelFile(node);
            $("#rMenu").hide();
        });
        $("#saveFile").unbind("click");
        $("#saveFile").click(function () {
            zTreeSaveFile(node);
            $("#rMenu").hide();
        });
        $("#reName").unbind("click");
        $("#reName").click(function () {
            zTreeReName(node);
            $("#rMenu").hide();
        });
        $("#runFile").unbind("click");
        $("#runFile").click(function () {
            startCompute(node);
            $("#rMenu").hide();
        });
        }, function(){
        for (var i = 0; i < operateArray.length; i++) {
            $(operateArray[i]).hide();
        }
    });
}
//显示文件内容
function getFileTextByDbClick() {
    var filePath=getFilePathByClick();
    if(filePath===null){
        return;
    }
    $.ajax({
        url: "spark/getFileText",
        type: "POST",
        data: {
            relativePath: filePath
        },
        dataType: "text",
        success: function (result) {
            result = result.slice(1,result.length-1);
            result = result.replaceAll('\\'+'n', '\n');
            result = result.replaceAll('\\'+'t','\t');
            result = result.replaceAll('\\'+'\"', '"');
            editor.setValue(result);
        }
    });
}
function getNodePath(node) {
    var temp=node.getParentNode();
    var path=node.name;
    while (temp)
    {
        path=temp.name+"/"+path;
        temp=temp.getParentNode();
    }
    return path;
}
function getFilePathByClick() {
    var sNodes = zTreeObj.getSelectedNodes();
    if (sNodes.length > 0) {
        if (!sNodes[0].isParent) {
            return getNodePath(sNodes[0]);
        }
    }
    return null;
}
//启动计算
function startCompute(node) {
    var projectName;
    var runFilePath=node.name;
    var temp=node.getParentNode();
    while (temp)
    {
        runFilePath=temp.name+"/"+runFilePath;
        temp=temp.getParentNode();
    }
    var pathArray=runFilePath.split("/");
    if(pathArray.length>2)
    {
        projectName=pathArray[1];
    }
    $.ajax({
        url: "spark/startCompute",
        type: "POST",
        data: {
            projectName:projectName,
            runFilePath: runFilePath,
            cpu:"4",
            memory:"1"
        },
        dataType: "text",
        success: function (result) {
            if(result==="200") {
            }

        }
    });
}
// 文件树工具条
$(".catalogToolBarUl").moveline({
    color:'#ecec6a',
    position:'inner',
    animateType:'easeOutBounce',
    click:function(ret){
        switch (ret.index){
            case 0: {
                layer.msg("功能尚未开发", {
                    icon: 5,//不成功
                    time: 2000 //2秒关闭（如果不配置，默认是3秒）
                });
                break;
            }
            case 1: {
                layer.msg("功能尚未开发", {
                    icon: 5,//不成功
                    time: 2000 //2秒关闭（如果不配置，默认是3秒）
                });
                break;
            }
        }
    }
});
// 代码编辑框工具条
$(".codeToolBarUl").moveline({
    color:'#ecec6a',
    position:'inner',
    animateType:'easeOutBounce',
    click:function(ret){
        switch (ret.index){
            case 0:{
                layer.msg("功能尚未开发", {
                    icon: 5,//不成功
                    time: 2000 //2秒关闭（如果不配置，默认是3秒）
                });
                break;
            }

            case 1:{
                layer.msg("功能尚未开发", {
                    icon: 5,//不成功
                    time: 2000 //2秒关闭（如果不配置，默认是3秒）
                });
                break;
            }
            case 2:{
                layer.msg("功能尚未开发", {
                    icon: 5,//不成功
                    time: 2000 //2秒关闭（如果不配置，默认是3秒）
                });
                break;
            }
            case 3:{
                layer.msg("功能尚未开发", {
                    icon: 5,//不成功
                    time: 2000 //2秒关闭（如果不配置，默认是3秒）
                });
                break;
            }
        }
    }
});// 编译输出框工具条
$(".consoleToolBarUl").moveline({
    color:'#ecec6a',
    position:'inner',
    animateType:'easeOutBounce',
    click:function(ret){
        switch (ret.index){
            case 0: {
                layer.msg("功能尚未开发", {
                    icon: 5,//不成功
                    time: 2000 //2秒关闭（如果不配置，默认是3秒）
                });
                break;
            }
            case 1:{
                layer.confirm('确定要清空吗，不能恢复的哟，可不要怪我哦！', {icon: 6, title:'提示'}, function(index) {
                    consoleShow.setValue("");
                    lineCount=0;
                    layer.close(index);
                });
            }
        }
    }
});

