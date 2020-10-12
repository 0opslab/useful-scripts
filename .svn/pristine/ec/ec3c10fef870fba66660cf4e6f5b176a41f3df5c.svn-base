#!/usr/bin/env python
#--coding:utf-8--
import subprocess
import platform


    
    
def cmd(commond):
  encoding = "UTF-8"
  if 'Windows' == platform.system():
    encoding ="GBK"
    
  p = subprocess.Popen(commond,shell=True,stdout=subprocess.PIPE)
  if p.stdout:
    for line in p.stdout.readlines():  
      print(line.decode(encoding),end='')
        
        
if __name__ == '__main__':
  cmd('ping  www.baidu.com')
