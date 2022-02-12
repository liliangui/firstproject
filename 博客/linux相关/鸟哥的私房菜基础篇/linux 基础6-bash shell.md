# 阅读目录 #
1、[type [-ta] name](#jump1)
  

2、[环境变量和自定义变量的显示命令](#jump2)

 - 2.1：[env命令的显示](#jump2.1) 

 - 2.2：[set命令的显示](#jump2.2)

 - 2.3：[export命令的显示](#jump2.3)

 - 2.4：[PS1命令提示符](#jump2.4)

 - 2.5：[bash下变量的设定的规则](#jump2.5)

 - 2.6：[linux语系的问题](#jump2.6)

 - 2.7：[键盘读取变量和声明变量](#jump2.7)

 - 2.8：[系统和个人设定值存储的文件](#jump2.8)

3、[命令别名与历史命令](#jump3)

4、[bash shell使用环境的终端的环境设置](#jump4)

 - 4.1：[stty -a](#jump4.1) 

 - 4.2：[修改delete向前删除为backspace向前删除](#jump4.2) 

 - 4.3：[通用字符和特殊符号](#jump4.3)   

 - 4.4：[组合按键](#jump4.4)   


5、[数据流重导向](#jump5)

 - 5.1：[数据流重导向](#jump5.1) 

 - 5.2：[tee-双向重导向](#jump5.2) 

 - 5.3：[命令执行的判断依据](#jump5.3) 

6、[管道命令](#jump6)

 - 6.1：[cut和grep的选取命令](#jump6.1) 

 - 6.2：[sort、uniq、wc排序命令](#jump6.2) 

 - 6.3：[tr、col、join、paste、expand字符转换命令](#jump6.3) 

 - 6.4：[参数代换xargs](#jump6.4) 




<h2 id="1">1. <span id="jump1">type [-ta] name</span></h2>
![](https://i.imgur.com/ABAWYiG.png)
一般情况下，type命令被用于判断另外一个命令是否是内置命令，但是它实际上有更多的用法。
 1.1.判断一个名字当前是否是alias、keyword、function、builtin、file或者什么都不是：

            type ls 的输出是 ls 是 `ls --color=auto' 的别名

            type if 的输出是 if 是 shell 关键字

            type type 的输出是 type 是 shell 内嵌

            type gedit 的输出是 gedit 是 /usr/bin/gedit

            type frydsh 的输出是 bash: type: frydsh: 未找到
 1.2.判断一个名字当前是否是alias、keyword、function、builtin、file或者什么都不是的另一种方法（适用于脚本编程）：

            type -t ls 的输出是 alias

            type -t if 的输出是 keyword

            type -t type 的输出是 builtin

            type -t gedit 的输出是 file

            type -t frydsh 没有输出
 1.3.显示一个名字的所有可能：

            type -a kill 的输出是 kill 是 shell 内嵌 和 kill 是 /bin/kill

            type -at kill 的输出是 builtin 和 file

1.4.查看一个命令的执行路径（如果它是外部命令的话）：

            type -p gedit 的输出是 /usr/bin/gedit

            type -p kill 没有输出（因为kill是内置命令）
1.5.强制搜索外部命令：

            type -P kill 的输出是 /bin/kill


<h2 id="2">2. <span id="jump2">环境变量和自定义变量的显示命令</span></h2>
![](https://i.imgur.com/kfCyDke.png)


<h3 id="2.1">2.1 <span id="jump2.1">env命令的显示：</span></h3>
[root@www.linuxidc.com ~]# env
HOSTNAME=web  -主机名称
TERM=linux -终端
SHELL=/bin/bash -shell
HISTSIZE=1000   -历史存储命令书
SSH_CLIENT=58.222.185.248 1113 22 -登录ip 端口 ssh登录端口
SSH_TTY=/dev/pts/6  -远程登录pts
ANT_HOME=/opt/apache/apache-ant-1.8.1
USER=root  -用户
LS_COLORS=no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=01;32:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.sh=01;32:*.csh=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tz=01;31:*.rpm=01;31:*.cpio=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:*.png=01;35:*.tif=01;35: -颜色的设置信息
SSH_AUTH_SOCK=/tmp/ssh-amfuW25778/agent.25778 
MAIL=/var/spool/mail/root -mail
PATH=/usr/kerberos/sbin:/usr/kerberos/bin:/opt/apache/apache-ant-1.8.1/bin:/usr/ java/jdk1.6.0_20/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin  -路径
INPUTRC=/etc/inputrc  -键盘
PWD=/root  -当前工作路径
JAVA_HOME=/usr/java/jdk1.6.0_20
LANG=zh_CN.GB18030  -语言
SSH_ASKPASS=/usr/libexec/openssh/gnome-ssh-askpass
SHLVL=1
HOME=/root
LOGNAME=root
CVS_RSH=ssh
SSH_CONNECTION=58.222.185.248 1113 218.23.142.44 22
LESSOPEN=|/usr/bin/lesspipe.sh %s
G_BROKEN_FILENAMES=1
_=/bin/env

<h3 id="2.2">2.2 <span id="jump2.2">set命令的显示</span></h3>
[root@www.linuxidc.com ~]# set | more
ANT_HOME=/opt/apache/apache-ant-1.8.1
BASH=/bin/bash
BASH_ARGC=()
BASH_ARGV=()
BASH_COMPLETION=/etc/bash_completion
BASH_COMPLETION_DIR=/etc/bash_completion.d
BASH_LINENO=()
BASH_SOURCE=()
BASH_VERSINFO=([0]="3" [1]="2" [2]="25" [3]="1" [4]="release" [5]="i686-RedHat-linux-gnu")
BASH_VERSION='3.2.25(1)-release'
COLORS=/etc/DIR_COLORS
COLUMNS=132 -显示的列数
CVS_RSH=ssh
DIRSTACK=()
EUID=0
GROUPS=()
G_BROKEN_FILENAMES=1
HISTFILE=/root/.bash_history -history文件保存的地址
HISTFILESIZE=1000
HISTSIZE=1000
HOME=/root
HOSTNAME=web
HOSTTYPE=i686
IFS=$' \t\n'
INPUTRC=/etc/inputrc
JAVA_HOME=/usr/java/jdk1.6.0_20
LANG=zh_CN.GB18030
LESSOPEN='|/usr/bin/lesspipe.sh %s'
LINES=41
LOGNAME=root
LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=01;32:*.cmd=01;3
2:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.sh=01;32:*.csh=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31
:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tz=01;31:*.rpm=01;31:*.cpio=01;31:*.jpg=01;35:*.gif=01;35:*.bmp
=01;35:*.xbm=01;35:*.xpm=01;35:*.png=01;35:*.tif=01;35:'
MACHTYPE=i686-RedHat-linux-gnu
MAIL=/var/spool/mail/root
MAILCHECK=60 -每过60s检查一次邮箱
OPTERR=1
OPTIND=1
OSTYPE=linux-gnu
--More--

后面还有PS1：命令提示符等



<h3 id="2.3">2.3 <span id="jump2.3">export命令的显示：</span></h3>
将用户自定义的变量编程环境变量用export
export 功能说明：设置或显示环境变量。
语　　法：export [-fnp][变量名称]=[变量设置值]
补充说明：在shell中执行程序时，shell会提供一组环境变量。export可新增，修改或删除环境变量，供后续执行的程序使用。export的效力仅限于该次登陆操作。
参　　数：
　-f 　代表[变量名称]中为函数名称。
　-n 　删除指定的变量。变量实际上并未删除，只是不会输出到后续指令的执行环境中。
　-p 　列出所有的shell赋予程序的环境变量。


[root@www.linuxidc.com ~]# export
declare -x ANT_HOME="/opt/apache/apache-ant-1.8.1"
declare -x CVS_RSH="ssh"
declare -x G_BROKEN_FILENAMES="1"
declare -x HISTSIZE="1000"
declare -x HOME="/root"
declare -x HOSTNAME="web"
declare -x INPUTRC="/etc/inputrc"
declare -x JAVA_HOME="/usr/java/jdk1.6.0_20"
declare -x LANG="zh_CN.GB18030"
declare -x LESSOPEN="|/usr/bin/lesspipe.sh %s"
declare -x LOGNAME="root"
declare -x LS_COLORS="no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=01;32:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.sh=01;32:*.csh=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tz=01;31:*.rpm=01;31:*.cpio=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:*.png=01;35:*.tif=01;35:"
declare -x MAIL="/var/spool/mail/root"
declare -x OLDPWD
declare -x PATH="/usr/kerberos/sbin:/usr/kerberos/bin:/opt/apache/apache-ant-1.8.1/bin:/usr/java/jdk1.6.0_20/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin"
declare -x PWD="/root"
declare -x SHELL="/bin/bash"
declare -x SHLVL="1"
declare -x SSH_ASKPASS="/usr/libexec/openssh/gnome-ssh-askpass"
declare -x SSH_AUTH_SOCK="/tmp/ssh-amfuW25778/agent.25778"
declare -x SSH_CLIENT="58.222.185.248 1113 22"
declare -x SSH_CONNECTION="58.222.185.248 1113 218.23.142.44 22"
declare -x SSH_TTY="/dev/pts/6"
declare -x TERM="linux"
declare -x USER="root"


<h3 id="2.4">2.4 <span id="jump2.4">PS1命令提示符：</span></h3>


   \d ：代表日期，格式为weekday month date，例如："Mon Aug 1" 

　　\H ：完整的主机名称。例如：我的机器名称为：fc4.linux，则这个名称就是fc4.linux 

　　\h ：仅取主机的第一个名字，如上例，则为fc4，.linux则被省略 

　　\t ：显示时间为24小时格式，如：HH：MM：SS 

　　\T ：显示时间为12小时格式 

　　\A ：显示时间为24小时格式：HH：MM 

　　\u ：当前用户的账号名称 

　　\v ：BASH的版本信息 

　　\w ：完整的工作目录名称。家目录会以 ~代替 

　　\W ：利用basename取得工作目录名称，所以只会列出最后一个目录 

　　\# ：下达的第几个命令 

　　\$ ：提示字符，如果是root时，提示符为：# ，普通用户则为：$

如果想要设置终端提示符的样式只要把$PS1在~/.bahrc指定即可比，比如我的设置如下：
设置一：
PS1="\[\e[32m\][\u@\h \w]$\[\e[m\]"
export PS1
效果：
[LinuxSong@test ~]$

设置二：

if [ $TERM = 'linux' ]; then
    export PS1="[\[\e[36;1m\]\u@\h \[\e[31;1m\]\w\[\e[32;1m\]]> "
    zhcon --utf8
    clear
elif [ $TERM = "xterm" ]; then
    export PS1="[\[\e[31;1m\]\w\e[0m]> "
fi

[linux PS1 提示符定义](https://www.cnblogs.com/starspace/archive/2009/02/21/1395382.html)


<h3 id="2.5">2.5 <span id="jump2.5">bash下变量的设定的规则：</span></h3>

![](https://i.imgur.com/CeV2JGm.png)
重点有三点：4、5、6

[认识Bash这个Shell](https://www.cnblogs.com/gengsc/p/6883354.html)

<h3 id="2.6">2.6 <span id="jump2.6">linux语系的问题：</span></h3>

![](https://i.imgur.com/l73vs9B.png)

查找当前使用的语系：echo $LANG

显示系统支持的所有语系：locale -a

临时修改语系

1 [linux@linux~]$ LANG=zh_CN.gb2312
2 [linux@linux~]$ echo $LANG
3 zh_CN.gb2312

永久修改语系

1 [linux@linux~]$ vi /etc/sysconfig/i18n 
2 LANG="en_US.UTF-8"
3 SYSFONT="latarcyrheb-sun16"

 使修改立即生效

1 [linux@linux~]$ source /etc/sysconfig/i18n 

注：如果在修改语系后，仍然有乱码，则需要修改编辑器的设置，设置方式如图所示，需要将character encoding修改为对应的语系

![](https://i.imgur.com/TksIenk.png)



<h3 id="2.7">2.7 <span id="jump2.7">键盘读取变量和声明变量：</span></h3>

![](https://i.imgur.com/c0OKcBS.png)

read -p "please input your name:" -t 30 name

declare(转自：http://www.cnblogs.com/fhefh/archive/2011/04/22/2024857.html)

declare或typeset内建命令(它们是完全相同的)可以用来限定变量的属性.这是在某些编程语言中使用的定义类型不严格的方式。命令declare是bash版本2之后才有的。命令typeset也可以在ksh脚本中运行。

declare/typeset 选项

-r 只读

       1 declare -r var1
(declare -r var1与readonly var1作用相同)

这大致和C的const限定词相同.一个试图改变只读变量值的操作将会引起错误信息而失败.

-i 整数
    
    1 declare -i number
    2 # 脚本余下的部分会把"number"当作整数看待.		
    3 
    4 number=3
    5 echo "Number = $number" # Number = 3
    6 
    7 number=three
    8 echo "Number = $number" # Number = 0
    9 # 脚本尝试把字符串"three"作为整数来求值(译者注：当然会失败，所以出现值为0).







某些算术计算允许在被声明为整数的变量中完成，而不需要特别使用expr或let来完成。

    
    1 n=6/3
    2 echo "n = $n"       # n = 6/3
    3 
    4 declare -i n
    5 n=6/3
    6 echo "n = $n"       # n = 2

-a 数组

    1 declare -a indices

变量indices会被当作数组.

-f 函数

       1 declare -f


在脚本中没有带任何参数的declare -f 会列出所有在此脚本前面已定义的函数出来。


       1 declare -f function_name

而declare -f function_name则只会列出指定的函数.

-x export

       1 declare -x var3
这样将声明一个变量作为脚本的环境变量而被导出。

-x var=$value
       1 declare -x var3=373

declare命令允许在声明变量类型的时候同时给变量赋值。

<h3 id="2.8">2.8 <span id="jump2.8">系统和个人设定值存储的文件：</span></h3>
![](https://i.imgur.com/4axE72T.png)

![](https://i.imgur.com/XjuWxWr.png)

![](https://i.imgur.com/QEzmRVc.png)

执行顺序依次为

/etc/profile 

.bash_profile

.bashrc 

/etc/bashrc

    
<h2 id="3">3. <span id="jump3">命令别名与历史命令</span></h2>
![](https://i.imgur.com/aEnicDp.png)

alias 别名='原命令'

　　作用：设置别名

　　别名设置存放在文件 ~/.bashrc 中 ，修改这个文件可永久生效 ~表示家目录
eg：alias  显示所有的alias设置


unalias 删除别名


history [选项]

　　作用：查看使用过的命令

　　参数：

　　-c 清空历史命令

　　-w 把缓存中的命令保存到文件中 文件存放在~/.bash.history中  其中~代表家目录

　　说明：历史命令默认保存1000条 当超过1000条时会删除开始的历史命令 记录下新的命令 ，默认设置在 /etc/profile 中

　　echo $HISTSIZE 可以查看历史记录的当前设置的条数
    eg:history -w hisfile 把shell中的执行记录写入到hisfile中
     ：history -r hisfile 把hisfile中的命令记录读取到shell中


<h2 id="4">4. <span id="jump4">bash shell使用环境的终端的环境设置</span></h2>
  

<h3 id="4.1">4.1 <span id="jump4.1">stty -a：</span></h3>

stty -a 将当前所有的stty参数列出来
![](https://i.imgur.com/0ickakn.png)

![](https://i.imgur.com/zmJUXZh.png)


<h3 id="4.2">4.2 <span id="jump4.2">修改delete向前删除为backspace向前删除：</span></h3>

如上图所示删除为^?(delete)如果需要改成^H（bacespace）

则需使用以下命令
              
     eg：stty erase ^H


<h3 id="4.3">4.3 <span id="jump4.3">通用字符和特殊符号：</span></h3>

![](https://i.imgur.com/3rpdXFg.png)

![](https://i.imgur.com/PO1hMkp.png)

<h3 id="4.4">4.4 <span id="jump4.4">组合按键：</span></h3>

![](https://i.imgur.com/fVkmQVF.png)


<h2 id=5">5. <span id="jump5">数据重导向</span></h2>
  ![](https://i.imgur.com/CxHDBAW.png)

<h3 id="5.1">5.1 <span id="jump5.1">数据重导向：</span></h3>
![](https://i.imgur.com/u44RV1L.png)

<h3 id="5.2">5.2 <span id="jump5.2">tee-双向重导向：</span></h3>

![](https://i.imgur.com/an2Su4M.png)
<h3 id="5.3">5.3 <span id="jump5.3">命令执行的判断依据：</span></h3>
![](https://i.imgur.com/7VzYIPq.png)




<h2 id=6">6. <span id="jump6">管道命令</span></h2>
![](https://i.imgur.com/LWAncG7.png)

<h3 id="6.1">6.1 <span id="jump6.1">cut和grep的选取命令：</span></h3>
![](https://i.imgur.com/L61hoVf.png)

![](https://i.imgur.com/VPepsA3.png)

![](https://i.imgur.com/5W2Vz7r.png)


<h3 id="6.2">6.2 <span id="jump6.2">sort、uniq、wc排序命令：</span></h3>
![](https://i.imgur.com/EMZ2U0n.png)

![](https://i.imgur.com/VWMr54x.png)

<h3 id="6.3">6.3 <span id="jump6.3">tr、col、join、paste、expand字符转换命令：</span></h3>
![](https://i.imgur.com/1Ds5DkX.png)

![](https://i.imgur.com/mTFgktX.png)

![](https://i.imgur.com/pNwFffH.png)

![](https://i.imgur.com/wUse7PF.png)

![](https://i.imgur.com/7Yr6nsm.png)

<h3 id="6.4">6.4 <span id="jump6.4">参数代换xargs：</span></h3>

![](https://i.imgur.com/i4Faprb.png)





