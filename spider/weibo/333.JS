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
    return s.replace("@",'');
}
function hasClass(obj,searchClass){
    var className=obj.getAttribute("class");
    var pattern=new RegExp("(^|\\s)"+searchClass+"(\\s|$)");
    return pattern.test(className);
}
var userlist = new Array();
var divs = document.getElementsByClassName("comment-content")[0].getElementsByTagName("H4");
for(var i=0;i<divs.length;i++){
    if(hasClass(divs[i],"m-text-cut")){
        userlist.push(textContent(divs[i]))
    }
}
var links = document.getElementsByClassName("comment-content")[0].getElementsByTagName("a");
for(var i=0;i<links.length;i++){
    link = links[i]
    href = link.getAttribute('href')
    if(!href){
        userlist.push(textContent(link))
    }
    if(href && href.indexOf("/n/") == 0){
        userlist.push(textContent(link))
    }
}
function unique1(array){
  var n = []; 
  for(var i = 0; i < array.length; i++){
    
    if (n.indexOf(array[i]) == -1) n.push(array[i]);
  }
  return n;
}
return unique1(userlist);
