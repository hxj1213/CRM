<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1" charset="UTF-8">
		
		<title>客服管理员页面</title>
		<link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
        <style>
            #content{height: 200px;overflow-y:auto;}
        </style>
	</head>
	
	<body>

		<div class="container" style="padding-top:20px;">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h3 class="panel-title">客服聊天界面</h3>
				</div>
				<div class="panel-body" id="content" ></div>
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
            function encodeScript(data) {
                if(null == data || "" == data) {
                    return "";
                }
                return data.replace("<", "&lt;").replace(">", "&gt;");
            }

            function emit() {

                var text = encodeScript($("#msg").val());
                var toUser = window.parent.$("#centerTab").tabs('getSelected').children("iframe")[0].title;
                window.parent.emit(text,toUser);

                $("#content").append("<div style='height:auto;min-height:20px;width:100%;margin-top: 5px;margin-bottom: 5px;'><kbd style='color: #" + "CECECE" + ";float: right; font-size: " + 12 + ";max-width:400px;word-break:break-all'>" + text +  "</kbd><div style='clear:both'></div></div>");
                $('#content').scrollTop( $('#content')[0].scrollHeight);
                $("#msg").val("");
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
