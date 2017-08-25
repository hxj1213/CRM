<%--
  Created by IntelliJ IDEA.
  User: hxj
  Date: 17-8-21
  Time: 下午7:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@include file="../../commons/client_commons.jspf"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>客户端登录页面</title>
</head>
<body>
<div class="container" style="margin-top: 100px">
    <div class="row clearfix">
        <div class="col-md-12 column">
            <div class="page-header">
                <h1>
                    Best Car Company <small>please login</small>
                </h1>
            </div>
        </div>
    </div>
    <div class="row clearfix">
        <div class="col-md-2 column">
        </div>
        <div class="col-md-6 column">
            <form class="form-horizontal" action="${path}/customer/login.action" role="form" id="loginForm">
                <div class="form-group">
                    <label for="inputEmail3" class="col-sm-2 control-label">Username</label>
                    <div class="col-sm-10">
                        <input class="form-control" id="inputEmail3" type="text" name="cusLoginName"
                               />
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword3" class="col-sm-2 control-label">Password</label>
                    <div class="col-sm-10">
                        <input class="form-control" id="inputPassword3" type="password" name="cusLoginPass"
                        />
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword3" class="col-sm-2 control-label">Role</label>
                    <div class="col-sm-10">
                        <label class="radio-inline">
                            <input type="radio" name="role" value="0" checked> 管理员
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="role" value="1"> 客户
                        </label>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <div class="checkbox">
                            <label><input type="checkbox" />Remember me</label>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <button id="login" type="submit" class="btn btn-primary">Sign in</button>
                        <button id="reset" type="reset" class="btn btn-primary">Reset</button>
                        <button id="register" type="button" class="btn btn-default">Register</button>
                    </div>
                </div>
            </form>
        </div>
        <div class="col-md-4 column">
        </div>
    </div>
</div>

<script>

    $(document).ready(function() {


        $('#loginForm').bootstrapValidator({
            excluded: [':disabled', ':hidden', ':not(:visible)'],
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            live: 'enabled',
            message: 'This value is not valid',
            submitButtons: 'button[type="submit"]',
            submitHandler: function(validator, form, submitButton) {
                alert("------login---submit---")
                var role = $("input[name='role']:checked").val();
                console.log("role:"+role)
                var cusLoginName = $("input[name='cusLoginName']").val();
                var cusLoginPass = $("input[name='cusLoginPass']").val();
                if(role==0){
                    // 实用ajax提交表单
                    $.post('${path}/mag/login.action', {mloginName:cusLoginName,mloginPass:cusLoginPass}, function(result) {
                        alert(result);
                        if(result=="success"){
                            window.location.href = "${path}/base/main/index.action";
                        }
                    }, 'json');
                }else{
                    // 实用ajax提交表单
                    $.post(form.attr('action'), form.serialize(), function(result) {
                        alert(result);
                        if(result=="success"){
                            window.location.href = "${path}/base/client/main.action";
                        }
                    }, 'json');
                }

            },
            trigger: "blur",
            fields:{
                cusLoginName: {
                    validators: {
                        notEmpty: {
                            message: 'The username is required and can\'t be empty'
                        },
                        stringLength: {
                            min: 6,
                            max: 20,
                            message: 'The username must be more than 6 and less than 30 characters long'
                        },
                        regexp: {
                            regexp: /^[a-zA-Z0-9_\.]+$/,
                            message: 'The username can only consist of alphabetical, number, dot and underscore'
                        }
                    }
                },
                cusLoginPass: {
                    validators: {
                        notEmpty: {
                            message: 'The password is required and can\'t be empty'
                        },
                        stringLength: {
                            min: 6,
                            max: 20,
                            message: 'The username must be more than 6 and less than 30 characters long'
                        },
                        different: {
                            field: 'cusLoginName',
                            message: 'The password can\'t be the same as username'
                        }
                    }
                },
            }

        });
        
        $("#register").click(function () {
            window.location.href = "${path}/base/chat/register.action";
        });

    });

</script>


</body>
</html>
