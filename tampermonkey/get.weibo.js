// ==UserScript==
// @icon http://weibo.com/favicon.ico
// @name 微博内容备份
// @namespace [url=mailto:909070781@qq.com]909070781@qq.com[/url]
// @author 无花果
// @description 微博内容备份
// @match *://weibo.com/tv/v/*
// @require http://cdn.bootcss.com/jquery/3.3.1/jquery.min.js
// @version 0.0.1
// @grant GM_addStyle
// ==/UserScript==
(function() {
    'use strict';

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
        return s.replace("@", '');
    }

    function unique1(array) {
        var n = [];
        for (var i = 0; i < array.length; i++) {
            if (n.indexOf(array[i]) == -1) n.push(array[i]);
        }
        return n;
    }

    function hasClass(obj, searchClass) {
        var className = obj.getAttribute("class");
        var pattern = new RegExp("(^|\\s)" + searchClass + "(\\s|$)");
        return pattern.test(className);
    }


    var userlist = new Array();
    var divs = document.getElementsByClassName("comment-content")[0].getElementsByTagName("H4");
    for (var i = 0; i < divs.length; i++) {
        if (hasClass(divs[i], "m-text-cut")) {
            userlist.push(textContent(divs[i]))
        }
    }
    var links = document.getElementsByClassName("comment-content")[0].getElementsByTagName("a");
    for (var i = 0; i < links.length; i++) {
        link = links[i]
        href = link.getAttribute('href')
        if (!href) {
            userlist.push(textContent(link))
        }
        if (href && href.indexOf("/n/") == 0) {
            userlist.push(textContent(link))
        }
    }

    userlist = unique1(userlist);
    console.table(page_info.weibo_list);
    console.table(page_info.user_list);
})();