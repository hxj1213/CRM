/**
 * Created by hxj on 17-8-19.
 */
$(function () {
    var proIndex;
    var proName;
    var cityIndex;
    var cityName;

    $.getJSON('/static/json/address.json',function (data) {
        var proSelect = $("#pro");
        $.each(data,function (infoIndex,info) {
            console.log(infoIndex+"   "+info.name);
            proSelect.append("<option value='"+infoIndex+"'>"+info.name+"</option>")
        })
    });

    $("#pro").change(function () {
        $("#city").empty();
        $("#area").empty();
        proIndex = $(this).val();
        proName = $(this).html();
        $.getJSON('/static/json/address.json',function (data) {
            var citys = data[proIndex].sub;
            $.each(citys,function (subIndex,sub) {
                $("#city").append("<option value='"+subIndex+"'>"+sub.name+"</option>")
            })
        });
    })

    $("#city").change(function () {
        $("#area").empty();
        cityIndex = $(this).val();
        cityName = $(this).html();
        $.getJSON('/static/json/address.json',function (data) {
            var areas = data[proIndex].sub[cityIndex].sub;
            if(areas){
                $.each(areas,function (subIndex,sub) {
                    $("#area").append("<option value='"+subIndex+"'>"+sub.name+"</option>")
                })
            }else{
                $("#area").append("<option>无选项</option>")
            }

        });
    })
});
