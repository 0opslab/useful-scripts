local account = require("account")
local a= account:new()
a:deposit(100)
local b = account:new()
b:deposit(50)


print(a.balance)
print(b.balance)

a:withdraw(1)
a:withdraw(3)
print(a.balance)
