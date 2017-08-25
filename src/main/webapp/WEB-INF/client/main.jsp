<%--
  Created by IntelliJ IDEA.
  User: hxj
  Date: 17-8-21
  Time: 下午2:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set value="${pageContext.request.contextPath}" var="path"></c:set>
<html>
<head>
    <title>客户端主页</title>
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="${path}/bootstraptable/bootstrap-table.css">
    <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="${path}/bootstraptable/bootstrap-table.js"></script>
    <script src="${path}/bootstraptable/bootstrap-table-zh-CN.js"></script>
    <script type="text/javascript" src="${path}/star/jquery.raty.min.js"></script>

    <style>
        .starWrapper{
            clear: both;
            height: 25px;
        }
        .fleft{
            float: left;
            margin-left: 20px;
        }
    </style>

</head>
<body>
<div class="container" style="margin-top: 50px">
    <div class="row clearfix">
        <div class="col-md-12 column">
            <ul class="nav nav-pills">
                <li class="active">
                    <button type="button" class="btn btn-default btn-lg">
                        <span class="glyphicon glyphicon-user"></span><span id="cusName">${sessionScope.cusName}</span>
                        <input type="hidden" value="${sessionScope.cusId}" id="cusId">
                    </button>
                </li>
            </ul>
            <h3 class="text-center">
                汽车品牌评分表
            </h3>
            <nav class="navbar navbar-default" role="navigation">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"> <span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button> <a class="navbar-brand" href="#">Brand</a>
                </div>

                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <form class="navbar-form navbar-left" role="search" id="searchForm">
                        <div class="form-group">
                            <input class="form-control" type="text" name="cname" placeholder="请输入品牌名称"/>
                        </div> <button type="button" class="btn btn-default" id="conditionSearch">查询</button>
                    </form>
                    <ul class="nav navbar-nav navbar-right">
                        <li onclick="openChat()">
                            <a href="javascript:;" style="outline: none"><img src="${path}/static/images/customer_service.png" style="height: 20px"/></a>
                        </li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">为您服务<strong class="caret"></strong></a>
                            <ul class="dropdown-menu">
                                <li>
                                    <a href="#">统计信息</a>
                                </li>
                                <li>
                                    <a href="#">请求客服</a>
                                </li>
                                <li class="divider">
                                </li>
                                <li>
                                    <a href="#">退出登录</a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>

            </nav>
            <table class="table" id="carlist"></table>
        </div>
    </div>
</div>

    <!-- 评价弹出对话框（Modal） -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title" id="myModalLabel">
                        汽车品牌评价
                    </h4>
                </div>
                <div class="modal-body">
                    <div>
                        <div class="starWrapper">
                            <div class="fleft">服务态度</div>
                            <div class="star fleft" id="attitudeStar"></div>
                            <div class="fleft"><span id="attitude">0</span>星</div>
                        </div>
                        <div class="starWrapper">
                            <div class="fleft">外观设计</div>
                            <div class="star fleft" id="exteriorStar"></div>
                            <div class="fleft"><span id="exterior">0</span>星</div>
                        </div>
                        <div class="starWrapper">
                            <div class="fleft">内饰配置</div>
                            <div class="star fleft" id="trimStar"></div>
                            <div class="fleft"><span id="trim">0</span>星</div>
                        </div>
                        <div class="starWrapper">
                            <div class="fleft">空间布局</div>
                            <div class="star fleft" id="spaceStar"></div>
                            <div class="fleft"><span id="space">0</span>星</div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                    </button>
                    <input type="hidden" id="eid">
                    <button type="button" class="btn btn-primary" id="subEvaluate">
                        提交评价
                    </button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>

    <script>

        $(function () {

            //1.初始化Table
            var oTable = new TableInit();
            oTable.Init();

            //2.初始化Button的点击事件
            var oButtonInit = new ButtonInit();
            oButtonInit.Init();

        });

        var cusId = $("#cusId").val();
        var TableInit = function () {
            var oTableInit = new Object();
            //初始化Table
            oTableInit.Init = function () {
                $('#carlist').bootstrapTable({
                    url: '${path}/evaluate/selectBycusId.action?cusId='+cusId+'&cname=',         //请求后台的URL（*）
                    method: 'get',                      //请求方式（*）
                    toolbar: '#toolbar',                //工具按钮用哪个容器
                    striped: true,                      //是否显示行间隔色
                    cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
                    pagination: true,                   //是否显示分页（*）
                    sortable: false,                     //是否启用排序
                    sortOrder: "asc",                   //排序方式
                    queryParams: oTableInit.queryParams,//传递参数（*）
                    sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
                    pageNumber:1,                       //初始化加载第一页，默认第一页
                    pageSize: 10,                       //每页的记录行数（*）
                    pageList: [5,10],                   //可供选择的每页的行数（*）
//                    search: true,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
                    strictSearch: true,
                    showColumns: true,                  //是否显示所有的列
                    showRefresh: true,                  //是否显示刷新按钮
                    minimumCountColumns: 2,             //最少允许的列数
                    clickToSelect: true,                //是否启用点击选中行
                    height: 600,                        //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
                    uniqueId: "ID",                     //每一行的唯一标识，一般为主键列
                    showToggle:true,                    //是否显示详细视图和列表视图的切换按钮
                    cardView: false,                    //是否显示详细视图
                    detailView: false,                   //是否显示父子表
                    columns: [{
                        checkbox: true
                    }, {
                        field: 'cname',
                        title: '汽车品牌'
                    }, {
                        field: 'pubtime',
                        title: '发布时间',
                        formatter:function(value,row,index){
                            var date = new Date(value);
                            var dateStr = date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
                            return dateStr;
                        }
                    }, {
                        field: 'score',
                        title: '评价',
                        sortable: false,
                        formatter:function(value,row,index){
//                            console.log(value)
//                            console.log(row)
//                            console.log(index)
                            return '<div style="display:inline-block;width: 120px;">'+value+'分</div><a id="row"+index href="#" mce_href="#" onclick="onDeleteClick(\''+ row.cId +'\')">评价</a> ';
                        }
                    }]
                });
            };

            //得到查询的参数
            oTableInit.queryParams = function (params) {
                var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                    limit: params.limit,   //页面大小
                    offset: params.offset,  //页码
                    departmentname: $("#txt_search_departmentname").val(),
                    statu: $("#txt_search_statu").val()
                };
                return temp;
            };
            return oTableInit;
        };


        var ButtonInit = function () {
            var oInit = new Object();
            var postdata = {};

            oInit.Init = function () {
                //初始化页面上面的按钮事件
            };

            return oInit;
        };

        function onDeleteClick(rowid) {
            alert(rowid);
            $("#subEvaluate").attr("lang",rowid);
            var cusId = $("#cusId").val();
            $.ajax({
                type:'POST',
                url:'${path}/evaluate/selectStarBycusId.action',
                data:{cusId:cusId,cId:rowid},
                success:function (resultData) {
                    if(resultData){
                        console.log(resultData);
                        $("#eid").val(resultData.eid);
                        $("#attitudeStar").raty({
                            score:resultData.attitude,
                            click: function(score, evt) {
                                $(this).next().children('span').html(score)
                            }
                        });
                        $("#attitude").html(resultData.attitude);

                        $("#exteriorStar").raty({
                            score:resultData.exterior,
                            click: function(score, evt) {
                                $(this).next().children('span').html(score)
                            }
                        });
                        $("#exterior").html(resultData.attitude);

                        $("#trimStar").raty({
                            score:resultData.trim,
                            click: function(score, evt) {
                                $(this).next().children('span').html(score)
                            }
                        });
                        $("#trim").html(resultData.attitude);

                        $("#spaceStar").raty({
                            score:resultData.trim,
                            click: function(score, evt) {
                                $(this).next().children('span').html(score)
                            }
                        });
                        $("#space").html(resultData.attitude);

                        $('#myModal').modal('show')
                       // alert("已经评价过了，您要修改评价吗？")
                    }else{
                        $("#eid").val('');
                        $('.star').raty({
                            click: function(score, evt) {
                                // alert('ID: ' + $(this).attr('id') + "\nscore: " + score + "\nevent: " + evt);
                                $(this).next().children('span').html(score)
                            }
                        });
                        $('#myModal').modal('show')
                    }
                }
            });

        }

        $("#subEvaluate").click(function () {
            alert("-----提交评价------");

            var attitude = $("#attitude").html();
            var exterior = $("#exterior").html();
            var trim = $("#trim").html();
            var space = $("#space").html();
            var cid = $(this).attr("lang");
            var cusId = $("#cusId").val();
            var eid = $("#eid").val();
            alert("eid:"+eid+"   cid:"+cid+"   cusId:"+cusId+"     attitude:"+attitude+"     exterior:"+exterior+"    trim:"+trim+"     space:"+space)

            var url = '${path}/evaluate/save.action';
            var data = {eid:eid,cid:cid,cusid:cusId,attitude:attitude,exterior:exterior,trim:trim,space:space};
            if(eid){
                url = '${path}/evaluate/update.action';
            }
            $.ajax({
                type:'POST',
                url:url,
                data:data,
                success:function (resultData) {
                    alert(resultData);
                    if(resultData=="success"){
                        $('#myModal').modal('hide');
                        selectList()
                    }
                }
            })

        });

        function selectList() {
            var cname = $("#searchForm input[name='cname']").val().trim();
            var cusId = $("#cusId").val();
            $('#carlist').bootstrapTable('refresh', {url: '${path}/evaluate/selectBycusId.action?cusId='+cusId+'&cname='+cname});
        }

        $("#conditionSearch").click(function () {
            selectList()
        })
        
        function openChat() {
           window.location.href = '${path}/base/client/chat.action?userName='+$("#cusName").html().trim();
        }

    </script>

</body>
</html>
