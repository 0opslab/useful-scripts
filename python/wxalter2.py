#!/usr/bin/python
# -*- coding: utf-8 -*-
import json
import sys
import urllib,urllib2

#需要三个变量corpid、corpsecret、agentid
agentid = '1000002'
corpid = 'wwdf02bfee2a3b008a'
corpsecret = 'HjZRKUWGeiIZ9FgfFeAGhJUSKaIKEKGTX7_bDe8AdwY'

#获取tocken，存在my_token里面
gettoken_url = 'https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid=' + corpid + '&corpsecret=' + corpsecret
token_file = urllib2.urlopen(gettoken_url)
token_data = token_file.read().decode('utf-8')
token_json = json.loads(token_data)
my_token = token_json['access_token']

#利用获取到的tocken发送微信信息
touser=sys.argv[1] #发送给谁，多个用分号分享，例如'zhangsan|wangwu'
content=sys.argv[2] #发送的内容
post_content = {
        "touser":touser,
        "agentid":agentid,
        "msgtype": "text",
        "text":{
                "content":content,
        }
}
json_content = json.dumps(post_content)

url = 'https://qyapi.weixin.qq.com/cgi-bin/message/send?access_token=' + my_token
response = urllib2.urlopen(url,json_content)

#查看返回结果
print(response.read().decode('utf-8'))