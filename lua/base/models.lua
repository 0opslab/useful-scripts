local mymath =  {}

function mymath.add(a,b)
   print(a+b)
end

function mymath.sub(a,b)
   print(a-b)
end

function mymath.mul(a,b)
   print(a*b)
end

function mymath.div(a,b)
   print(a/b)
end

--现在，为了在另一个文件(例如，moduletutorial.lua)中访问此Lua模块，需要使用以下代码段。
-- mymathmodule = require("mymath")
-- mymathmodule.add(10,20)
-- mymathmodule.sub(30,20)
-- mymathmodule.mul(10,20)
-- mymathmodule.div(30,20)

