## UART

考察选手信息收集能力和环境配置能力

给了两个附件，rustsbi-qemu.bin和os.bin

os.bin估计没啥头绪，但是看到rustsbi-qemu.bin的时候可以考虑先收集一波信息。

在github上可以搜索到相关项目，可以发现这是一个关于AIOT平台K210开发板的M层管理包。那么继续搜索k210相关信息，看看怎么用qemu让他跑起来

可参考下面的教程

https://rcore-os.github.io/rCore-Tutorial-Book-v3

本题没有设置更难的逆向解密内容。有兴趣的可以做一下解包。k210的可用内存是0x80000000~0x80800000这个区间。第一个被执行的指令在0x80000000。



## 出这个题的原因

大家打过很多CTF比赛，逆向题也做过不少。但是要说真正接触过嵌入式逆向的我估计没多少个。这个题是给大家一个机会去尝试一下配置iot虚拟环境和系统相关信息搜索能力锻炼。

在实际工作的时候，涉及到嵌入式系统的逆向工程，我们面对的往往不单单是windows/linux平台那样的ida一键通问题。有关系统底层实现，接口规格这些，通常需要查阅多方资料。