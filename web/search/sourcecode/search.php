<?php
error_reporting(0);
$argv = $_GET["search"];
for ($i = 0; $i < strlen($argv); $i++) {
  if (($argv[$i] == '&') ||
    ($argv[$i] == '>') ||
    ($argv[$i] == '<') ||
    ($argv[$i] == '(') ||
    ($argv[$i] == ';') ||
    ($argv[$i] == '|')
  ) {

    if ($i == 0) {
      goto error;
    }
    if (($i == 1) && ($argv[0] == '\\')) {
      continue;
    }
    if (($argv[$i - 1] == '\\') && ($argv[$i - 2] != '\\')) {
      continue;
    }
    error:
    exit("Input contains prohibited characters!<br>");
  }
}
echo "<h3>Search reslut:</h3><br>";
system("find / -iname " . $argv);
?>
