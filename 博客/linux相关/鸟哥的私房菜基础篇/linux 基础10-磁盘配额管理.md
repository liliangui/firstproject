# 阅读目录 #

1、[基本概念](#jump1)

- 1.1：[概念](#jump1.1)

- 1.2：[软限制、硬限制、宽限时间](#jump1.2)



2、[主要的命令介绍](#jump2)

- 2.1：[quota](#jump2.1)

- 2.2：[quotacheck](#jump2.2)

- 2.3：[edquota](#jump2.3)

- 2.4：[quotaon](#jump2.4)

- 2.5：[quotaoff](#jump2.5)

- 2.6：[repquota](#jump2.6)


3、[磁盘配额操作步骤](#jump3)

- 3.1：[要求](#jump3.1)

- 3.2：[操作步骤](#jump3.2)

- 3.3：[实际例子](#jump3.3)




<h2 id="1">1. <span id="jump1">基本概念</span></h2>



<h3 id="1.1">1.1 <span id="jump1.1">概念：</span></h3>

在linux系统中，由于是多人多任务的使用环境，所以会有多人共同使用一个硬盘空间的情况，如果其中少数几个人大量使用了硬盘空间的话，势必会压缩其他使用者的使用空间，因此管理员应该适当的开放应哦按的权限给使用者，以妥善的分配系统的资源。

<h3 id="1.2">1.2 <span id="jump1.2">软限制、硬限制、宽限时间：</span></h3>

- soft：软限制，也称为最低容量限制。使用者在宽限时间内，他的容量可以超过最低使用容量，但必须在宽限时间之内将磁盘容量降低到最低容量限制之下
- hard：硬限制，也称为最高容量限制，是绝对不能超过的容量，最高容量限制要比最低容量限制大
- soft到hard之间的容量就是宽限容量
- 宽限时间：也就是当使用者的使用空间超出了软限制，却没有达到硬限制时，宽限时间就会自动启动，而在使用者将容量降低到软限制之下，宽限时间就会自动取消。



<h2 id="2">2. <span id="jump2">主要的命令介绍</span></h2>

![](https://i.imgur.com/Nhwxevc.png)

<h3 id="2.1">2.1 <span id="jump2.1">quota：</span></h3>

![](https://i.imgur.com/8HoEKgA.png)

<h3 id="2.2">2.2 <span id="jump2.2">quotacheck：</span></h3>
![](https://i.imgur.com/YmeKqxp.png)

<h3 id="2.3">2.3 <span id="jump2.3">edquota：</span></h3>
![](https://i.imgur.com/xWgowkN.png)

<h3 id="2.4">2.4 <span id="jump2.4">quotaon：</span></h3>
![](https://i.imgur.com/5rc9Wx4.png)

<h3 id="2.5">2.5 <span id="jump2.5">quotaoff：</span></h3>
![](https://i.imgur.com/teZnHqG.png)

<h3 id="2.6">2.6 <span id="jump2.6">repquota：</span></h3>

![](https://i.imgur.com/N1J44iL.png)



<h2 id="3">3. <span id="jump3">磁盘配额操作步骤</span></h2>

![](https://i.imgur.com/rt0Zkre.png)

<h3 id="3.1">3.1 <span id="jump3.1">要求：</span></h3>

![](https://i.imgur.com/RLgqxfQ.png)


<h3 id="3.2">3.2 <span id="jump3.2">操作步骤：</span></h3>

![](https://i.imgur.com/dDbARH5.png)

<h3 id="3.3">3.3 <span id="jump3.3">实际例子：</span></h3>

第一步:建立测试用的用户和群组

    groupadd qgroup #添加群组
    useradd -g qgroup qtest1 #添加用户
    useradd -g qgroup qtest1
    passwd qtest1 #设置用户密码
    passwd qtest2

第二步：建立支持磁盘配额的文件系统

    fdisk /dev/sda    #新建一个分区
    输入  n p w
    partprobe  #读入分区
    vi /etc/fstab  #修改这个文件，具体修改如下见/dev/sda11

![](https://i.imgur.com/cltZRhf.png)

    mkfs.ext3 /dev/sda11  #格式化分区
    mkdir /s1  #创建挂载的文件夹
    mount /dev/sda11 /s1  #把分区挂载到/s1文件夹下面
    ls -lh /s1   #显示/s1下面的文件内容
    mount -o remount /s1  #更新文件系统
    grep /s1 /etc/mtab  #确认已经设置好


第三步：扫描磁盘使用者使用情况

    quotacheck -avug  #扫描磁盘使用者使用情况，并产生两个文件
    ls -lh /s1

第四步 ：启动quota的限额

    quotaon -avug  #启动quota的限额

第五步和第六步：编辑使用者和群组的具体设置（软限制、硬限制和宽限时间）

    edquota -u qtest1  #编辑用户qtest1的软限制和硬限制

![](https://i.imgur.com/Amr3wCl.png)

    edquota =p qtest1 -u qtest2 #将用户qtest1的软限制和硬限制文件复制给qtest2
    
    edquota -t   #设置用户的宽限时间设置
![](https://i.imgur.com/pbIP5BA.png)
    
    edquota -gt  #群组的宽限时间设置

![](https://i.imgur.com/tQaeLFh.png)

    edquota -g qgroup  #编辑群组的软限制和硬限制

![](https://i.imgur.com/VPAmtxc.png)
 

第七步：显示设置的报告

    repquota -avug

![](https://i.imgur.com/yYdD4LC.png)

    quota -vu qtest1 #也可以用这个来显示qtest1的设置情况
 

第七步：设置开机自启动

    vi /etc/rc.d/rc.local 
![](https://i.imgur.com/VtIRlvU.png)
