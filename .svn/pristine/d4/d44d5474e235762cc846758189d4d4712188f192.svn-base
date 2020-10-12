// ==UserScript==
// @name         ReadAll-CSDN
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  try to take over the world!
// @author       monsoon
// @match        https://blog.csdn.net/*
// @grant        none
// ==/UserScript==

(function() {
    'use strict';

    //就是这里,示例(csdn删除"查看更多"按钮,并显示全部页面内容):
    document.getElementById('article_content').removeAttribute('style');
    var del = document.getElementsByClassName('hide-article-box')[0].remove();
    del.parentNode.removeChild(del[0]);
    scrollTo(0,0);
})();