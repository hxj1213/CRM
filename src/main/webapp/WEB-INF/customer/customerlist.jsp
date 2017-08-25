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
    <title>客户信息列表</title>
    <style>
        #addCustomer{
            width:300px;height: 290px;padding:5px;
        }

        #uploadCustomerData{
            width:300px;height: 100px;padding:5px;
        }

        .formTip{
            width:50px;text-align:right;margin-right:10px;float: left;display: inline-block
        }

        .errorMsg{
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
    <div id="addCustomer" class="easyui-window" title="添加客户" closed="true">
        <form id="addCustomerForm">
           <div class="errorMsg"></div>
           <div class="formContentDiv">
               <div class="formTip"><span>客户姓名</span></div>
               <input type="text" name="cusname" placeholder="请输入姓名">
           </div>
           <div class="formContentDiv">
                <div class="formTip"><span>客户性别</span></div>
               <input type="radio" name="cusgender" value="0" checked>男
               <input type="radio" name="cusgender" value="1">女
           </div>
           <div class="formContentDiv">
                <div class="formTip"><span>客户年龄</span></div>
                <input type="text" name="cusage" placeholder="请输入年龄">
           </div>
           <div class="formContentDiv">
                <div class="formTip"><span>客户地区</span></div>
                <select id="pro" name="cusprovince">
                    <option>请选择</option>
                </select>
                <select id="city" name="city">
                    <option>请选择</option>
                </select>
                <select id="area" name="area">
                    <option>请选择</option>
                </select>
           </div>
            <div class="formContentDiv">
                <div class="formTip"><span>客户电话</span></div>
                <input type="text" name="cusphone" placeholder="请输入电话">
            </div>
           <div class="formContentDiv content-center">
               <input type="button" value="提交" name="subBtn">
           </div>
        </form>
    </div>

    <!-- 上传数据页面 -->
    <div id="uploadCustomerData" class="easyui-window" title="上传客户数据" closed="true">
        <form id="uploadFileForm" action="${path}/upload.action" enctype="multipart/form-data" method="post">
            <div class="errorMsg"></div>
            <div class="formContentDiv content-center">
                <input type="file" id="uploadfile" name="upload">
            </div>
            <div class="formContentDiv content-center">
                <input type="button" value="上传" name="subBtn">
            </div>
        </form>
    </div>

    <table id="customerlist"></table>
    <script src="${path}/static/js/area.js"></script>
    <script>
        $('#customerlist').datagrid({
            url:'${path}/customer/selectPage.action',
            columns:[[
                {field:'ck',checkbox:true},
                {field:'cusname',title:'客户姓名',width:100},
                {field:'cusage',title:'客户年龄',width:100},
                {field:'cusgender',title:'客户性别',width:100,
                    formatter:function(val,rec){
                        return val==0?'男':'女';
                    }
                },
                {field:'cusprovince',title:'客户地区',width:200,
                    formatter:function(val,rec){
                        return val+rec.cusarea;
                    }
                },
                {field:'cusphone',title:'客户电话',width:200}
            ]],
            striped:true,
            fit:true,
            fitColumns:true,
            toolbar:[
                {
                    text:'添加',
                    iconCls: 'icon-add',
                    handler:function(){
                        $('#addCustomer').window('open');
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
                    text:" <input type='text' name='keywords' id='cname' placeholder='请输入客户名称查询'>",
                },
                '-',
                {
                    text:'下载客户数据模板',
                    iconCls: 'icon-redo',
                    handler:function(){
                        window.location.href = "${path}/download.action?filename=customer_schema.xlsx"
                    }
                },
                '-',
                {
                    text:'导入客户数据',
                    iconCls: 'icon-save',
                    handler:function(){
                        $('#uploadCustomerData').window('open');
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
                cname: "",
            }
        });

        $(window).resize(function () {
            $('#customerlist').datagrid('resize');
        });

        $("#addCustomerForm input[name='subBtn']").click(function () {

            alert('-----add-----')

            var cusname = $("#addCustomerForm input[name='cusname']").val();
            var cusgender = $("#addCustomerForm input[name='cusgender']").val();
            var cusage = $("#addCustomerForm input[name='cusage']").val();
            var cusprovince = $("#addCustomerForm select[name='cusprovince'] option:selected").text();
            var city = $("#addCustomerForm select[name='city'] option:selected").text();
            var area = $("#addCustomerForm select[name='area'] option:selected").text();
            var cusphone = $("#addCustomerForm input[name='cusphone']").val();

            console.log(cusname+"  "+cusgender+"  "+cusage+"   "+cusprovince+"  "+city+"   "+area+"  "+cusphone)

            if(cusname==null || cusname==""){
                $("#addCustomerForm .errorMsg").html('客户姓名不可为空');
                return false;
            }

            if(cusphone==null || cusphone==""){
                $("#addCustomerForm .errorMsg").html('客户联系方式不可为空');
                return false;
            }

            var params = {cusname:cusname,cuspass:'',cusgender:cusgender,cusage:cusage,cusprovince:cusprovince,
                cusarea:city+area,cusphone:cusphone};

            $.ajax({
                type:'POST',
                url:'${path}/customer/save.action',
                data:params,
                success:function (resultData) {
                    if(resultData=="success"){
                        $('#customerlist').datagrid('reload',{cname:$("#cname").val().trim()});
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
                        $('#uploadCustomerData').window('close');
                        var save = confirm("您确定要保存"+msg+"的内容到服务器吗？")
                        if(save){
                            $.ajax({
                                type:'POST',
                                url:'${path}/customer/insertList.action',
                                data:{filename:msg},
                                success:function (resultData) {
                                    alert(resultData.msg)
                                    if(resultData.error==0){
                                        $('#customerlist').datagrid('reload',{cname:$("#cname").val().trim()});
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
            $('#customerlist').datagrid('reload',{cname:$("#cname").val().trim()});
        })
    </script>

</body>
</html>
