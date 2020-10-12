
-- 创建一个空的table
local tbl1 = {}

--直接初始表
local tbl2 = {"apple","huawei"}


--简单的table操作
a = {}
a["key"]="value"
key = 10
a[key] = 22
for k,v in pairs(a) do
  print(k .. ":".. v)
end

--对table的夙瑶使用方括号[]，lua也提供了操作。
a3 = {}
for i = 1, 10 do
    a3[i] = i
end
a3["key"] = "val"
print(a3["key"])
print(a3["none"])
--通过nil删除 从table中把键值删除
a3["key"] = nil
for k,v in pairs(a3) do
  print(k .. ":".. v)
end

--pairs 和 ipairs 的区别