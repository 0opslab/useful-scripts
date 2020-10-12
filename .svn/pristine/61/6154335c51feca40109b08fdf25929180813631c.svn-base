#!/usr/bin/env python
#--coding:utf-8--

"""
简单的通过python实现一个http响应程序，可以根据需要实现自定义的响应
"""

from http.server import BaseHTTPRequestHandler, HTTPServer
import os

class RequestHandler(BaseHTTPRequestHandler):
    def execCmd(self,cmd): 
        '''execute command, and return the output  ''' 
        r = os.popen(cmd)  
        text = r.read()  
        r.close()
        return text  
    '''处理请求并返回页面'''


    # 处理一个GET请求
    def do_GET(self):
        con = self.execCmd('ipconfig')
        self.send_response(200)
        self.send_header("Content-Type", "text/html")
        self.send_header("Content-Length", str(len(con)))
        self.end_headers()
        self.wfile.write(con.encode('gbk'))

if __name__ == '__main__':
    serverAddress = ('', 8080)
    server = HTTPServer(serverAddress, RequestHandler)
    server.serve_forever()
