# 阅读目录 #

1、[基础正规表示法](#jump1)

 - 1.1：[以grep获取字符串](#jump1.1) 

 - 1.2：[万用字符表示规则](#jump1.2) 

 - 1.3：[?和$符号的其他含义](#jump1.3) 

2、[printf](#jump2)

3、[sed工具简介](#jump3)

4、[awk工具简介](#jump4)

5、[文件数据对比与打印的相关功能](#jump5)

 - 5.1：[diff](#jump5.1)
 
 - 5.2：[cmp](#jump5.2)  


<h2 id="1">1. <span id="jump1">基础正规表示法</span></h2>



<h3 id="1.1">1.1 <span id="jump1.1">以grep获取字符串：</span></h3>

![](https://i.imgur.com/i4qjNpX.png)

![](https://i.imgur.com/Tw0TP63.png)


在万用字符*是0-无限个字符，？是一个字符；在正则表达式中是0-无限个字符前一个相同字符。.一个前一个相同字符

    grep '^[a-z]' greptest #搜索以a-z开始的行
    grep '!$' greptest     #搜索以！结尾的行
    grep '\.$' greptest    #搜索以.结尾的行，需要加入转义
    grep 'g..d' greptest   #.只代表一个字符
    grep 'goo*g' greptest  #*代表重复前面0个或者多个字符
    grep '[.!]$' greptest  #以.!结尾的行
    grep '[^.!]$' greptest  #不以.!结尾的行'
    grep 'go\{2\}g' greptest #以g开头，2个o和g结尾的行
    grep ‘go\{2,5\}’ greptest #以g开头2到5个o的行
    grep 'go\{2,\}g' greptest #以g开头，2个以上的o，以g结尾的行
    

<h3 id="1.2">1.2 <span id="jump1.2">万用字符表示规则：</span></h3>、

![](https://i.imgur.com/6wFQuWR.png)

    ls -l ip?
    ls -l ip*

<h3 id="1.3">1.3 <span id="jump1.3">?和$符号的其他含义：</span></h3>、

？：上一个执行命令所返回值，如果执行正确返回值为0，错误返回值非0

$:表示当前shell的进程号（pid）

    echo $?
    echo $$
    
<h2 id="2">2. <span id="jump2">printf</span></h2>

![](https://i.imgur.com/LELXrWH.png)


<h2 id="3">3. <span id="jump3">sed工具简介</span></h2>

sed是一个非交互文本编辑器，必须通过行号或正则表达式制定需要改变的行

sed如何读取数据：sed从文件的一个文本行或者从标准输入读取数据，将读取的数据拷贝到一个编辑缓冲区，然后读命令行或者脚本的第一条命令，并使用这些查找模式或者定位行号来编辑它。重复此过程直到命令结束。


![](https://i.imgur.com/JAsq5c1.png)

![](https://i.imgur.com/fwi3l42.png)


![](https://i.imgur.com/oJmN6oj.png)


    cat -n greptest | sed '2a this line is added'
    cat -n greptest | sed '2i this line is inset'
    cat -n greptest | sed '2,3c this line is 2,3 replace'
    cat -n greptest | sed '2,8d'
    cat -n greptest | sed '2a this line is book'
    cat -n greptest | sed '2a this line is book' > greptestd #用数据流重导向可以改变源文件
    cat -n greptest | sed '1,8p'
    cat -n greptest | sed '$p' #显示最后一行
    cat -n greptest | sed 's /is//IS/'#把is替换为IS
    cat -n greptest | sed 's /is//IS/g'#把is替换为IS，全局替换

![](https://i.imgur.com/iflNVLZ.png)

可以对照1.1来比对。

    sed -n '^/a-z/'p greptest
    sed -n '^/!$/'p greptest
    sed -n '/g..d/'p greptest
    sed -n '/too*/'p greptest
    sed -n '/\.$/'p greptest
    sed -n '/go\{2\}g/'p greptest
    sed -n '/go\{2,\}g/'p greptest
    sed -n '2,/is/'p greptest
    sed -n '1,/is/'p greptest #第一行不会匹配
    sed -n '/good/=' greptest




    cat -n greptest | sed '/good/ a add a line in the next line'

    cat -n greptest | sed '/good/ i add a line in the before line'
    cat -n greptest | sed '/good/ a add a line in the next line'

![](https://i.imgur.com/ztGHDf4.png)

    sed -n '/glad/=' -e '/glad/p' greptest
    sed -n '/glad/=';'/glad/p' greptest
    sed -n '
    >/glad/=
    >/glad/p’ greptest

    sed -e 's/is/IS/' -e 's/am/WAS/' greptest
    sed -e 's/is/IS/g';'s/am/WAS/' greptest
    sed '
    >s/is/IS/g
    >s/am/WAS/' greptest



![](https://i.imgur.com/gDYpdtQ.png)

    #!/bin/sed -f
    /good/ a\
    this line is append by good


    chmod u+x tst.sed
    ./tst.sed


![](https://i.imgur.com/MLCyymh.png)

    sed 's/is/IS/gw greptest' greptest


![](https://i.imgur.com/TPF1NlG.png)

    sed '1G' greptest
    sed '/good/G' greptest
    sed -n 's/great/man &/' greptest


<h2 id="4">4. <span id="jump4">awk工具简介</span></h2>

![](https://i.imgur.com/ThrWFwu.png)


如果设置了-F选项，则awk每次读一条记录或一行，并使用制定的分隔符分隔指定域，如果没有设置，awk则嘉定空格为域分隔符。

![](https://i.imgur.com/CqTMqkV.png)

    awk 'BEGIN{print "this is the start----"} {print $1,$2,$3} END{print "this is the end"}' filename


![](https://i.imgur.com/jVzTI1I.png)





    awk '$0~/good/' greptest
    awk 'if($0~/good/) print $0' greptest
    awk 'if($0~/^[^a-zA-Z]/) print $0' greptest
    awk 'if($0~/!$/) print $0' greptest
    awk 'if($0~/g..d/) print $0' greptest
    awk 'if($0~/goo*/) print $0' greptest
    awk 'if($0~/good|glad/) print $0' greptest #|是或的意思
    awk 'if($0~/g00+/) print $0' greptest
    awk 'if($0~/g00？/) print $0' greptest

![](https://i.imgur.com/dGdAxBU.png)



![](https://i.imgur.com/bm8YZ4J.png)

    awk '{print NF,NR,$NF,$NR,$0}' greptest
    awk '{print NF,NR,$NF,$NR,$0}END{print "=====";print"FLIENAME"}' greptest
    awk 'BEGIN{FS=":"}{print NF,NR,$NF,$NR,$0}END{print "=====";print"FLIENAME"}' greptest


![](https://i.imgur.com/vP8HIOv.png)



![](https://i.imgur.com/wYHURRZ.png)

    awk 'gsub("good","GOOD"){print $0}' greptest


![](https://i.imgur.com/UsqUVrc.png)



![](https://i.imgur.com/ieqwam1.png)

![](https://i.imgur.com/lBbcIHh.png)

<h2 id="5">5. <span id="jump5">文件数据对比与打印的相关功能</span></h2>

<h3 id="5.1">5.1 <span id="jump5.1">diff：</span></h3>



<h3 id="5.2">5.2 <span id="jump5.2">cmp：</span></h3>






