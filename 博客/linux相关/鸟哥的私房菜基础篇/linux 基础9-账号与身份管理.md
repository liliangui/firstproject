# 阅读目录 #

1、[linux的账号与群组](#jump1)

- 1.1：[账户名称：/etc/passwd](#jump1.1)

- 1.2：[账户密码：/etc/shadow](#jump1.2)

- 1.3：[群用户：/etc/group](#jump1.3)

- 1.4：[群用户密码：/etc/gshadow](#jump1.4)

2、[账号管理](#jump2)

- 2.1：[新增与移除使用者](#jump2.1)

- 2.2：[密码管理](#jump2.2)

- 2.3：[chfn chsh finger id](#jump2.3)

- 2.4：[新增和移除群组](#jump2.4)





3、[使用者用户切换](#jump3)

- 3.1：[su](#jump3.1)

- 3.2：[sudo visudo](#jump3.2)


4、[使用者的特殊shell与PAM模块](#jump4)

- 4.1：[特殊的shell](#jump4.1)

- 4.2：[PAM模块](#jump4.2)




5、[linux系统上使用者的talk与mail的使用](#jump5)

- 5.1：[查询使用者](#jump5.1)

- 5.2：[使用者talk](#jump5.2)

- 5.3：[使用者邮箱](#jump5.3)

6、[批量建立用户](#jump6)

- 6.1：[常用的一些命名](#jump6.1)

- 6.2：[批量建立用户流程](#jump6.2)

- 6.3：[批量建立用户脚本](#jump6.3)







<h2 id="1">1. <span id="jump1">linux的账号与群组</span></h2>



<h3 id="1.1">1.1 <span id="jump1.1">账户名称：/etc/passwd：</span></h3>

![](https://i.imgur.com/0kkUmi8.png)

![](https://i.imgur.com/G8NbTnK.png)



    head -n 5 /etc/password  #取前5行

1. 账号名称，对应UID
2. 密码，早期是在这里，后来转到了/etc/shadow中，所以这里都是x
3. UID的范围：0系统管理员，1-99留给系统预设的账号，100-499保留给一些服务来使用	，500-65535给一般用户
4. GID这是用户的初始化用户组：使用这一登录系统，就拥有这个群组的相关权限。
5. 用户说明，基本没用
6. 用户家目录
7. 使用的shell，bash shell是linux默认使用的shell

uname -r可以来查找系统核心



<h3 id="1.2">1.2 <span id="jump1.2">账户密码：/etc/shadow：</span></h3>

![](https://i.imgur.com/DmMR9fR.png)

![](https://i.imgur.com/h88bo8Z.png)




    head -n 5 /etc/shadow  #取前5行
    grep 'root' /etc/shadow |awk '{print substr($0,6,34)}'  #取密码段

1. 账号名称
2. 密码 采用MD5进行加密的密码，含有$1$的标志的34位密码组，如果密码为*或者！，则表示这个账号无法登陆。
3. 最近修改密码的日期，以1970年1月1日作为1
4. 密码不可更改日期，修改之后第几天可以再次修改密码
5. 密码需要重新更新的天数
6. 密码需要变更期限前的警告期限
7. 密码过期的宽限时间
8. 账号失效日期
9. 保留

<h3 id="1.3">1.3 <span id="jump1.3">群用户：/etc/group：</span></h3>

![](https://i.imgur.com/KjIQPdr.png)



    groups #查看所属的用户组，有效用户组为第一个，
    newgrp  用户组 #改变用户组
    exit    #退出当前用户组

1. 用户组
2. 密码，为x
3. 用户组的GID
4. 该用户组所支持的用户




<h3 id="1.4">1.4 <span id="jump1.4">群用户密码：/etc/gshadow：</span></h3>

![](https://i.imgur.com/36ITrRf.png)

1. 用户组
2. 密码，如果为*和！则不可登录
3. 用户组管理员的账号
4. 该用户组所属（支持）的用户，与/etc/group内容一样

<h2 id="2">2. <span id="jump2">账号管理</span></h2>

<h3 id="2.1">2.1 <span id="jump2.1">新增与移除使用者、新增与移除群组：/etc/passwd：</span></h3>

passwd、usermod、useradd这三个命令都是root用户使用的，普通用户不能使用。

![](https://i.imgur.com/NhlDvUT.png)

新增用户

    grep user3 /etc/passwd /etc/shadow /etc/group /etc/gshadow  #查找这四个文件中有user3的部分。

![](https://i.imgur.com/ebAlAwI.png)

删除用户


![](https://i.imgur.com/zLqXopc.png)

修改账号信息

插入图2.1.4

初始化群组和有效群组的改变。

    usermod -g test2 -G 502 test1 #-g修改初始化群组，-G修改有效用户组

<h3 id="2.2">2.2 <span id="jump2.2">密码管理：/etc/passwd：</span></h3>

![](https://i.imgur.com/0oMgzgh.png)

    passwd user #修改密码




<h3 id="2.3">2.3 <span id="jump2.3">chfn chsh finger id：/etc/passwd：</span></h3>

![](https://i.imgur.com/LywX8v2.png)

    chsh -s /bin/csh #root也可以用这个改，也可以用usermod
    chsh -l  #显示当前可用的shell

修改自己的相关信息
    chfn #会依次让你修改大名、办公室房间号码、办公室电话号码、家里电话，改变的信息是/etc/passwd的第五栏使用者的信息说明栏
![](https://i.imgur.com/yoJIvYp.png)

读取修改的信息，也就是用chfn修改的那些东西。

也可以用来查找当前系统的登录信息

![](https://i.imgur.com/vDsvbBd.png)

    id  #uid、gid、所支持的群组。


<h3 id="2.4">2.4 <span id="jump2.4">新增和移除群组：/etc/passwd：</span></h3>


![](https://i.imgur.com/HRjMHov.png)

![](https://i.imgur.com/ul465sI.png)

![](https://i.imgur.com/qZZ7RSy.png)

![](https://i.imgur.com/Q8fYrCW.png)

    

<h2 id="3">3. <span id="jump3">使用者用户切换</span></h2>

<h3 id="3.1">3.1 <span id="jump3.1">su：</span></h3>

![](https://i.imgur.com/sDRswMD.png)

![](https://i.imgur.com/owqepJG.png)


<h3 id="3.2">3.2 <span id="jump3.2">sudo visudo：</span></h3>

![](https://i.imgur.com/AIpDcpP.png)

![](https://i.imgur.com/5TtA9qE.png)


![](https://i.imgur.com/YTW5C1q.png)

![](https://i.imgur.com/2yLPx9k.png)

    sudo如果没有制定切换的账号，则默认使用root
    sudo -u "#501" touch /home/test2/3.txt#必须用""包括起来。
    sudo -u "#501" -p %H ls /home/test2   #完整的主机名称
    sudo -u "#501" -p %h ls /home/test2  #主机名称
    sudo -u test2 -p %U ls /home/test2  #切换到的账户名称
    sudo -u test2 -p %u ls /home/test2 #使用者账户的名称

![](https://i.imgur.com/plTHCg2.png)
visudo是用来编辑/etc/sudoers，vi只可以可读。
vigr   编辑/etc/group
vimpw  编辑/etc/passwd

![](https://i.imgur.com/odRQFi1.png)


![](https://i.imgur.com/6QSJsv5.png)



    find / -perm -4000 | xargs ls -lhd  #查找系统下所有包含s权限的文件。



<h2 id="4">4. <span id="jump4">使用者的特殊shell与PAM模块</span></h2>

<h3 id="4.1">4.1 <span id="jump4.1">特殊的shell：</span></h3>

![](https://i.imgur.com/tk0RuOO.png)

    cat /etc/passwd | more  

![](https://i.imgur.com/rR5iXI9.png)

    usermod -s /sbin/nologin test1  #给test1指定nologin的shell

    vi /etc/nologin.txt #然后输入不可登陆的信息

记录次数

    #!/bin/awk -f
    BEGIN{
    FS=":"
    }
    {
    if ($7=="/bin/bash") bash=bash+1
    if ($7=="/sbin/nologin") nologin=nologin+1
    }
    END{
    print "/bin/bash times is :" bash
    print "/sbin/nologin times is :" nologin
    }


使用bash shell

    #!/bin/bash
    read -p "please input the /etc/passwd :" path

    if [ -z "$path" -o "$path" != "/etc/passwd -o ! -e "$path" ];then
    fi

    allshell='cut -d : -f 7 "$path"'
    for oneshell in $allshell
    do
         if [ "$oneshell" = "/bin/bash" ];then
                bash=$(($bash+1))
         fi
         if [ "$oneshell" = "/sbin/nologin" ];then
                nologin=$(($nologin+1))
         fi
    done

    echo "/bin/bash has $bash times"
    echo "/sbin/nologin has $nologin times"


<h3 id="4.2">4.2 <span id="jump4.2">PAM模块：</span></h3>


![](https://i.imgur.com/QZD8aib.png)

![](https://i.imgur.com/bgjdaln.png)

![](https://i.imgur.com/JfJylJG.png)

![](https://i.imgur.com/HGn016d.png)


![](https://i.imgur.com/lfG6hb6.png)



![](https://i.imgur.com/Z4dw1TQ.png)

在/etc/security/access.conf中加入

      - ： test1 : ALL EXCEPT 127.0.0.0/24 #仅限本地登陆，其他的ip都不能登陆。


![](https://i.imgur.com/fsg5vq2.png)




<h2 id="5">5. <span id="jump5">使用者的特殊shell与PAM模块</span></h2>

<h3 id="5.1">5.1 <span id="jump5.1">查询使用者：</span></h3>

![](https://i.imgur.com/lYF2z2f.png)

![](https://i.imgur.com/FiQBTnJ.png)

![](https://i.imgur.com/GWPuFDF.png)

![](https://i.imgur.com/UC9nPYp.png)

    last -n 5 -d
    last -f wtmp2  #默认读取/var/log/wtmp，如果需要指定读另外一个，需加上-f参数

![](https://i.imgur.com/dhKywk5.png)










<h3 id="5.2">5.2 <span id="jump5.2">使用者talk：</span></h3>


![](https://i.imgur.com/6VuPwx3.png)

    mesg y
    mesg n
    write test1

![](https://i.imgur.com/xc5CDQR.png)


如果root发送广播信息，即使其他用户关闭信息接收，也会收到信息。



<h3 id="5.3">5.3 <span id="jump5.3">使用者邮箱：</span></h3>


![](https://i.imgur.com/tRkdPET.png)

    stty erase ^H
    mail -s "this is first test" root@localhost
    this is first test



![](https://i.imgur.com/SfKDEvG.png)



![](https://i.imgur.com/fdMmScj.png)



<h2 id="6">1. <span id="jump6">linux的账号与群组</span></h2>



<h3 id="6.1">6.1 <span id="jump6.1">常用的一些命名：</span></h3>

![](https://i.imgur.com/bKG96Wi.png)

![](https://i.imgur.com/XAFfEjr.png)

![](https://i.imgur.com/eR5ytuy.png)


![](https://i.imgur.com/eLFJfrU.png)



<h3 id="6.2">6.2 <span id="jump6.2">建立用户流程：</span></h3>

![](https://i.imgur.com/DyMqsCa.png)

    vi /etc/group    #打开/etc/group文件进行编辑
    test4:x:505:     #加入test4用户组
    grpconv          #group和gshadow同步
    grep test4 /etc/gshadow  #查找gshadow，确认已经同步
    vi /etc/passwd      #打开/etc/passwd文件进行编辑
    test4:x:505:505::/home/yesy4:/bin/bash  #加入test4用户
    pwconv             #passwd和shadow同步
    grep test4 /etc/shadow  #查找shadow，确认已经同步
    passwd test4  #输入密码  #输入用户的密码（设置）
    mkdir /home/test4  #创建使用者家目录
    ls -la /etc/skel   #显示/etc/skel下的所有文件
    cp -a /etc/skel/.[a-z]* /home/test4  #将/etc/skel下的所有文件都拷贝到使用者家目录中
    ls -la /home/test4     #显示使用者家目录的所有文件和属性
    chown -R test4:test4 /home/test4  #吧家目录的属性由root改为test4
    ls -la /home/test4   #显示使用者家目录的所有文件和属性


![](https://i.imgur.com/kdR4CAe.png)


    vigr /etc/group    #打开/etc/group文件进行编辑
    test5:x:505:     #加入test5用户组
    选择y          #进入编辑gshadow
    test5:x::      #加入test5用户组密码
    vipw /etc/passwd      #打开/etc/passwd文件进行编辑
    test5:x:505:505::/home/yesy4:/bin/bash  #加入test5用户
    选择y         #进入编辑shadow
    test5:!!:14519:0:99999:7:3::  #加入test5shadow密码文件
    passwd test4  #输入密码  #输入用户的密码（设置）
    mkdir /home/test5  #创建使用者家目录
    ls -la /etc/skel   #显示/etc/skel下的所有文件
    cp -a /etc/skel/.[a-z]* /home/test5  #将/etc/skel下的所有文件都拷贝到使用者家目录中
    ls -la /home/test5     #显示使用者家目录的所有文件和属性
    chown -R test4:test5 /home/test5  #吧家目录的属性由root改为test5
    ls -la /home/test5   #显示使用者家目录的所有文件和属性

    

<h3 id="6.3">6.3 <span id="jump6.3">批量建立用户脚本：</span></h3>

![](https://i.imgur.com/qGFk3dP.png)


建立用户

    vi useradd.sh
    

    #!/bin/bash
    accountfile=user:passwd
    test -e "$accountfile" && rm -f "$accountfile";  touch "$accountfile" || touch "$accountfile"
    read -p "please input your zhuanye:" zhuanye
    read -p "please input your grade:" grade
    read -p "please input the start number:" start_nu
    read -p "please input the user number:" user_nu
    read -p "please choice passwd stardand:1)same as usernaem 2)random" pwd
    
    
    if [ "$zhuanye" ="" ];then
          echo "you should input the zhuanye!!"; exit 1
    fi
    testing1='echo $grade | grep [^0-9]'
    testing2='echo $start_nu | grep [^0-9]'
    testing3='echo $user_nu | grep [^0-9]'
    if [ "$testing1" !="" -o "$testing2" !="" -o "$testing3" !="" ];then
          echo "the grade or start number or user number has include characters!!"; exit 1
    fi

    for ((i=$start_nu;i<$(($start_nu+$user_nu));i++))
    do
           account=$zhuanye$grade$i
           if [ "$pwd" = "1" ];then
                password="$account"
           else
                password=""
                test_nu=0
                until [ "$test_nu" = "6" ]
                do
                     temp_nu=$(($RANDOM*50/32767+30))
                     until [ "$test_nu" != "60" ]
                     do
                           temp_nu=$(($RANDOM*50/32767+30))
                     done
                     temp_ch='printf "\x$temp_nu"'
                     password=$password$temp_ch
                     temp_nu=$(($temp_nu+1))
                done
           fi
           echo "$account":"$password" >>"$accountfile"
    done
    cat "$accountfile" | cut -d ":" | xargs -n 1 useradd
    chpasswd < "$accountfile"
    pwconv
    echo "OK,successful"
    


删除用户



    vi userdel.sh

    #!/bin/bash
    cat "user:passwd" | cut -d : -f1 | xargs -n 1 userdel -r