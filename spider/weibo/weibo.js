function dateFtt(fmt,date) { //author: meizz 
 var o = { 
 "M+" : date.getMonth()+1,     //月份 
 "d+" : date.getDate(),     //日 
 "h+" : date.getHours(),     //小时 
 "m+" : date.getMinutes(),     //分 
 "s+" : date.getSeconds(),     //秒 
 "q+" : Math.floor((date.getMonth()+3)/3), //季度 
 "S" : date.getMilliseconds()    //毫秒 
 }; 
 if(/(y+)/.test(fmt)) 
 fmt=fmt.replace(RegExp.$1, (date.getFullYear()+"").substr(4 - RegExp.$1.length)); 
 for(var k in o) 
 if(new RegExp("("+ k +")").test(fmt)) 
 fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length))); 
 return fmt; 
} 
function deteminute(res){
    var ss = res;
    if (res.indexOf("今天") > -1) {
        var now = new Date;
        ss = res.replace("今天",dateFtt('yyyy-MM-dd',now));
    }
    if(res.indexOf("分钟前") >0){
        var now = new Date;
        now.setMinutes (now.getMinutes () - parseInt(res));
        ss= dateFtt('yyyy-MM-dd hh:mm:ss',now);
    }
    if(res.indexOf("小时前") > 0){
        var now = new Date;
        now.setMinutes (now.getHours () - parseInt(res));
        ss= dateFtt('yyyy-MM-dd hh:mm:ss',now);
    }
    console.log("====>"+res+"===>"+ss);
    return ss;
        
}

function textContent(elt) {
    var child, type, s = "";
    for (child = elt.firstChild; child != null; child = child.nextSibling) {
        type = child.nodeType;
        if (3 === type || 4 === type) {
            s += child.nodeValue;
        }
        if (1 === type) {
            s += textContent(child);
        }
    }
    return s;
}
function GetQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return unescape(r[2]); return null;
}
var page = GetQueryString('page');
var divs = document.getElementsByTagName("div");
var length = divs.length;
var weibo_list = new Array();
var user_list = new Array();
for(var i=0;i<length;i++){
    var div = divs[i];
    var types = div.getAttribute('action-type');
    if(types=='feed_list_item'){
        var mid = div.getAttribute('mid');
        var sub_divs = div.getElementsByTagName("div");
        var sub_length = sub_divs.length;
        var mvalue = "";
        for(var j=0;j<sub_length;j++){
            var sub_div = sub_divs[j];
            var sub_types =  sub_div.getAttribute('node-type');
            if(sub_types =='feed_list_content' || sub_types  =="feed_list_reason"){
                mvalue = textContent(sub_div).replace(/^\s\s*/, '').replace(/\s\s*$/, '');
                var a_list = sub_div.getElementsByTagName("a");
                var a_length = a_list.length;
                for(var ali =0;ali<a_length;ali++){
                    var link = a_list[ali];
                    if(link.hasAttribute('usercard')){
                        var userName = link.getAttribute('usercard').substr(5,);
                        var userInfo = link.getAttribute('href')
                        user_list.push({userName: userName, userInfo: userInfo});
                    }
                }
            }
        }


        var mfrom = div.getElementsByClassName("WB_from")[0].innerText.split('来自');
        var createtime = mfrom[0];
        if(!createtime.startsWith('20')){
            createtime = deteminute(createtime);
        }else{
            createtime = createtime;
        }
        weibo_list.push({mid: mid,createtime:createtime,fromclient:mfrom[1], mvalue: mvalue});
    }
}
var page_info = {'weibo_list':weibo_list,'user_list':user_list};
console.table(page_info.weibo_list);
console.table(page_info.user_list);
return page_info;




