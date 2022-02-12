# 阅读目录 #

1、[什么是例行性命令](#jump1)

- 1.1：[linux工作排程的种类](#jump1.1)

- 1.2：[系统常见的例行性命令有哪些](#jump1.2)


2、[仅执行一次的工作排程](#jump2)

3、[循环执行的例行性命令](#jump3)

- 3.1：[使用者设定](#jump3.1)

- 3.2：[系统设定](#jump3.2)



<h2 id="1">1. <span id="jump1">什么是例行性命令</span></h2>



<h3 id="1.1">1.1 <span id="jump1.1">linux工作排程的种类：</span></h3>

linux例行性命令主要有两种：

- at：仅执行一次就从linux的任务中取消
- cron：将持续例行性的工作下去



<h3 id="1.2">1.2 <span id="jump1.2">系统常见的例行性命令有哪些：</span></h3>






<h2 id="2">2. <span id="jump2">仅执行一次的工作排程</span></h2>

![](https://i.imgur.com/7LKCatM.png)

建立date.sh
    #!/bin/bash
    #program: this program to show time like: yyy-mm-dd hh-mm-ss AM/PM
    #history:
    #2009-10-07 first realease lin xiyu
    
    PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
    echo "Today is 'date +%F\ %r'"
给test1用户发送邮件
    at 16:57
    at>/bin/mail -s "'/bin/bash /root/date.sh'" test1
    at> <EOT> 
    job 48 at 2009-10-07 16.57
    

    ls -ls /var/spool/at  #显示该目录下的at例行性命令

    mail #在test1用户中查询邮件
    t 1  #全部显示第一封邮件
    x  #退出


    ls /etc/ | grep at  #显示/etc目录下所有含有at字符的文件





![](https://i.imgur.com/1gc0S7L.png)

  
第二种

    vi t1.txt
    at 17:05 2009-10-07
    at>/bin/mail -s "'/bin/bash /root/date.sh'" test1<t1.txt
    at> <EOT> 
    job 48 at 2009-10-07 17:05    

第三种和-m的解释

    at -m 05:07pm october 7
    at>/bin/mail -s "'/bin/bash /root/date.sh'" test1<t1.txt
    at> <EOT> 
    job 48 at 2009-10-07 17:05   

第四种：

    at -m now + 1 minute
    at>/bin/mail -s "'/bin/bash /root/date.sh'" test1<t1.txt
    at> <EOT> 
    job 48 at 2009-10-07 17:05   



![](https://i.imgur.com/6SdhY1V.png)

![](https://i.imgur.com/6YLm2BL.png)




<h2 id="3">3. <span id="jump3">循环执行的例行性命令</span></h2>


<h3 id="3.1">3.1 <span id="jump3.1">使用者设定：</span></h3>




<h3 id="3.2">3.2 <span id="jump3.2">系统设定：</span></h3>