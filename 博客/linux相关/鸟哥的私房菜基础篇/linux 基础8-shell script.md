# 阅读目录 #

1、[什么是shell script](#jump1)

- 1.1：[介绍](#jump1.1)

- 1.2：[shell script的良好习惯](#jump1.2)

2、[shell script简单练习](#jump2)

- 2.1：[使用read输出所输入数据](#jump2.1)

- 2.2：[使用所输入文件名建立文件](#jump2.2)

- 2.3：[计算数值](#jump2.3)

3、[善用test判断式](#jump3)

- 3.1：[判断文件](#jump3.1)

- 3.2：[判断整数](#jump3.2)

- 3.3：[判断字符串](#jump3.3)

- 3.4：[判断表达式](#jump3.4)

- 3.5：[用[]来代替test](#jump3.5)

4、[条件判断](#jump4)

- 4.1：[if判断](#jump4.1)

- 4.2：[case判断](#jump4.2)

- 4.3：[函数功能](#jump4.3)

- 4.4：[循环控制(while)](#jump4.4)

- 4.5：[循环控制(until)](#jump4.5)

- 4.6：[循环控制(for)](#jump4.2)




 

<h2 id="1">1. <span id="jump1">什么是shell script</span></h2>



<h3 id="1.1">1.1 <span id="jump1.1">介绍：</span></h3>

什么是 shell script (程序化脚本) 呢？就字面上的意义，我们将他分为两部份。 在『 shell 』部分，我们在bash当中已经提过了，那是一个文字介面底下让我们与系统沟通的一个工具介面。那么『 script 』是啥？ 字面上的意义， script 是『脚本、剧本』的意思。整句话是说， shell script 是针对 shell 所写的『剧本！』

什么东西啊？其实， shell script 是利用 shell 的功能所写的一个『程序 (program)』，这个程序是使用纯文字档，将一些 shell 的语法与命令(含外部命令)写在里面， 搭配正规表示法、管线命令与数据流重导向等功能，以达到我们所想要的处理目的。

 shell script 更提供阵列、回圈、条件与逻辑判断等重要功能，让使用者也可以直接以 shell 来撰写程序，而不必使用类似 C 程序语言等传统程序撰写的语法呢！

<h3 id="1.2">1.2 <span id="jump1.2">shell script的良好习惯：</span></h3>


    [root@www ~]# mkdir scripts; cd scripts
    [root@www scripts]# vi sh01.sh
    #!/bin/bash
    # Program:
    #   This program shows "Hello World!" in your screen.
    # History:
    # 2005/08/23VBirdFirst release
    PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
    export PATH
    echo -e "Hello World! \a \n"
    exit 0

在本章当中，请将所有撰写的 script 放置到你家目录的 ~/scripts 这个目录内， 未来比较好管理啦！上面的写法当中，鸟哥主要将整个程序的撰写分成数段，大致是这样：

1、第一行 #!/bin/bash 在宣告这个 script 使用的 shell 名称：
因为我们使用的是 bash ，所以，必须要以『 #!/bin/bash 』来宣告这个文件内的语法使用 bash 的语法！那么当这个程序被运行时，他就能够加载 bash 的相关环境配置档 (一般来说就是 non-login shell 的 ~/.bashrc)， 并且运行 bash 来使我们底下的命令能够运行！这很重要的！(在很多状况中，如果没有配置好这一行， 那么该程序很可能会无法运行，因为系统可能无法判断该程序需要使用什么 shell 来运行啊！)

2、程序内容的说明：
整个 script 当中，除了第一行的『 #! 』是用来宣告 shell 的之外，其他的 # 都是『注解』用途！ 所以上面的程序当中，第二行以下就是用来说明整个程序的基本数据。一般来说， 建议你一定要养成说明该 script 的：1. 内容与功能； 2. 版本资讯； 3. 作者与联络方式； 4. 建档日期；5. 历史纪录 等等。这将有助於未来程序的改写与 debug 呢！

3、主要环境变量的宣告：
建议务必要将一些重要的环境变量配置好，鸟哥个人认为， PATH 与 LANG (如果有使用到输出相关的资讯时) 是当中最重要的！ 如此一来，则可让我们这支程序在进行时，可以直接下达一些外部命令，而不必写绝对路径呢！比较好啦！

4、主要程序部分
就将主要的程序写好即可！在这个例子当中，就是 echo 那一行啦！

5、运行成果告知 (定义回传值)
是否记得我们讨论一个命令的运行成功与否，可以使用 $? 这个变量来观察～ 那么我们也可以利用 exit 这个命令来让程序中断，并且回传一个数值给系统。 在我们这个例子当中，鸟哥使用 exit 0 ，这代表离开 script 并且回传一个 0 给系统， 所以我运行完这个 script 后，若接著下达 echo $? 则可得到 0 的值喔！ 更聪明的读者应该也知道了，呵呵！利用这个 exit n (n 是数字) 的功能，我们还可以自订错误信息， 让这支程序变得更加的 smart 呢！


<h2 id="2">2. <span id="jump2">什么是shell script</span></h2>



<h3 id="2.1">2.1 <span id="jump2.1">使用read输出所输入数据：</span></h3>

    #!/bin/bash
    # Program:
    #   This program is used to print your input
    # History:
    # 创建时间  创建人 版本信息
    PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
    export PATH
    
    read -p "please input your xing:" xing   
    read -p "please input your ming:" ming
    
    echo "your name is:$xing $ming"

<h3 id="2.2">2.2 <span id="jump2.2">使用所输入文件名建立文件：</span></h3>

    #!/bin/bash
    # Program:
    #   This program is used to you input name tp create file or dir
    # History:
    # 创建时间  创建人 版本信息
    PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
    export PATH
    
    read -p "please input a file name:" filename   
    file1="$filename""one"
    file2="$filename""two"

    dir="$filename""three"

    touch $file1
    touch $file2
    mkdir $dir



<h3 id="2.3">2.3 <span id="jump2.3">计算数值：</span></h3>

    #!/bin/bash
    # Program:
    #   This program is used to two number*
    # History:
    # 创建时间  创建人 版本信息
    PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
    export PATH
    
    read -p "please input your first number:" firnu  
    read -p "please input your second number:" secnu  
    total=$(($firnu*secnu))
    echo "$fisnu*$secnu= $total"

<h2 id="3">3. <span id="jump3">善用test判断式 script</span></h2>



<h3 id="3.1">3.1 <span id="jump3.1">判断文件：</span></h3>

![](https://i.imgur.com/XsG1nMr.png)

文件名的判断：

test –b File            文件存在并且是块设备文件

test –c File            文件存在并且是字符设备文件

test –e File            文件存在

test –d File            文件存在并且是目录

test –f File            文件存在并且是普通文件

test –p File            文件存在并且是一个命名管道

test –S File            文件存在并且是一个套接字

test –L File            文件存在并且是一个符号链接（同-h）


文件档案权限的侦测：

test –r File            文件存在并且可读

test –w File            文件存在并且可写

test –x File            文件存在并且可执行

test –u File            文件存在并且设置了它的set-user-id位

test –g File            文件存在并且是设置了组ID

test –k File             文件存在并且设置了sticky位

test –s File             文件存在并且大小大于0

文档之间的比较：

test  File1 –ef  File2                            两个文件具有同样的设备号和i结点号

test  File1 –nt  File2                            文件1比文件2 新

test  File1 –ot  File2                            文件1比文件2 旧


<h3 id="3.2">3.2 <span id="jump3.2">判断整数：</span></h3>

![](https://i.imgur.com/UltTwTS.png)

test 整数1 –eq 整数2                       整数相等

test 整数 1 –ge 整数2                      整数1大于等于整数2

test 整数1 –gt 整数 2                       整数1大于整数2

test 整数1 –le 整数 2                       整数1小于等于整数2

test 整数1 –lt 整数 2                         整数1小于整数2

test 整数1 –ne 整数 2                      整数1不等于整数2



<h3 id="3.3">3.3 <span id="jump3.3">判断字符串：</span></h3>

![](https://i.imgur.com/NTCHpcV.png)

test –n 字符串                          字符串的长度非零则为true

test –z 字符串                           字符串的长度为零则为true

test 字符串1＝字符串 2          字符串相等则为true

test 字符串1 !＝字符串2         字符串不等则为true


<h3 id="3.4">3.4 <span id="jump3.4">判断表达式：</span></h3>

![](https://i.imgur.com/pCiO8uA.png)

if test  (表达式为真)

if test !表达式为假

test 表达式1 –a 表达式 2                两个表达式都为真

test 表达式1 –o 表达式2                 两个表达式有一个为真


    #!/bin/bash
    # Program:
    #   This program will show you filetype and permission
    # History:
    # 创建时间  创建人 版本信息
    PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
    export PATH
    
    read -p "please input a file name:" filename  
    test -z "$filename" && echo"please input something!!!" exit 0
    test ! -e "$filename" && echo"the file $filename DO NOT exist!!!" && exit 0 

    test -f "$filename" && filetype="is a regular file"
    test -d "$filename" && filetype="is a directory"
    test -p "$filename" && filetype="is a PIPO file"
    test -b "$filename" && filetype="is a block file"
    test -c "$filename" && filetype="is a character file"
    test -S "$filename" && filetype="is a socket file"
    test -L "$filename" && filetype="is a link file"

    test -r "$filename" && per="$per readable"
    test -w "$filename" && per="$per writable"
    test -x "$filename" && per="$per executable"
    test -u "$filename" && per="$per UID"
    test -g "$filename" && per="$per GID"
    test -k "$filename" && per="$per stick bit"

    echo "the file $filename you have input $filetype,and the permission is $per"





    #!/bin/bash
    # Program:
    #   This program will use -a -o to show filetype and permission
    # History:
    # 创建时间  创建人 版本信息
    PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
    export PATH
    
    read -p "please input a file name:" filename  
    [ -z "$filename" ] && echo"please input something!!!" exit 0
    [ ! -e "$filename" ] && echo"the file $filename DO NOT exist!!!" && exit 0 

    test -r "$filename" -o -w "$filename" && per1="readable or writable"

    [ -r "$filename" -a -x "$filename" ] && per2="readable and executable"
    
    echo "the file $filename is $per1,$per2"



   
<h3 id="3.5">3.5 <span id="jump3.5">用[]来代替test：</span></h3>




    #!/bin/bash
    # Program:
    #   This program will use [] to show filetype and permission
    # History:
    # 创建时间  创建人 版本信息
    PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
    export PATH
    
    read -p "please input a file name:" filename  
    [ -z "$filename" ] && echo"please input something!!!" exit 0
    [ ! -e "$filename" ] && echo"the file $filename DO NOT exist!!!" && exit 0 

    [ -f "$filename" ] && filetype="is a regular file"
    [ -d "$filename" ] && filetype="is a directory"
    [ -p "$filename" ] && filetype="is a PIPO file"
    [ -b "$filename" ] && filetype="is a block file"
    [ -c "$filename" ] && filetype="is a character file"
    [ -S "$filename" ] && filetype="is a socket file"
    [ -L "$filename" ] && filetype="is a link file"

    [ -r "$filename" ] && per="$per readable"
    [ -w "$filename" ] && per="$per writable"
    [ -x "$filename" ] && per="$per executable"
    [ -u "$filename" ] && per="$per UID"
    [ -g "$filename" ] && per="$per GID"
    [ -k "$filename" ] && per="$per stick bit"

    echo "the file $filename you have input $filetype,and the permission is $per"



<h2 id="4">4. <span id="jump1">条件判断 script</span></h2>


![](https://i.imgur.com/LEjtRpN.png)


<h3 id="4.1">4.1 <span id="jump4.1">if判断：</span></h3>

![](https://i.imgur.com/ROejTZb.png)

使用if/else:
    #！/bin/sh
    read -p "please input (y/Y n/N):" yn
    
    if [ "$yn" = "y" -o "$yn" = "Y" ]; then
          echo "ok go on please"
          exit 0
    fi
    if [ "$yn" = "n" -o "$yn" = "N" ]; then
          echo "oh ,bye bye"
          exit 0
    fi    
    echo "sorry,i don't know your choice $yn"

使用if/elif/else:

    #！/bin/bash
    read -p "please input (y/Y n/N):" yn
    
    if [ "$yn" = "y" -o "$yn" = "Y" ]; then
          echo "ok go on please"
          exit 0
    elif [ "$yn" = "n" -o "$yn" = "N" ]; then
          echo "oh ,bye bye"
          exit 0
    else    
          echo "sorry,i don't know your choice $yn"
    fi


使用if和$1,$0

    #！/bin/bash
    
    if [ "$1" == "one" ]; then
          echo "this is the first paramter"
    elif [ "$1" == "" ]; then
          echo "you should input a paramter,just like >$0 someword"
    else    
          echo "only one is allowed to input"
    fi


使用if和netstat -tlun| grep ""

    #！/bin/sh
    echo "this script will to find which service have started"
    #to find www service
    testing='netstat -tlun| grep ":80"'
    if [ -n "$testing" ];then
        echo "www server has started"
    fi
    
    
    #to find vsftpd service
    testing='netstat -tlun| grep ":20"'
    if [ -n "$testing" ];then
        echo "vsftpd server has started"
    fi
    
    
    #to find ssh service
    testing='netstat -tlun| grep ":22"'
    if [ -n "$testing" ];then
        echo "ssh server has started"
    fi
    
    
    #to find mail service
    testing='netstat -tlun| grep ":25"'
    if [ -n "$testing" ];then
        echo "mail server has started"
    fi



<h3 id="4.2">4.2 <span id="jump4.2">case判断：</span></h3>

![](https://i.imgur.com/rIOYUUx.png)


使用case和$1输出

    #！/bin/bash
    
    case $1 in
            "one")
                   echo "the paramter is one"
                   ;;
            "two")
                   echo "the paramter is two"
                   ;;
            "three")
                   echo "the paramter is three"
                   ;;
            *)
                   echo "you only can input {one|two|three}"
                   ;;
    esac

<h3 id="4.3">4.3 <span id="jump4.3">函数功能：</span></h3>

![](https://i.imgur.com/0xCpZTQ.png)


    #！/bin/bash
    
    function printinfo()
    {
          echo "you choice is"
    }
    case $1 in
            "one")
                   printinfo; echo $1 | tr -s 'a-z' 'A-Z'
                   ;;
            "two")
                   printinfo; echo $1 | tr -s 'a-z' 'A-Z'
                   ;;
    esac


    #！/bin/bash
    
    function printinfo()
    {
          echo "you choice is $1,$2"
    }
    case $1 in
            "one")
                   printinfo "the first one" "successful"
                   ;;
            "two")
                   printinfo "the second one" "successful"
                   ;;
    esac


<h3 id="4.4">4.4 <span id="jump4.4">循环控制(while)：</span></h3>

![](https://i.imgur.com/TgGmsTh.png)

    #!/bin/bash
    # Program:
    #   user input y/Y to stop while
    # History:
    # 创建时间  创建人 版本信息
    PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
    export PATH
    
    while [ "$yn" !="y" -a "$yn" !="Y" ]
    do
             read -p "please input y/Y to stop while:" yn
    done


<h3 id="4.5">4.5 <span id="jump4.5">循环控制(until)：</span></h3>

    #!/bin/bash
    # Program:
    #   user input y/Y to stop until
    # History:
    # 创建时间  创建人 版本信息
    PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
    export PATH
    
    untile [ "$yn" !="y" -o "$yn" !="Y" ]
    do
             read -p "please input y/Y to stop while:" yn
    done

<h3 id="4.6">4.6 <span id="jump4.6">循环控制(for)：</span></h3>

![](https://i.imgur.com/Fhg3XbK.png)

while、until和for循环进行数据处理

    #!/bin/bash
    # Program:
    #   use while to add 1 to 100
    # History:
    # 创建时间  创建人 版本信息
    PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
    export PATH

    i=0
    s=0
    
    while [ $i -lt 100 ]
    do
             i=$(($i)+1)
             s=$(($s)+($i))
    done
    echo "1+2+3...+$i=$s"



    #!/bin/bash
    # Program:
    #   use until to add 1 to 100
    # History:
    # 创建时间  创建人 版本信息
    PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
    export PATH

    i=0
    s=0
    
    while [ $i = 100 ]
    do
             i=$(($i)+1)
             s=$(($s)+($i))
    done
    echo "1+2+3...+$i=$s"



    #!/bin/bash
    # Program:
    #   use for to add 1 to 100
    # History:
    # 创建时间  创建人 版本信息
    PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
    export PATH

    i=0
    s=0
    
    for ((i=0;i=100;i++))
    do
             s=$(($s)+($i))
    done
    echo "1+2+3...+$i=$s"

使用for循环输出动物信息

    #!/bin/bash
    # Program:
    #   use for to display some information
    # History:
    # 创建时间  创建人 版本信息
    PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
    export PATH

    for animal in cat dog pig
    do
         case $animal in
                      "cat")
                           echo "$animal miao miao jiao"
                           ;;
                      "dog")
                           echo "$animal wang wang jiao"
                           ;;
                      "pig")
                           echo "$animal pig jiao"
                           ;;
         esca
    done


使用for循环显示输入目录下所有文件的属性

  sp filename可以用来读取某一个文档，然后把其中的某几行拷贝到正在编辑的shell script。


    #!/bin/bash
    # Program:
    #   This program will show you filetype and permission
    # History:
    # 创建时间  创建人 版本信息
    PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
    export PATH
    
    read -p "please input a directory:" dir  
    if [ -z "$dir" -a ! -d "$dir"];then
          echo "you have input nothing or $dir is NOT a dirrctory!"
          exit 0
    fi
    file='ls $dir'
    for filename in $file
    do
    test -f "$dir/$filename" && filetype="is a regular file"
    test -d "$dir/$filename" && filetype="is a directory"
    test -p "$dir/$filename" && filetype="is a PIPO file"
    test -b "$dir/$filename" && filetype="is a block file"
    test -c "$dir/$filename" && filetype="is a character file"
    test -S "$dir/$filename" && filetype="is a socket file"
    test -L "$dir/$filename" && filetype="is a link file"

    test -r "$dir/$filename" && per="$per readable"
    test -w "$dir/$filename" && per="$per writable"
    test -x "$dir/$filename" && per="$per executable"
    test -u "$dir/$filename" && per="$per UID"
    test -g "$dir/$filename" && per="$per GID"
    test -k "$dir/$filename" && per="$per stick bit"

    echo "the file $dir/$filename you have input $filetype,and the permission is $per"   

    filetype=""
    per="" 
    done
    
 



