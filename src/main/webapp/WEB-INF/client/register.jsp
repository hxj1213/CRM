<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@include file="../../commons/client_commons.jspf"%>
<!DOCTYPE html>
<html>
<head>
    <title>注册页面</title>
    <link rel="stylesheet" href="${path}/bootstrap-chinese-region/bootstrap-chinese-region.css">
    <script msgType="text/javascript" src="${path}/bootstrap-chinese-region/bootstrap-chinese-region.js"></script>
</head>
<body>
    <div class="container">
        <div class="row">
            <!-- form: -->
            <section>
                <div class="col-lg-8 col-lg-offset-2">
                    <div class="page-header">
                        <h2>Sign up</h2>
                    </div>

                    <form id="defaultForm" action="${path}/customer/register.action" method="post" class="form-horizontal">
                        <div class="form-group">
                            <label class="col-lg-3 control-label">Username</label>
                            <div class="col-lg-5">
                                <input msgType="text" class="form-control" name="cusLoginName" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-3 control-label">Password</label>
                            <div class="col-lg-5">
                                <input msgType="password" class="form-control" name="cusLoginPass" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-3 control-label">Retype password</label>
                            <div class="col-lg-5">
                                <input msgType="password" class="form-control" name="confirmPassword" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-3 control-label">Your Address</label>
                            <div class="col-lg-5">
                                <div class="bs-chinese-region flat dropdown" data-submit-msgType="id" data-min-level="1" data-max-level="3">
                                    <input msgType="text" class="form-control" id="address" placeholder="选择你的地区" data-toggle="dropdown" readonly="" value="440103">
                                    <div class="dropdown-menu" role="menu" aria-labelledby="dLabel">
                                        <div>
                                            <ul class="nav nav-tabs" role="tablist">
                                                <li role="presentation" class="active"><a href="#province" data-next="city" role="tab" data-toggle="tab">省份</a></li>
                                                <li role="presentation"><a href="#city" data-next="district" role="tab" data-toggle="tab">城市</a></li>
                                                <li role="presentation"><a href="#district" data-next="street" role="tab" data-toggle="tab">县区</a></li>
                                            </ul>
                                            <div class="tab-content">
                                                <div role="tabpanel" class="tab-pane active" id="province">--</div>
                                                <div role="tabpanel" class="tab-pane" id="city">--</div>
                                                <div role="tabpanel" class="tab-pane" id="district">--</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <input id="cusprovince" name="cusprovince" msgType="hidden">
                                <input id="cusarea" name="cusarea" msgType="hidden">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-3 control-label">Realname</label>
                            <div class="col-lg-5">
                                <input msgType="text" class="form-control" name="cusname" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-3 control-label">Gender</label>
                            <div class="col-lg-5">
                                <label class="radio-inline">
                                    <input type="radio" name="cusgender" id="optionsRadios3" value="0" checked> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="cusgender" id="optionsRadios4"  value="1"> 女
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-3 control-label">Age</label>
                            <div class="col-lg-5">
                                <input msgType="text" class="form-control" name="cusage" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-3 control-label">Phone Number</label>
                            <div class="col-lg-5">
                                <input msgType="text" class="form-control" name="cusphone" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-3 control-label" id="captchaOperation"></label>
                            <div class="col-lg-2">
                                <input msgType="text" class="form-control" name="captcha" />
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-lg-9 col-lg-offset-3">
                                <button msgType="submit" class="btn btn-primary">Sign up</button>
                            </div>
                        </div>
                    </form>
                </div>
            </section>
            <!-- :form -->
        </div>
    </div>
<script msgType="text/javascript">
    $.getJSON('${path}/bootstrap-chinese-region/sql_areas.json',function(data){

        for (var i = 0; i < data.length; i++) {
            var area = {id:data[i].id,name:data[i].cname,level:data[i].level,parentId:data[i].upid};
            data[i] = area;
        }

        $('.bs-chinese-region').chineseRegion('source',data);
    });
</script>
<script msgType="text/javascript">
$(document).ready(function() {
    // Generate a simple captcha
    function randomNumber(min, max) {
        return Math.floor(Math.random() * (max - min + 1) + min);
    };
    $('#captchaOperation').html([randomNumber(1, 100), '+', randomNumber(1, 200), '='].join(' '));

    $('#defaultForm').bootstrapValidator({
        message: 'This value is not valid',
        submitHandler: function(validator, form, submitButton) {
            alert("------register---submit---")
            console.log(form.serialize())
            // 实用ajax提交表单
            $.post(form.attr('action'), form.serialize(), function(result) {
                alert(result)
                if(result=="success"){
                    window.location.href = "${path}/base/chat/login.action"
                }
            }, 'json');
        },
        fields: {
            cusLoginName: {
                message: 'The username is not valid',
                validators: {
                    notEmpty: {
                        message: 'The username is required and can\'t be empty'
                    },
                    stringLength: {
                        min: 6,
                        max: 20,
                        message: 'The username must be more than 6 and less than 20 characters long'
                    },
                    regexp: {
                        regexp: /^[a-zA-Z0-9_\.]+$/,
                        message: 'The username can only consist of alphabetical, number, dot and underscore'
                    },
                    different: {
                        field: 'cusLoginName',
                        message: 'The username and password can\'t be the same as each other'
                    },
                    <%--remote: {--%>
                        <%--url: '${path}/customer/checkName.action',--%>
                        <%--message: 'The username is already exsits'--%>
                    <%--}--%>
                }
            },
            cusLoginPass: {
                validators: {
                    notEmpty: {
                        message: 'The password is required and can\'t be empty'
                    },
                    identical: {
                        field: 'confirmPassword',
                        message: 'The password and its confirm are not the same'
                    },
                    different: {
                        field: 'cusLoginName',
                        message: 'The password can\'t be the same as username'
                    }
                }
            },
            confirmPassword: {
                validators: {
                    notEmpty: {
                        message: 'The confirm password is required and can\'t be empty'
                    },
                    identical: {
                        field: 'cusLoginPass',
                        message: 'The password and its confirm are not the same'
                    },
                    different: {
                        field: 'cusLoginName',
                        message: 'The password can\'t be the same as username'
                    }
                }
            },
            cusname: {
                message: 'The realname is not valid',
                validators: {
                    notEmpty: {
                        message: 'The username is required and can\'t be empty'
                    },
                    stringLength: {
                        min: 2,
                        max: 20,
                        message: 'The realname must be more than 6 and less than 20 characters long'
                    }
                }
            },
            cusage:{
                message: 'The age is not valid',
                validators: {
                    notEmpty: {
                        message: 'The age is required and can\'t be empty'
                    },
                    between: {
                        min: 18,
                        max: 70,
                        message: 'The age must be more than 18 and less than 70'
                    }
                }
            },
            cusphone: {
                validators: {
                    notEmpty: {
                        message: 'The phone number is required and can\'t be empty'
                    },
                    stringLength: {
                        min: 11,
                        max: 11,
                        message: 'The input is not a valid phone number'
                    }
                }
            },
            captcha: {
                validators: {
                    callback: {
                        message: 'Wrong answer',
                        callback: function(value, validator) {
                            var items = $('#captchaOperation').html().split(' '), sum = parseInt(items[0]) + parseInt(items[2]);
                            console.log(value==sum);
                            return value == sum;
                        }
                    }
                }
            }
        }
    });
});

/*
cusLoginName=hxj1213
cusLoginPass=111111111
confirmPassword=111111111
address=440103
cusname=%E5%BC%A0%E4%B8%89&cusgender=1&cusage=19&cusphone=13799887011&captcha=177 1 register.action:139:13
*/

</script>
</body>
</html>