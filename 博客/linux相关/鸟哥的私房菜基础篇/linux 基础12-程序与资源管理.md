
1、[基础概念](#jump1)



2、[作业管理](#jump2)

- 2.1：[&](#jump2.1)

- 2.2：[[ctrl] -z](#jump2.2)

- 2.3：[jobs](#jump2.3)

- 2.4：[fg](#jump2.4)

- 2.5：[bg](#jump2.5)

- 2.6：[kill](#jump2.6)

3、[进程管理](#jump3)

- 3.1：[进程的观察ps、top、pstree](#jump3.1)

- 3.2：[killall](#jump3.2)

- 3.3：[系统资源的观察：free、uname、dmesg、sar](#jump3.3)

- 3.4：[netstat](#jump3.4)

- 3.5：[进程的执行顺序](#jump3.5)




<h2 id="1">1. <span id="jump1">基础概念</span></h2>

- 可执行的二进制文件就是程序
- 执行程序的时候因触发事件而获取的ID，称为PID
- 在登入并执行bash时，系统依据登录者的UID/GID给登录者一个PID/GPID/SID等
- 启动程序时，根据启动这个程序的使用者和相关属性关系，给这个PID一组有效的全线设定。每个程序都有三组权限，每组都具有r/w/r的权限，所以：不同的用户身份执行某个程序时，系统给予的权限也都不同。
- 子程序与父程序：我们登录系统后，会取得一个bash shell的PID，我们可以用bash提供的接口去执行另一个程序，那些另外执行的程序也会获得一个PID，这个PID就是子程序，而在我们的bash环境，就称为父程序。
- 常驻在内存的程序有哪些：
- ls、touch、rm等执行完就退出内存了
- 系统或者网络服务crond atd，syslog，Apache，named，vsftpd等是常驻内存的。



<h2 id="2">2. <span id="jump2">作业管理</span></h2>

- 登录系统取得bash shell之后，在单一终端界面下，同时管理多个作业。
- 要进行bash的作业管理，需要注意到的限制是
- 程序必须是shell的子程序
- 程序不能等待terminal/shell的输入



<h3 id="2.1">2.1 <span id="jump2.1">&：</span></h3>


- 直接将命令放到后台中“执行”的&：
- 前台：用户可以控制的作业就是前台错也
- 后台：在内存可以自行运行的作业，用户无法直接控制他，除非用bg/fg等指令来将该作业调用出来
- 如果前台运行的话，程序在结束之前不能进行其他的操作
- 程序在后台运行则可以同时进行其他命令比如：ls等
    tar -zcf etc.tar.gz /etc >log.txt 2>&1 &


<h3 id="2.2">2.2 <span id="jump2.2">[ctrl] -z：</span></h3>

- 把程序从前台暂停到后台，


<h3 id="2.3">2.3 <span id="jump2.3">jobs：</span></h3>

![](https://i.imgur.com/k2jGCKV.png)

    jobs  #等效于jobs -s
    jobs -l #还会小时进程号
    jobs -r  #显示正在运行的

![](https://i.imgur.com/b9xZdq4.png)

![](https://i.imgur.com/1g5ihIG.png)



<h3 id="2.4">2.4 <span id="jump2.4">fg：</span></h3>

![](https://i.imgur.com/gqmaW7Z.png)
    fg %+  #默认调用+的作业
    fg %%
    fg %1   #执行作业号为1的作业

<h3 id="2.5">2.5 <span id="jump2.5">bg：</span></h3>

![](https://i.imgur.com/mSEscHy.png)


- 让后台暂停的作业在后台内存中运行


    find /-perm -4000
    然后暂停它
    jobs
    bg %之前暂停作业的作业号


<h3 id="2.6">2.6 <span id="jump2.6">kill：</span></h3>


![](https://i.imgur.com/D6XBQEm.png)

- 使用kill -l

![](https://i.imgur.com/9JwGLGl.png)




- 使用kill -9 进程号或者作业号，对应的.swp文件不会删除
- 使用kill -15 进程号或者作业号，对应的.swp文件不会删除

    kill -9 %3




<h2 id="3">3. <span id="jump3">进程管理</span></h2>

- 为什么进程管理这么重要
- 如果linux系统很繁忙，当整个系统资源快被耗尽的时候，我们应该找出最耗系统的那个进程，然后删除该进程或者降低它的执行权限，让系统恢复正常
- 如果某个程序僵死，导致程序一直在内存当中，我们应该将其找到并杀死
- 如果系统中同时又五六项作业在运行，但是其中有一项作业非常重要，那么，如何让这项重要的工作被最优先执行呢
- 



<h3 id="3.1">3.1 <span id="jump3.1">进程的观察ps、top、pstree：</span></h3>


- ps静态的查看进程
- top动态的查看进程
- pstree来查阅程序之间的关系


![](https://i.imgur.com/eSkaQlw.png)


![](https://i.imgur.com/0B7H2Xi.png)


![](https://i.imgur.com/QmHH8HV.png)

- F是标志的意思，4表示root用户
- S是state状态的意思，S表示sleeping，R表示running，T表示停止的意思，Z表示zombie僵死了。
- PPID是进程的副进程
- C所占的cpu的百分比
- PRI是priority优先级的意思
- NI是nice谦让值的意思
- ADDR进程所在的位置，如果在运行就显示-号
- SZ表示进程所占用的内存大小
- WATCH表示运行的状态，-号代表正在运行，wait代表正在等待
- TTY代表登录状态，
- CMD，是command的缩写
- VSZ，虚拟内存占用大小
- RSS，所占用内存页数
- 

    ps aux | head

    ps -axjf  #显示树状结构
    ps -lA | cat -n
    ps -aux | cat -n
    ps -le | cat -n


![](https://i.imgur.com/1srJrf5.png)


 
![](https://i.imgur.com/5gGIvjk.png)   
 


- load average 分别表示1分钟，5分钟，15分钟的负载
- Men、Swap：物理、虚拟内存使用
- Cpu：us、sy、ni、id、wa、hi、si、st分别为用户占用、系统占用、nice占用、id空闲占用、wa等待输入输出占用、hi硬件中断占用、si软中断占用




![](https://i.imgur.com/dUaeaiI.png)


<h3 id="3.2">3.2 <span id="jump3.2">killall：</span></h3>


![](https://i.imgur.com/znTVBQ6.png)


    service httpd start
    kill -9 'ps aux| grep httpd| grep -v 'grep'| awk '{print $2}''#用kill命令杀死httpd挺麻烦的。
    killall -9 httpd



<h3 id="3.3">3.3 <span id="jump3.3">系统资源的观察：free、uname、dmesg、sar：</span></h3>

![](https://i.imgur.com/od9Z42v.png)


![](https://i.imgur.com/zYwc1PR.png)


![](https://i.imgur.com/mTi1aX4.png)


<h3 id="3.4">3.4 <span id="jump3.4">netstat、：</span></h3>


![](https://i.imgur.com/xoDhmiY.png)

    netstat | nl
    netstat | head


<h3 id="3.5">3.5 <span id="jump3.5">进程的执行顺序、：</span></h3>

![](https://i.imgur.com/e5si1cL.png)

![](https://i.imgur.com/kCDMz8e.png)