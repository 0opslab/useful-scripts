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
    return Trim(s);
}
function Trim(str){
   var result;
   result = str.replace(/(^\s+)|(\s+$)/g,"");
   result = result.replace(/\s/g,"");
   return result;
}
var li = document.getElementsByClassName("m_wrap clearfix")[0].getElementsByTagName("li");
var ss =""
for (var i in li){
	ss +=textContent(li[i])+"@";
}
return ss;