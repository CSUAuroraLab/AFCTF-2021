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