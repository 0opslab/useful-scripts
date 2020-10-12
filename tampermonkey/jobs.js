//以下代码都基于jquery
//$.fn.jquery可获取网站jquery的版本号

//利用js获取51job上的招聘信息
//http://search.51job.com/list/
var result_list = new Array();
var div_list = $("#resultList .el");
var each_length  = div_list.length;
console.log(each_length);
for(var i=0;i<each_length;i++){
    var t = $(div_list[i]);
    if(!t.hasClass("title")){
        var a = t.find(".t1").find("a");
        var zhiwu = $(a).attr("title");
        var zhiwu_url = $(a).attr("href");
        var gongsi = t.find(".t2").text();
        
        var chengshi = t.find(".t3").text();
        var xinzi = t.find(".t4").text();
        var day = t.find(".t5").text();
        if(!chengshi.startsWith("异地")){
            result_list.push({"zhiwu":zhiwu,"zhiwu_url":zhiwu_url,"gongsi":gongsi,"chengshi":chengshi,"xinzi":xinzi,"day":day});
        }
    }
}

console.table(result_list);

//智联
//http://sou.zhaopin.com/jobs/searchresult.ashx
//http://sou.zhaopin.com/jobs/searchresult.ashx?jl=%E8%A5%BF%E5%AE%81&sm=0&p=70
function getNowFormatDate() {
    var date = new Date();
    var seperator1 = "-";
    var year = date.getFullYear();
    var month = date.getMonth() + 1;
    var strDate = date.getDate();
    if (month >= 1 && month <= 9) {
        month = "0" + month;
    }
    if (strDate >= 0 && strDate <= 9) {
        strDate = "0" + strDate;
    }
    var currentdate = year + seperator1 + month + seperator1 + strDate;
    return currentdate;
} 
var result_list = new Array();
var table_list = $("#newlist_list_content_table .newlist");
var each_length = table_list.length;
for(var i=0;i<each_length;i++){
    var t = $(table_list[i]);
    var a = t.find(".zwmc").find('a');
    var zhiwu = $(a).text().trim();
    var zhiwu_url = $(a).attr("href");
    var g = t.find(".gsmc").find('a')[0];
    var gongsi = $(g).text().trim();
    var gongsi_url = $(g).attr("href");
    var xinzi = t.find(".zwyx").text();
    var chengshi = t.find(".gzdd").text();
    var day = getNowFormatDate();
    result_list.push({"zhiwu":zhiwu,"zhiwu_url":zhiwu_url,"gongsi":gongsi,"gongsi_url":gongsi_url,
        "chengshi":chengshi,"xinzi":xinzi,"chengshi":chengshi,"day":day});
}
console.table(result_list);
