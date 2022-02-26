​                                        

## 一：TortoiseGit安装以及配置



### 1.1、安装包	

==**TortoiseGit以及配套安装包见链接：**==

[git下载链接](https://gitforwindows.org/index.html)

[Download PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html)

[TortoiseGit下载](https://tortoisegit.org/download/)



### 1.2、参考博客	

==**参考的教程如下：**==

[[Git安装和TortoiseGit详细使用教程【基础篇】](https://www.cnblogs.com/mq0036/p/9442751.html)]()

[TortoiseGit - 分支管理 -增加分支](https://www.cnblogs.com/McKean/p/6083526.html)

[tortoisegit如何退回原来的版本及回退远端](https://blog.csdn.net/zhanglong_longlong/article/details/105242109)

[TortoiseGit汉化及其使用教程](https://www.cnblogs.com/anayigeren/p/10177027.html)

[windows下git和TortoiseGit(小乌龟)和putty安装配置对github进行操作](https://blog.csdn.net/dengzeyuan/article/details/78943816)

## 二：TortoiseGit安装配置



### 2.1、Tortoisegit 配置：

==**第1步：** 首先，请选定一个存放Git项目的目录，这样方便管理. 如: E:\Git，然后在资源管理器中打开：==

![image-20220226165730140](https://cdn.jsdelivr.net/gh/liliangui/picgo_picutre/img/image-20220226165730140.png)



==**第2步：** 在空白处点击鼠标右键，选择 --> TortoiseGit --> Settings，然后就可以看到配置界面：==

![image-20220226170006784](https://cdn.jsdelivr.net/gh/liliangui/picgo_picutre/img/image-20220226170006784.png)

==**第3步：**配置用户，用户作为你操作git的个人标识，进入设置，点选左边的Git标签，可以发现,右边可以配置用户的名字与Email信息. 如下图所示：==

![image-20220226170125728](https://cdn.jsdelivr.net/gh/liliangui/picgo_picutre/img/image-20220226170125728.png)

![image-20220226170143393](https://cdn.jsdelivr.net/gh/liliangui/picgo_picutre/img/image-20220226170143393.png)



### 2.2、putty 生成key：



==第一步、通过putty生成key==

**生成key后，将key  选择save  private key保存到本地：**

![](https://cdn.jsdelivr.net/gh/liliangui/picgo_picutre/img/image-20220226170544483.png

![image-20220226170605090](https://cdn.jsdelivr.net/gh/liliangui/picgo_picutre/img/image-20220226170605090.png)



==第二步、github中配置key==

![image-20220226170727295](https://cdn.jsdelivr.net/gh/liliangui/picgo_picutre/img/image-20220226170727295.png)

==第三步：将保存key，用于配置tortoisegit==

如下图所示：URL为GITHUB项目地址、Load Putty Key为第一步保存下来的key

![image-20220226171054113](https://cdn.jsdelivr.net/gh/liliangui/picgo_picutre/img/image-20220226171054113.png)





## 三：TortoiseGit使用

### **3.1、常见命令：**

git pull拉取远程github仓库最新代码到本地仓库。
git push上传本地仓库的代码到github远程仓库。
git commit保存本地代码到本地仓库。
git Fetch拉取远程代码到本地并且在拉取过程中如果发现与本地文件有冲突会提示出来。通过rebase可以解决冲突文件。但是如果直接pull的话会覆盖本地冲突文件，所以一般拉取代码都先commit->fetch->rebase。不建议直接pull,并且在push之前每次都要先fetch->rebase，防止将别人代码覆盖。

![image-20220226171409402](https://cdn.jsdelivr.net/gh/liliangui/picgo_picutre/img/image-20220226171409402.png)



### **3.2、文件状态：**

![image-20220226171648694](https://cdn.jsdelivr.net/gh/liliangui/picgo_picutre/img/image-20220226171648694.png)

### **3.3、**将代码提交到服务器：

Git的使用类似TFS、SVN等源代码或者文件管理器，惯例的流程：

![image-20220226171756241](https://cdn.jsdelivr.net/gh/liliangui/picgo_picutre/img/image-20220226171756241.png)



#### 3.3.1、修改本地文件：

==第一步：**改动，修改本地项目中的某些文件，如修改 README.md 内容，还可以增加一些文件， 如Hello.txt。==

#### 3.3.2、commit本地文件：

　==**第二步：**提交本地，在本地项目的空白处点击鼠标右键，选择 【Git提交(C) -> "master"...】==

![image-20220226171914311](https://cdn.jsdelivr.net/gh/liliangui/picgo_picutre/img/image-20220226171914311.png)

在弹出提交（Commit）对话框中完成提交说明信息，和选择需要提交的文件，可根据需要新建分支，然后点击 【提交】 按钮，将修改提交到**本地仓库：**

![image-20220226171938395](https://cdn.jsdelivr.net/gh/liliangui/picgo_picutre/img/image-20220226171938395.png)

弹出提交进度窗口，提交成功后还需要“推送”将本地仓库的修改推送到**远程仓库**。

![image-20220226172005222](https://cdn.jsdelivr.net/gh/liliangui/picgo_picutre/img/image-20220226172005222.png)



#### 3.3.3、同步拉取，确保该的版本是最新的：

　　==**第3步：**同步拉取，在实际工作中，如果多人协作或者多个客户端进行修改，那么我们还要拉取别人推送到在线仓库的内容，所以在推送之前需要先执行同步拉取(Pull ...)操作。==

　　在本地仓库文件夹上【右击鼠标】→【Git同步】：

![image-20220226172040198](https://cdn.jsdelivr.net/gh/liliangui/picgo_picutre/img/image-20220226172040198.png)

　打开Git同步窗口（包括常规操作及日志，同右击菜单快捷操作一样），点击【拉取(P)】，将远程分支拉取到本地：

![image-20220226172105925](https://cdn.jsdelivr.net/gh/liliangui/picgo_picutre/img/image-20220226172105925.png)

如果服务器上的文件没有被修改过，就会直接提示已经更新到最新，那你就可以直接进行下一步“推送(H)”操作了：

![image-20220226172130298](https://cdn.jsdelivr.net/gh/liliangui/picgo_picutre/img/image-20220226172130298.png)

　反之，如果服务器上的文件被修改过了（本地文件修改前不是最新版本），就会提示冲突。先要解决冲突，然后再提交结果：

![image-20220226172204043](https://cdn.jsdelivr.net/gh/liliangui/picgo_picutre/img/image-20220226172204043.png)

需要注意的是，和使用TFS、SVN的习惯一样，你在修改本地内容之前，最好先 拉取（pull）一下，减少冲突的可能。

#### 3.3.3、pull到remote上（github或者gitee）：

==***\*第四步：推送远程\****，将提交到本地仓库的修改推送到远程仓库，可以直接在提交成功后的提示窗口上点击【推送(H)...】，或者在Git同步窗口点击【推送(H)...】，鼠标右击的菜单上也有相应的快捷操作：选择 【TortoiseGit(T)】→【推送(H)...】==

![image-20220226172251513](https://cdn.jsdelivr.net/gh/liliangui/picgo_picutre/img/image-20220226172251513.png)

![image-20220226172310856](https://cdn.jsdelivr.net/gh/liliangui/picgo_picutre/img/image-20220226172310856.png)



### **3.4、**分支的使用：



#### 3.4.1 建立分支

![image-20220226174109852](https://cdn.jsdelivr.net/gh/liliangui/picgo_picutre/img/image-20220226174109852.png)
