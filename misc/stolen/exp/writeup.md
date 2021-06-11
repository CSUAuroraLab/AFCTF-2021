## writeup

流量分析题，简单分析http流量可以发现黑客是上传了一个木马和python文件进入服务器，通过这个木马运行python文件后，服务器发了一大堆IP包，可以在IP包的标识字段前四位中发现一位一位传输的flag，可以手动提取、也可以写脚本，脚本如下

```python
from scapy.all import *

def main():
    flag = ""
    pcaps = rdpcap("../release/stolen.pcapng")
    for pcap in pcaps[IP]:
        try:
            pcap[TCP]
        except:
            if len(pcap) == 60:
                flag += chr(int(str(hex(pcap.id))[2:4], 16))
    print(flag[:-1])

if __name__ == "__main__":
    main()

# flag{this_is_stolen_secret!!!}
```

