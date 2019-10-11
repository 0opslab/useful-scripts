@echo off 
netsh winsock reset
netsh interface set interface "本地连接"disabled
netsh interface set interface "本地连接" enabled