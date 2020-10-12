### Windows PowerShell基本语法及常用命令

PowerShell常用命令：

一 Get类

1.Get-Command ： 得到所有PowerShell命令，获取有关 cmdlet 以及有关 Windows PowerShell 命令的其他元素的基本信息。

                              包括Cmdlet、Alias、Function。

2.Get-Process ： 获取所有进程
3.Get-Help  ： 显示有关 Windows PowerShell 命令和概念的信息

4.Get-History  ： 获取在当前会话中输入的命令的列表

5.Get-Job ：  获取在当前会话中运行的 Windows PowerShell 后台作业

6.Get-FormatData ： 获取当前会话中的格式数据

7.Get-Event ： 获取事件队列中的事件

8.Get-Alias ： 获取当前会话的别名

9.Get-Culture ：获取操作系统中设置的当前区域性

10. Get-Date ：获取当前日期和时间

11. Get-Host ： 获取表示当前主机程序的对象

12.Get-Member ： 获取对象的属性和方法。

                             如：$var = 3

                                    $var | get-member

                              结果：TypeName: System.Int32

                             Name        MemberType      Definition                                                                                           
                             ----                   ----------         ----------                                                                                           
                             CompareTo       Method      int CompareTo(System.Object value), int CompareTo(int value)                                         
                             Equals              Method     bool Equals(System.Object obj), bool Equals(int obj)                                                 
                            GetHashCode    Method     int GetHashCode()                                                                                    
                            GetType            Method     type GetType()                                                                                       
                            GetTypeCode     Method     System.TypeCode GetTypeCode()                                                                        
                            ToString             Method     string ToString(), string ToString(string format), string ToString(System.IFormatProvider provider...

13.Get-Random ： 从集合中获取随机数或随机选择对象

14.Get-UICulture ： 获取操作系统中当前用户界面 (UI) 区域性设置

15.Get-Unique ： 从排序列表返回唯一项目

16.Get-Variable ：获取当前控制台中的变量

17.Get-EventLog ： 获取本地或远程计算机上的事件日志或事件日志列表中的事件

18.Get-ChildItem ： 获取一个或多个指定位置中的项和子项

19.Get-Content ： 获取指定位置的项的内容

20.Get-ItemProperty ：获取指定项的属性

21.Get-WmiObject ： 获取 Windows Management Instrumentation (WMI) 类的实例或可用类的相关信息

22.Get-Location  ：获取当前工作位置的相关信息（如：F:\Users\TaoMin ）

23.Get-PSDrive：获取当前会话中的 Windows PowerShell 驱动器

24.Get-Item：获取位于指定位置的项

25.Get-Process ：获取在本地计算机或远程计算机上运行的进程

26.Get-Service ： 获取本地或远程计算机上的服务

27.Get-Transaction ：获取当前（活动）事务

28.Get-ExecutionPolicy ：获取当前会话中的执行策略

 

二.Set类 （set类命令一般都含有参数）

1.Set-Alias ： 在当前 Windows PowerShell 会话中为 cmdlet 或其他命令元素创建或更改别名（替代名称）

                      如：如:Set-Alias aaa Get-Command

2.Set-PSDebug ：打开和关闭脚本调试功能，设置跟踪级别并切换 strict 模式

3.Set-StrictMode ：建立和强制执行表达式、脚本和脚本块中的编码规则

4.Set-Date ：将计算机上的系统时间更改为指定的时间

5.Set-Variable ：设置变量的值，如果该变量还不存在，则创建该变量

6.Set-PSBreakpoint ：在行、命令或者变量上设置断点

7.Set-Location ：将当前工作位置设置为指定的位置

8.Set-Item ：将项的值更改为命令中指定的值

9.Set-Service ：启动、停止和挂起服务并更改服务的属性

10.Set-Content ：在项中写入内容或用新内容替换其中的内容

11.Set-ItemProperty ：创建或更改某一项的属性值

12.Set-WmiInstance ：创建或更新现有 Windows Management Instrumentation (WMI) 类的实例

13.Set-ExecutionPolicy ：更改 Windows PowerShell 执行策略的用户首选项。

 

三.Write类 

 1.Write-Host ： 将自定义输出内容写入主机。类似于.net的 write()或者writeline()功能

 2.Write-Progress ：在 Windows PowerShell 命令窗口内显示进度栏

 3.Write-Debug ：将调试消息写入控制台

 4.Write-Verbose：将文本写入详细消息流

 5.Write-Warning ：写入警告消息

 6.Write-Error ： 将对象写入错误流

 7.Write-Output ： 将指定对象发送到管道中的下一个命令；如果该命令是管道中的最后一个命令，则在控制台上显示这些对象

 8.Write-EventLog  ：将事件写入事件日志

 

PowerShell变量、常量、数组：

一、变量

PowerShell的变量无需预定义，可直接使用。当使用一个变量时，该变量被自动声明。

变量以 $  符号开头。如：$a

PowerShell普通变量：

1.给变量赋值：

   方式一：

   $a = "This is a string"

   $b = 123

   $c = 0.125

   方式二：

   Set-Variable var 100

   Set-Variable var1 ”test“

   Set-Variable va2 800

2.获取变量值

   get-variable var   #获取单个变量值

   get-variable var*  #获取多个变量值

3.清空变量值

   clear-variable var

4.删除变量

   remove-variable var

5.连接两个字符串变量

   $a = "This is the 1st string"

   $b = "This is the 2nd string"

   $c = $a + " and " + $b

   $c

   结果：This is the 1st string and This is the 2nd string

6.变量的方法

   $date = Get-Date  #获取当前时间

   $date.AddDays(3)  #当前时间加三天

PowerShell特殊变量：

    PowerShell的特殊变量由系统自动创建。用户自定义的变量名称应该不和特殊变量相同。

    $^ ：前一命令行的第一个标记

    $$ ：前一命令行的最后一个标记

    $_ ：表示表示当前循环的迭代变量。

    $? ：前一命令执行状态，成功（Ture） 或者 失败（False）

    $Args ：为脚本或者函数指定的参数

    $Error ：错误发生时，错误对象存储于变量 $Error 中

    $Foreach ：引用foreach循环中的枚举器

    $Home ：用户的主目录

    $Host ：引用宿主 POWERSHELL 语言的应用程序

    $Input ：通过管道传递给脚本的对象的枚举器

    $LastExitCode ：上一程序或脚本的退出代码

    $Matches ： 使用 –match 运算符找到的匹配项的哈希表

    $PSHome ：Windows PowerShell 的安装位置

    $profile ：标准配置文件（可能不存在）

    $StackTrace ： Windows PowerShell 捕获的上一异常

    $Switch ：switch 语句中的枚举器

强制指定变量类型：

一般不需要为PowerShell的变量指定类型。但是也可以强制指定变量类型。

如：[int] $b = 5

      则此变量只能包含整数值，如果包含其他类型会出错。 如 [int] $b = "aaaa" 就会报错

常见变量类型如下：  

      [int] 、[long]、[string] 、[char] 、[bool] 、[byte] 、[double] 、[decimal] 、[single]

      [array] ：数组对象

      [xml] ：XML对象

      [hashtable] ：哈希表对象，类似于一个字典对象

 

二、常量

     PowerShell常量的值永远不会变。常量不能被删除。

     使用常量之前，需要通过Set-Variable来创建常量，且指定一些参数来使它等于某个常量。

     当使用常量的时候，必须用$开头。但是，使用Set-Variable定义常量时，不可用$符号开头。

     例如：

             $aryComputers = "loopback", "localhost"   #数组变量

             Set-Variable -name intDriveType -value 3 -option constant  #常量定义 常量：intDriveType 值：3

             foreach ($strComputer in $aryComputers)   #循环遍历数组对象

             {"Hard drives on: " + $strComputer

              #获取wmi对象 分类：win32_logicaldisk 电脑名称：$strComputer 源自数组对象 电脑过滤条件：drivetype = 3 ，驱动器类型为3

             Get-WmiObject -class win32_logicaldisk -computername $strComputer|  

             Where {$_.drivetype -eq $intDriveType}}

 

三、数组

      PowerShell中创建数组的方式非常简单：

      $arrName = "LOGONSERVER","HOMEPATH", "APPDATA","HOMEDRIVE"

      和创建变量方式一样，只是赋值时可以付多个值。

      使用数组方式：$arrName[0] ：表示数组中第一个数组项的值

       数组从0开始

 

PowerShell注释用法：

       注释符号：#

       用法如下（一般在.ps1脚本文件中使用）：

       Get-Process   #此处写注释

       sort ws

 

PowerShell运算符用法：

运算符如下：

1.算术二元运算符：

      +   加、串联

       -    减

       *    乘

       /    除

       %   模

  2.赋值运算符

         =   +=    -=    *=    /=   %=

  3.逻辑运算符

         ! 不等于

         not  非

         and  且

          or   或

    4.比较运算符（可在运算符前加上 i 或者 c ，以指定是否区分大小写）

           -eq  等于   -ceq  区分大小写

           -ne  不等于

           -gt   大于

           -ge  大于等于

            -lt    小于

            -le   小于等于

            -contains  包含 

     用法如下：

            此数组中是否包含3：           1,2,3,5,3,2 –contains 3

            返回所有等于3的元素：        1,2,3,5,3,2 –eq 3

            返回所有小于3的元素：         1,2,3,5,3,2 –lt 3

            测试 2 是否存在于集合中：   if (1, 3, 5 –contains 2)

    5.调用运算符

             &  可用于调用脚本块或者命令/函数的名称 

                    用法如下：

                     $a = { Get-Process | Select -First 2}  #获取处理器信息排名前二的两条记录

                     &$a

              .  可用于方法调用

                     用法如下：

                      $a = "这是字符串"

                      $a.substring(0,3)

                 ::  用于静态方法调用   

 

                       用法如下：         

                       [DateTime]::IsLeapYear(2008)

                       结果：True  

                       [DateTime]::Now  #返回当前时间

      6.字符串运算符

                +  连接两个字符串

                 *   按指定次数重复字符串

                  -f   设置字符串格式

                   -replace   替换运算符    用法："abcd" -replace "bc","TEST"   返回结果：aTESTd

                   -match   正则表达式匹配

                   -like       通配符匹配

      7.其他运算符

                    , 数组构造函数

                     ..  范围运算符

                     -is  类型鉴别器  用法： $a = 100  $a -is [int]  返回结果：Ture  $a -is [string] 返回结果：False

                     -as   类型转换器  用法： 1 -as [string]   #将1作为字符串处理

                     -band  二进制与

                     -bor     二进制或

                     -bnot    二进制非

       8.运算符优先级

                       (){} 

                       @$  

                        !  

                        [] 

                         . 

                        &   

                        ++或者--   

                        一元+ -   

                          * / %

                          二元 + -

                          比较运算符

                          -and -or

                            |

                            >>>

                             =

         9.WindowsPowershell命令解析顺序

                          别名（alias）

                          函数

                           cmdlet

                            脚本

                             可执行文件

                             正常文件

 

PowerShell函数用法：

用法一如下：（函数中改变变量值并不影响实际值）

               $var1=10
               function one{"The Variable is $var1"}
               function two{$var1=20;one}
               one
               two
               one

执行结果：

              The Variable is 10
              The Variable is 20
              The Variable is 10

用法二如下：（函数中变量值的改变要用$Script:var的形式）

                $var1=10
                function one{"The Variable is $var1"}
                function two{$Script:var1=20;one}
                one
                two
                one

执行结果：

               The Variable is 10
               The Variable is 20
               The Variable is 20

 

PowerShell条件控制的用法：        

一、循环类

1.foreach的用法

用法一如下：

            $var=1..6 #定义数组

            foreach($i in $var)
            {
                     $n++
                     Write-Host "$i"
             }
            Write-Host "there were $n record"

执行结果：

            1
            2
            3
            4
            5
            6
            there were 6 records

用法二如下：直接获取管道数据

            $n = 0
            "a","b","c","d" | foreach{
                    $n++
                    Write-Host $_
                    }
            Write-Host "there were $n record"

执行结果：

            a

            b

            c

            d

             there were 4 records

 

2.while的用法

用法一如下：
            $n = 0
            while($n -le 5)    #当$n小于等于5时进行下面操作
            {
                  write-host $n
                  $n++
            }

执行结果：

            0

            1
            2
            3
            4
            5

 

3. do...while的用法

用法一如下：
            $n = 0
            do
            {
                  write-host $n
                  $n++
            }
            while($n -ne 3)    #当$n<>3时进行循环操作

执行结果：

            0

            1
            2

 

4. do...until的用法

用法一如下：
            $n = 0
            do
            {
                  write-host $n
                  $n++
            }
            until($n -gt 3)    #当$n>3时停止操作

执行结果：

           0

           1
           2

           3


 

二、分支类

1.if用法

   if语法结构如下：

              if（条件1）

              {处理1}

               elseif（条件2）

               {处理2}

               ...elseif 可多次重复

               else

               {处理3}

用法如下：

             Get-Service |foreach{  #foreach{必须放在一起，不可换行放置
                      if($_.status -eq "running"){   #if(){ 必须放在一起，不可换行放置
                                  write-host $_.displayname "("$_status")" -foregroundcolor "green"
                        }
                     else
                     {
                                 write-host $_.displayname "("$_status")" -foregroundcolor "red"
                     }
            }

执行结果：

             Windows Audio Endpoint Builder ( )
             Windows Audio ( )
             ActiveX Installer (AxInstSV) ( )
             BitLocker Drive Encryption Service ( )
             Base Filtering Engine ( )

 

2.switch用法

   switch语法结构如下：

               switch [-regex | -wildcard | -exact] [-casesensitive]（表达式）| -file filename   #表达式可以为数组，为数组时顺序处理数组每一项 

                                                                                                                  # -file表示从文本获得输入，读取文本每一行，并对其执行switch块

               {

                     字符1|数字1|变量1|表达式1

                      {处理1}     #此处可加上;break 表示若匹配上则跳出switch语句      

                      字符2|数字2|变量2|表达式2

                      {处理2}

                       ...以上的组合可有多个，不可重复

                       default   #默认处理方式，这个是防止匹配不上时的处理方式，类似错误处理。且default语句只可有一个

                        {处理3}

               }

 用法一如下： switch（表达式）

                     $a = 3
                     switch($a)
                     {
                              1
                              {"It's one";break}   #break:表示若匹配跳出swith语句
                              2
                              {"It's two";break}
                              3
                              {"It's three";break}
                               4
                              {"It's four";break}
                               5
                               {"It's five";break}
                               default
                                {"It's unknown";break}
                      }

 

执行结果：

              It's three

              若 $a = 8  执行结果为：It's unknown

用法二如下：switch -casesensitive （表达式）表示区分大小写

             $day = "day1"
             switch -casesensitive($day)  # -casesensitive 表示大小写敏感，即区分大小写
             {
                    day1
                    {"It's Monday" ;break}
                    day2
                    {"It's Tuesday";break}
                    day3
                    {"It's Wednesday";break}
                    day4
                    {"It's Thursday";break}
                    day5
                    {"It's Friday";break}
                    day6
                    {"It's Saturday";break}
                    day7
                    {"It's Sunday";break}
                    default
                   {"It's unknown";break}
              }

 

执行结果： It's Monday

                  若定义  $day = "Day1"  执行结果：It's unknown

用法三如下：switch -regex（表达式）表示正则表达式匹配

      $day = "day5"
      switch -regex ($day)
      {
           ^[a-z]+$ 
           {"字母，匹配为：" +$_ ;break}
           ^[\d]+$ 
           {"数字，匹配为：" +$_ ;break}
           ^\w+$ 
           {"字母+数字，匹配为：" +$_ ;break}
           default
           {"什么都不是" +$_;break}
      }

执行结果：字母+数字，匹配为：day6

                  若 $day = "day" 执行结果为：字母，匹配为：day6

                  若 $day = "1234" 执行结果为：数字，匹配为：1234

                  若 $day = 12 执行结果为：数字，匹配为：123

                  若 $day = "*&^%" 执行结果为：什么都不是，匹配为：*&^%

用法四如下：switch -regex（表达式）表示正则表达式匹配 表达式可为数组

       $day = "day5","day6"
       switch -regex ($day)
       {
              ^[a-z]+$ 
              {"字母，匹配为：" +$_ ;}
              ^[\d]+$ 
              {"数字，匹配为：" +$_ ;}
              ^\w+$ 
              {"字母+数字，匹配为：" +$_ ;}
              default
              {"什么都不是" +$_;}
       }

执行结果：字母+数字，匹配为：day5

                 字母+数字，匹配为：day6

用法五如下：switch -wildcard （表达式）表示通配符匹配 

            $day = "day2"
            switch -wildcard ($day)
            {
                 day2 
                 {"day2，匹配为：" + $_;break}
                  day3
                 {"day3，匹配为：" + $_;break}
                 day* 
                 {"通配符，匹配为：" + $_;break}
                 default
                 {"什么都不是：" +$_;break}
            }

执行结果：day2，匹配为：day2

                 若 $day = "day5",执行结果为：通配符，匹配为：day5

                 若 $day = "sunshine",执行结果为：什么都不是：sunshine


 

三、跳转类

1.break用法：break语句出现在foreach、for、while、switch等结构中时，break语句将使windows powershell立即退出整个循环。

                      在不循环的switch结构中，powershell将退出switch代码块。

 用法如下： 

             $var = 0
             while ($var -lt 10)
             {
                    $var += 1
                    if($var -eq 5)
                    {
                          break       #当var=5时，终止while循环

                     }
                    write-host $var
              }

执行结果：

              1
              2
              3
              4

 

2.continue用法：continue语句出现在foreach、for、while等循环结构中时，continue语句将使windows powershell立即退出某一次轮循环，并继续下一轮循环。

用法如下：

          $var = 0
          while ($var -lt 10)
          {
                $var += 1
                if($var -eq 5)
                {
                        continue       #当var=5时，跳出本轮循环，继续下一轮循环
                }
               write-host $var
         }

执行结果：

            1
            2
            3
            4
            6
            7
            8
            9
            10

 

 PowerShell抛出异常的Throw用法：

 用法如下：

                   Throw  字符串|异常|ErrorRecord

                  如：throw  "danger"

返回结果：danger 及详细错误信息

 

PowerShell获取出错信息的用法：

用法如下：
            function one
           {
                 get-process -ea stop  #-ea定义错误发生以后该如何继续执行，意同-ErrorAction
                 get-childitem ada -ErrorAction stop  #此处有错误 路径ada不存在
                 get-process -ErrorAction stop
           }

          one

返回结果：报出错误信息

 

PowerShell单步调试的用法：

用法如下：

           #单步调试 首先设置调试可用 set-psDebug -step ;若要设置为非调试状态 可用 set-psDebug -off
           for($i = 1;$i -le 10 ; $i++)
           {
                    write-host "loop number $i"
           }

执行结果：会出现逐步调试的对话框