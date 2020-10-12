import urllib.request
import json
import requests


#--------------------------------
# 获取企业微信token
#--------------------------------

def get_token(url, corpid, corpsecret):
    token_url = '%s/cgi-bin/gettoken?corpid=%s&corpsecret=%s' % (url, corpid, corpsecret)
    token = json.loads(urllib.request.urlopen(token_url).read().decode())['access_token']
    return token

#--------------------------------
# 构建告警信息json
#--------------------------------
def messages(msg):
    values = {
        "touser": '@all',
        "msgtype": 'text',
        "agentid": 1000002,
        "text": {'content': msg},
        "safe": 0
        }
    msges=(bytes(json.dumps(values), 'utf-8'))
    return msges

#--------------------------------
# 发送告警信息
#--------------------------------
def send_message(url,token, data):
        send_url = '%s/cgi-bin/message/send?access_token=%s' % (url,token)
        respone=urllib.request.urlopen(urllib.request.Request(url=send_url, data=data)).read()
        x = json.loads(respone.decode())['errcode']
        print(x)
        if x == 0:
            print ('Succesfully')
        else:
            print ('Failed')

def get_media_ID(token,path):
    img_url = '%s/cgi-bin/media/upload?access_token=%s&type=file' %(url,token)
    upload_data={"fileSize":179,"filename":"summer_text_0920.txt","content-type":"text/plain"}
    files = {'file': open(path, 'rb')}
    print(files)
    r = requests.post(img_url, files=files)
    print(r.json())
    re = r.json()['media_id']
    return re

def send_file(token,path):
    media_ID = get_media_ID(token,path)

    values = {
       "touser" : "@all",
       "msgtype" : "file",
       "agentid" : 1000002,
       "file" : {
            "media_id" : media_ID
       },
       "safe":0
    }
    msges=(bytes(json.dumps(values), 'utf-8'))
    print(msges)
    return msges


##############函数结束########################

corpid = 'wwdf02bfee2a3b008a'
corpsecret = 'HjZRKUWGeiIZ9FgfFeAGhJUSKaIKEKGTX7_bDe8AdwY'
url = 'https://qyapi.weixin.qq.com'
msg='test,Python调用企业微信测试'

#函数调用
test_token=get_token(url, corpid, corpsecret)
# msg_data= messages(msg)
# send_message(url,test_token, msg_data)
msg_file=send_file(test_token,"C:/xwtech/clean.py")
send_message(url,test_token, msg_file)
