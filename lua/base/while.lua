--[[
  lua中的循环有如下几种方式
  while
  for
  repeat... until
  break 退出昂当前循环或语句，并开始脚本执行紧接着的语句
  goto 将程序的控制点转移一个标签处
--]]

--[[
  while循环的语法
  while(条件) do
    pass
  end
--]]
a = 10
while(a < 15) do
  print(a)
  a = a + 1
end


--[[
  数值for循环
  泛型for循环
  --var 从 exp1 变化到 exp2，每次变化以 exp3 为步长递增 var，
  --并执行一次 "执行体"。exp3 是可选的，如果不指定，默认为1。
  for var=exp1,exp2,exp3 do  
    <执行体>  
  end  
--]]
print("----for")
for i=10,1,-1 do
  print(i)
end

function f(x)  
  print("function")  
  return x*2   
end 
--for的三个表达式在循环开始前一次性求值，以后不再进行求值
--因此f(5)=10，等价于for i=1,10,1 do print(i)  end
for i=1,f(5) do print(i)  end
for i=1,10,1 do print(i)  end

print("泛型循环")
--打印数组a的所有值  
a = {"one", "two", "three"}
for i, v in ipairs(a) do
    print(i, v)
end 


--[[
  repeat...until 循环语法格式
  repeat
   statements
  until( condition )
  注意到循环条件判断语句（condition）在循环体末尾部分，所以在条件进行判断前循环体都会执行一次。
  如果条件判断语句（condition）为 false，循环会重新开始执行，
  直到条件判断语句（condition）为 true 才会停止执行。
--]] 
a = 10
repeat
  a = a + 1
  print(a)
until(a > 15)

-- goto在5.2的版本中才开始有
-- continue
for i=1, 3 do
  if i <= 2 then
      print(i, "yes continue")
      goto continue
  end
  print(i, " no continue")
  ::continue::
  print([[i'm end]])
end