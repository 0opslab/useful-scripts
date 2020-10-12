--[[
  1.完成指定的任务，这种情况下函数作为调用语句使用；
  2.计算并返回值，这种情况下函数作为赋值语句的表达式使用。
  optional_function_scope function function_name( argument1, argument2, argument3..., argumentn)
    function_body
    return result_params_comma_separated
  end
  optional_function_scope: 该参数是可选的制定函数是全局函数还是局部函数，未设置该参数默认为全局函数，如果你需要设置函数为局部函数需要使用关键字 local。

  function_name: 指定函数名称。

  argument1, argument2, argument3..., argumentn: 函数参数，多个参数以逗号隔开，函数也可以不带参数。

  function_body: 函数体，函数中需要执行的代码语句块。

  result_params_comma_separated: 函数返回值，Lua语言函数可以返回多个值，每个值以逗号隔开。
--]]

--定义一个函数(简单的递归)
function fact(n)
  if n == 0 then
    return 1
  else
    return n * fact(n -1)
  end
end

print(fact(5))
--将一个函数复制给一个变量
fact1 = fact
print(fact1(5))

--定义一个函数，其中一个参数为函数
function testFun(tab,func)
  for k,v in pairs(tab) do
    print(func(k,v));
  end
end

--函数使用
tab={key1="val1",key2="val2"};
testFun(tab,function(k,v)--匿名函数
    return k.."="..v;
  end
);

--多个返回值
s,e = string.find("www.runoob.com", "runoob")
print(s,e)


--[[
Lua 函数可以接受可变数目的参数，和 C 语言类似，在函数参数列表中使用三点 ... 表示函数有可变的参数。
{...} 表示一个由所有变长参数构成的数组
我们也可以通过 select("#",...) 来获取可变参数的数量:
有时候我们可能需要几个固定参数加上可变参数，固定参数必须放在变长参数之前
通常在遍历变长参数的时候只需要使用 {…}，然而变长参数可能会包含一些 nil，那么就可以用 select 函数来访问变长参数了：select('#', …) 或者 select(n, …)

select('#', …) 返回可变参数的长度
select(n, …) 用于访问 n 到 select('#',…) 的参数
--]]

local function add(...)
  local s = 0
  for i,v in ipairs{...} do s = s+v end
  return s
end
print(add(3,4,5,6,7))

local function average(...)
  result = 0
  local arg={...}    --> arg 为一个表，局部变量
  for i,v in ipairs(arg) do
     result = result + v
  end
  print("总共传入 " .. #arg .. " 个数")
  return result/#arg
end

print("平均值为",average(10,5,3,4,5,6))