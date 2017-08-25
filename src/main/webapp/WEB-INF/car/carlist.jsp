<%--
  Created by IntelliJ IDEA.
  User: hxj
  Date: 17-8-18
  Time: 下午3:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../../commons/commons.jspf"%>
<html>
<head>
    <title>汽车品牌信息列表</title>
    <link rel="stylesheet" href="${path}/kindeditor/themes/default/default.css" />
    <link rel="stylesheet" href="${path}/kindeditor/plugins/code/prettify.css" />
    <script charset="utf-8" src="${path}/kindeditor/kindeditor-all-min.js"></script>
    <script charset="utf-8" src="${path}/kindeditor/lang/zh-CN.js"></script>
    <script charset="utf-8" src="${path}/kindeditor/plugins/code/prettify.js"></script>
    <style>
        #addCar{
            width:790px;height: 325px;padding:5px;
        }

        .formTip{
            width:50px;text-align:right;margin-right:10px;float: left;display: inline-block
        }

        #errorMsg{
            color: red;
            font-size: 12px;
        }

        .formContentDiv{
            padding-top: 20px;
        }

        .content-center{
             text-align: center;
        }

        .datagrid-cell{padding:6px 4px;overflow: hidden;text-overflow:ellipsis;white-space: nowrap;}
    </style>
</head>
<body>
    <!-- 添加汽车信息窗口  -->
    <div id="addCar" class="easyui-window" title="添加品牌" closed="true">
        <form id="addCarForm">
           <div id="errorMsg"></div>
           <div class="formContentDiv">
               <div class="formTip"><span>品牌名称</span></div>
            <input type="text" name="cname" placeholder="请输入汽车品牌名称">
           </div>
           <div class="formContentDiv">
                <div class="formTip"><span>描述</span></div>
                <textarea name="cinfo" cols="100" rows="8" style="width:700px;height:200px;visibility:hidden"></textarea>
           </div>
           <div class="formContentDiv btnDiv">
               <input type="button" value="提交" name="subBtn">
           </div>
        </form>
    </div>

    <!-- 上传数据页面 -->
    <div id="uploadCarData" class="easyui-window" title="上传客户数据" closed="true">
        <form id="uploadFileForm"  enctype="multipart/form-data" method="post">
            <div class="errorMsg"></div>
            <div class="formContentDiv content-center">
                <input type="file" id="uploadfile" name="upload">
            </div>
            <div class="formContentDiv content-center">
                <input type="button" value="上传" name="subBtn">
            </div>
        </form>
    </div>

    <table id="carlist"></table>
    <script>
        var editor;
        KindEditor.ready(function(K) {
            editor = K.create('textarea[name="cinfo"]', {
                allowFileManager : true
            });
        });

        $('#carlist').datagrid({
            url:'${path}/car/selectPage.action',
            columns:[[
                {field:'ck',checkbox:true},
                {field:'cname',title:'品牌名称',width:100},
                {field:'pubtime',title:'品牌创立时间',width:100},
                {field:'cinfo',title:'品牌介绍',width:200,rowspan:1}
            ]],
            striped:true,
            fit:true,
            fitColumns:true,
            toolbar:[
                {
                    text:'添加',
                    iconCls: 'icon-add',
                    handler:function(){
                        alert("insert goods");
                        $('#addCar').window('open');
                    }
                },
                '-',
                {
                    text:'修改',
                    iconCls: 'icon-edit',
                    handler:function(){alert("edit goods")}
                },
                '-',
                {
                    text:'删除',
                    iconCls: 'icon-remove',
                    handler:function(){alert("delete goods")}
                },
                '-',
                {
                    text:"<input type='text' name='keywords' id='cname'>",
                },
                '-',
                {
                    text:'下载产品数据模板',
                    iconCls: 'icon-redo',
                    handler:function(){
                        window.location.href = "${path}/download.action?filename=car_schema.xlsx"
                    }
                },
                '-',
                {
                    text:'导入产品数据',
                    iconCls: 'icon-save',
                    handler:function(){
                        $('#uploadCarData').window('open');
                    }
                }
            ],
            pagination:true,
            rownumbers:true,
            checkOnSelect:true,
            nowrap:false,
            idField:'cid',
            pageList:[3,5],
            pageSize:5,
            queryParams: {
                cname: '',
            }
        });

        $(window).resize(function () {
            $('#carlist').datagrid('resize');
        });

        $("#addCarForm input[name='subBtn']").click(function () {
                alert('-----add-----')
            var cname = $("#addCarForm input[name='cname']").val();
            var cinfo = editor.html();
            alert(cname+"      "+cinfo)

            if(cname==null || cname==""){
                $("#errorMsg").html("品牌名称不可为空");
                return false;
            }

            if(cinfo==null || cinfo==""){
                $("#errorMsg").html("品牌描述不可为空");
                return false;
            }

            $.ajax({
                type:'POST',
                url:'${path}/car/save.action',
                data:{cname:cname,cinfo:cinfo},
                success:function (resultData) {
                    alert(resultData);
                    if(resultData=="success"){
                        $("#carlist").datagrid("reload",{});
                        editor.html('');
                        $("#errorMsg").html('');
                        $('#addCarForm')[0].reset();
                        $('#addCar').window('close');
                    }
                }
            })
            
        })

        $("#uploadFileForm input[name='subBtn']").click(function () {
            alert("--------------")
            var upload = $("#uploadFileForm input[name='upload']").val();
            console.log("upload:"+upload);
            if(upload==null || upload==""){
                $("#uploadFileForm .errorMsg").html("请选择文件后再上传!");
                return false;
            }
            var ends = upload.substr(upload.lastIndexOf(".")).toLowerCase();
            if(ends!='.xlsx'){
                $("#uploadFileForm .errorMsg").html("请上传后缀名为xsl的文件!");
                return false;
            }

            var formData = new FormData();
//            console.log(document.getElementById("uploadfile"))
//            console.log(document.getElementById("uploadfile").files)
//            console.log(document.getElementById("uploadfile").files[0])
            formData.append("file",document.getElementById("uploadfile").files[0]);

            $.ajax({
                type:'POST',
                url:'${path}/upload.action',
                data:formData,
                processData: false,
                contentType: false,
                dataType:'json',
                success:function (resultData) {
                    var error = resultData.error;
                    var msg = resultData.msg;
                    if(error==0){
                        $("#uploadFileForm .errorMsg").html('');
                        $("#uploadFileForm")[0].reset();
                        $('#uploadCarData').window('close');
                        var save = confirm("您确定要保存"+msg+"的内容到服务器吗？")
                        if(save){
                            $.ajax({
                                type:'POST',
                                url:'${path}/car/insertList.action',
                                data:{filename:msg},
                                success:function (resultData) {
                                    alert(resultData.msg)
                                    if(resultData.error==0){
                                        $('#carlist').datagrid('reload',{cname:$("#cname").val().trim()});
                                    }
                                }
                            });
                        }
                    }else if(error==1){
                        $("#uploadFileForm .errorMsg").html(msg);
                    }
                    return;
                }
            })

        })

        $("#cname").blur(function () {
            $('#carlist').datagrid('reload',{cname:$("#cname").val().trim()});
        })

    </script>

</body>
</html>
