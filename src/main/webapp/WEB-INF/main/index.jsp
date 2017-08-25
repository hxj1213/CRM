<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@include file="../../commons/commons.jspf"%>
<html>
<head>
    <style>
        .crmTree{
            list-style-type: none;
            padding: 0px;
            margin: 0px;
        }
        .crmTree li{
            margin-top:5px;
        }
        .crmTree li a{
            text-decoration: none;
            display: block;
            color: #555555;
            font-size: 13px;
            font-weight: bolder;
        }
        .crmTree li a:hover{
            background:#E8F1FF;
        }
        .right_title_nav{
            padding-top: 10px;
        }
        .right_title_nav ul{
            list-style-type: none;
        }
        .right_title_nav ul li{
            float: left;
            margin-left: 5px;
        }
        .right_title_nav a{
            color: #CCE6FF;
            text-decoration: none;
        }
    </style>
    <script type="text/javascript" src="http://cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</head>
<body>

<div class="easyui-layout" style="width:100%;height:600px;">
    <div region="north" split="true" style="width: 100%;height: 10%;background:#2451B4">
        <div style="float:left;color: #F2F2F2;font-size: 28px;font-weight: bold;margin-left: 20px;margin-top: 10px">名驹汽车销售有限公司客户关系管理系统</div>
        <div style="float: right;color: #CCE6FF;font-size: 12px;margin-right: 20px;margin-top: 10px">
            <div style="float: right;"><span id="managerName" style="color:#F2F2F2;font-weight: bolder;">${sessionScope.managerName}</span>&nbsp;&nbsp;欢迎您！</div>
            <div class="right_title_nav">
                <ul>
                    <li><a href="javascript:;">网站首页</a></li>
                    <li>|</li>
                    <li><a href="javascript:;">支持论坛</a></li>
                    <li>|</li>
                    <li><a href="javascript:;">帮助中心</a></li>
                    <li>|</li>
                    <li><a href="javascript:;">安全退出</a></li>
                </ul>
            </div>
        </div>
    </div>
    <div region="west" split="true" title="导航菜单" style="width:10%;">
        <div class="easyui-accordion" style="width:100%;height: 100%">
            <div title="客户管理"  selected="true" style="overflow:auto;padding:10px;">
                <ul class="crmTree">
                    <li>
                        <a href="${pageContext.request.contextPath}/base/customer/customerlist.action" title="客户查询">
                            客户查询
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/base/customer/count.action" title="客户统计">
                            客户统计
                        </a>
                    </li>
                </ul>
            </div>
            <div title="产品管理"   style="padding:10px;">
                <ul class="crmTree">
                    <li>
                        <a href="${pageContext.request.contextPath}/base/car/carlist.action" title="产品查询">
                            产品查询
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/base/car/count.action" title="产品统计">
                            产品统计
                        </a>
                    </li>
                </ul>
            </div>
            <div title="用户管理" style="padding:10px;">
                <ul class="crmTree">
                    <li>
                        <a href="${pageContext.request.contextPath}" title="用户管理">
                            用户管理
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}" title="修改密码">
                            修改密码
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    <div data-options="region:'center',title:'内容展示'" style="padding:5px;background:#eee;">
        <div id="centerTab" class="easyui-tabs" data-options="fit:true" style="width:500px;height:250px;">
            <div title="系统介绍" style="padding:20px;display:none;">
                这里可以写系统或公司的相关介绍等等
            </div>
        </div>
    </div>
</div>

<!-- webocket连接服务器 -->
<script>
    var  socket = new WebSocket("ws://localhost:8080/init");
    console.log(socket)
    $(function() {
        listen();
    });

    function emit(text,toUser) {
        alert("------------"+text+"       "+toUser);
        var userName = $("#managerName").html().trim();
        var msg = {
            "msgType":1,
            "userName":userName,
            "message" : text,
            "toUser":toUser
        };
        msg = JSON.stringify(msg);
        socket.send(msg);
    }

    function listen() {
        socket.onopen = function() {
            console.log("------onopen------")
            var managerName = $("#managerName").html().trim();
            console.log("userName:"+managerName);
            var msg = JSON.stringify({"msgType":0,"userName":managerName,"toUser":''});
            socket.send(msg);
        };
        socket.onmessage = function(evt) {
            console.log('-----收到消息-----')
            var data = JSON.parse(evt.data);
            console.log(data);
            var managerName = $("#managerName").html().trim();
            if(data.msgType==0){
                var flag = $("#centerTab").tabs("exists",data.userName);
                if(!flag){
                    $.messager.confirm('Confirm', '您有新的客户服务请求，是否接收？', function(r){
                        if (r){
                            $("#centerTab").tabs({
                                onAdd:function (title,index) {
                                    console.log("-------added---------");
                                    window.setTimeout(function(){
                                        var iframe = $("#centerTab").tabs('getTab',data.userName).children("iframe")[0];
                                        console.log(iframe)
                                        var content = iframe.contentWindow.document.getElementById("content");
                                        var html = content.innerHTML;
                                        content.innerHTML = html+"<div style='height:auto;min-height:20px;width:100%;margin-top: 5px;margin-bottom: 5px;'><kbd style='color: #" + "CECECE" + ";float:left;font-size: " + 12 + ";max-width:400px;word-break:break-all'>您正在为"+data.userName+"服务</kbd><div style='clear:both'></div></div>";
                                        content.scrollTop = content.scrollHeight;
                                    },1000);
                                }
                            });
                            $("#centerTab").tabs("add",{
                                title:data.userName,
                                closable:true,
                                content:"<iframe src='${path}/base/chat/chat.action' title="+data.userName+" style='border: 0;width:100%;height:100%'></iframe>",
                            });
                        }
                    });

                }else{
                    $("#centerTab").tabs('select', data.userName);
                }
                //重点,防止打开新的页面
                return false;
            }

            if(data.msgType==1){
                var flag = $("#centerTab").tabs("exists",data.userName);
                if(!flag){
                    $("#centerTab").tabs("add",{
                        title:data.userName,
                        closable:true,
                        content:"<iframe src='${path}/base/chat/chat.action' title="+data.userName+" style='border: 0;width:100%;height:100%'></iframe>",
                    });
                }
                window.setTimeout(function () {
                    var iframe = $("#centerTab").tabs('getTab',data.userName).children("iframe")[0];
                    console.log(iframe)
                    var content = iframe.contentWindow.document.getElementById("content");
                    var html = content.innerHTML;
                    content.innerHTML = html+"<div style='height:auto;min-height:20px;width:100%;margin-top: 5px;margin-bottom: 5px;'><kbd style='color: #" + "CECECE" + ";float:left;font-size: " + 12 + ";max-width:400px;word-break:break-all'>" + data.userName + " Say: " + data.message + "</kbd><div style='clear:both'></div></div>"
                    content.scrollTop = content.scrollHeight;
                },1000)
            }

        };
        socket.onclose = function(evt) {
            console.log("--------onclose---------")
        };
        socket.onerror = function(evt) {
            console.log("--------onerror---------")
        }
    }

</script>
<script>

    $(".crmTree li a[title]").click(function () {
       alert(this.title)
        var flag = $("#centerTab").tabs("exists",this.title);
        if(!flag){
            $("#centerTab").tabs("add",{
                title:this.title,
                closable:true,
                //href:text --- 对远程页面js的支持不好
                //可以加载内容填充到选项卡，页面有Js时，也可加载
                content:"<iframe src="+this.href+" title="+this.title+" style='border: 0;width:100%;height:100%'></iframe>"
            });
        }else{
            $("#centerTab").tabs('select', this.title);
        }
        //重点,防止打开新的页面
        return false;
    })
</script>
</body>
</html>
