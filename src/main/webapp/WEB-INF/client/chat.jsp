<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set value="${pageContext.request.contextPath}" var="path"></c:set>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1" charset="UTF-8">
		
		<title>BarrageClient</title>
		<link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
	</head>
	
	<body>
    <%
        String username = request.getParameter("userName");
        request.setAttribute("userName",username);
    %>
        <input type="hidden" id="userName" value='${requestScope.userName}'>
		<div class="container" style="padding-top:20px;">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h3 class="panel-title">客服聊天界面</h3>
				</div>
				<div class="panel-body" id="content" style="overflow-y:auto;height:200px"></div>
			</div>
			<hr/>
			<input type="text" class="form-control" placeholder="msg" aria-describedby="sizing-addon1" id="msg">
			<hr/>
			
			<hr/>
			<button type="button" class="btn btn-lg btn-success btn-block" onclick="emit()">Emit</button>
		</div>
		
		<script type="text/javascript" src="http://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
		<script type="text/javascript" src="http://cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
		
		<script>
			var socket = new WebSocket("ws://localhost:8080/init");
				console.log(socket)

				$(function() {
					listen();
				})

                function encodeScript(data) {
                    if(null == data || "" == data) {
                        return "";
                    }
                    return data.replace("<", "&lt;").replace(">", "&gt;");
                }

				function emit() {
					var text = encodeScript($("#msg").val());
					var userName = encodeScript($("#userName").val());
					var msg = {
						"msgType":1,
						"userName":userName,
						"message" : text,
						"toUser":'admin123'
					};
					msg = JSON.stringify(msg);

					socket.send(msg);
	
					$("#content").append("<div style='height:auto;min-height:20px;width:100%;margin-top: 10px;margin-bottom:5px;'><kbd style='color: #" + "CECECE" + ";float: right; font-size: " + 12 + ";max-width:400px;word-break:break-all'>" + text +  "</kbd><div style='clear:both'></div></div>");
				$('#content').scrollTop( $('#content')[0].scrollHeight );		
					$("#msg").val("");
				}

				function listen() {
					socket.onopen = function() {
						$("#content").append("<kbd>Welcome!</kbd></br>");
						var userName = encodeScript($("#userName").val());
						msg = JSON.stringify({"msgType":0,"userName":userName,"toUser":'admin123'});
						socket.send(msg);
					};
					socket.onmessage = function(evt) {
						console.log('-----收到消息-----')
						var data = JSON.parse(evt.data);
						if(data.msgType==3){
							alert(data.message);			
						}
						if(data.msgType==1){
							$("#content").append("<div style='height:auto;min-height:20px;width:100%;margin-top: 5px;margin-bottom:5px;'><kbd style='color: #" + "CECECE" + ";float:left;font-size: " + 12 + ";max-width:400px;word-break:break-all'>" + data.userName + " Say: " + data.message + "</kbd><div style='clear:both'></div></div>");		
						$('#content').scrollTop( $('#content')[0].scrollHeight );		
						}
		
					};
					socket.onclose = function(evt) {
						$("#content").append("<kbd>" + "Close!" + "</kbd></br>");
						var userName = encodeScript($("#userName").val());
						msg = JSON.stringify({"msgType":2,"userName":userName,"toUser":'admin123'});
						socket.send(msg);
					}
					socket.onerror = function(evt) {
						$("#content").append("<kbd>" + "ERROR!" + "</kbd></br>");
					}
				}

				document.onkeydown = function(event){
					var e = event || window.event || arguments.callee.caller.arguments[0];
					if(e && e.keyCode == 13){ // enter 键
						emit();
					}
				}; 
					
		</script>


	</body>
</html>
