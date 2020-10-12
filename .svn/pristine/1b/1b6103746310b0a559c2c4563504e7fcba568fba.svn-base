string1 = "Lua"
-- "字符串 1 是"    Lua
print("\"字符串 1 是\"",string1)
string2 = 'runoob.com'

--字符串 2 是    runoob.com
print("字符串 2 是",string2)

--字符串 3 是    "Lua 教程"
string3 = [["Lua 教程"]]
print("字符串 3 是",string3)


--模式匹配
str = string.gsub("aaaa","a","z",3)
--zzza 3 3表示替换三次
print(str)

--7 9
string.find("Hello Lua user","Lua",1)

string.format("%c", 83)                 -- 输出S
string.format("%+d", 17.0)              -- 输出+17
string.format("%05d", 17)               -- 输出00017
string.format("%o", 17)                 -- 输出21
string.format("%u", 3.14)               -- 输出3
string.format("%x", 13)                 -- 输出d
string.format("%X", 13)                 -- 输出D
string.format("%e", 1000)               -- 输出1.000000e+03
string.format("%E", 1000)               -- 输出1.000000E+03
string.format("%6.3f", 13)              -- 输出13.000
string.format("%q", "One\nTwo")         -- 输出"One\
                                        -- 　　Two"
string.format("%s", "monkey")           -- 输出monkey
string.format("%10s", "monkey")         -- 输出    monkey
string.format("%5.3s", "monkey")        -- 输出  mon



--返回值为一个迭代函数
matchs = string.gmatch("Hello Lua User","%a+")
print(matchs)
for word in matchs do print(word) end


print(string.match("I have 2 questions for you.", "%d+ %a+"))

i = 2
str = "I have 2 questions for you. 30 level 3 event"
repeat
  str1 = string.match(str,"%d+ %a+",i)
  if type(str1) ~= "nil" then
    print(str1)
    i = i + 1
  end
until type(str1) == "nil"


-- 根据字符串创建表
local str2 = "this\nis\na\nisland"
local tbl1 = {}
local i = 0
while true do
  i = string.find(str2,"\n",i+1)
  print(i)
  if i == nil then
    break
  end
  tbl1[#tbl1+1]= i
end
print(table.concat(tbl1,","))


local str = "today is 2018-12-08"
local year,month,day = string.match(str, "(%d+)-(%d+)-(%d+)")
print(year, month, day)--2018   12  08


local pair = "name = Anna"
local start,stop,key,val = string.find(pair, "(%a+)%s*=%s*(%a+)")
print(start, stop ,key, val)-- 1    11  name    Anna

local pair = "name =Annasteraer"
local start,stop,key,val = string.find(pair, "(%a+)%s*=%s*(%a+)")
print(start, stop ,key, val)-- 1    11  name    Anna


function trim(str)
  return (string.gsub(str, "^%s*(.-)%s*$", "%1"))
end

print(trim("\t jun chow ")); -- jun chow