<?php
echo("functions.php<br />\n");

function test1($var1, $var2) {
	echo("$var1, $var2\n");
}

test1($argv[1], $argv[2], $argv[3]);

