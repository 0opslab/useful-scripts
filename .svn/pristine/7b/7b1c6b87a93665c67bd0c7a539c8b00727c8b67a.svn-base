#!/usr/bin/python
# -*- coding: utf-8 -*-

# ffmpeg -i 文件名
# 2、压制成mp4
# 1.pass1编码
# ffmpeg -i 01.rmvb -an -vcodec libx264 -b 560k -pass 1 -f mp4 -y NUL
# -an : 不编码音频
# -vcodec : 设置视频的编码，我这里使用的是x264
# -b : 这个是码率
# -f : 强制使用格式
# -y : 自动输y确认
# NUL : 因为是pass1 所以不需要输出文件，直接用NUL
# 2.pass2编码
# ffmpeg -i 01.rmvb -acodec copy -vcodec libx264 -b 560k -pass 2 -f mp4 01.mp4
# ffmpeg -i F:\迅雷下载\1.mkv -s hd720 -c:v libx264 -crf 23 -c:a aac -strict -2 2.mp4
# ffmpeg -i F:\迅雷下载\阳光电影www.ygdy8.com.飞驰人生.BD.1080p.国语中字.mkv -s hd720 -c:v libx264 -crf 23 -c:a aac -strict -2 名称.mp4
# ffmpeg -ss 01:20:00  -i F:\迅雷下载\阳光电影www.ygdy8.com.飞驰人生.BD.1080p.国语中字.mkv  -c:v libx264 -c:a aac -strict experimental -b:a 98k 111.mp4


vodie = "F:\迅雷下载\半路枪手.mkv"
import os
import ffmpeg

t = 0

for r,ds,fs in os.walk('.'): 
     for f in fs: 
         if f.endswith('mp4'): 
             file=os.path.join(r,f) 
             t=t+ float(ffmpeg.probe(file)['format']['duration']) 
print(t/60/60)

#ffmpeg -ss 00:23:46 -to 00:31:46 -accurate_seek -i F:\迅雷下载\阳光电影www.ygdy8.com.鬼吹灯之龙岭迷窟.HD.1080p.国语中字.mp4 -codec copy 1.mp4

