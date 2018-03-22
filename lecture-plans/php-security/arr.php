<?php 
function abc() {
	$arr['0.0'] = 0.0;
	$arr[2] = 2;
	$arr[1] = 1;
	$arr[0] = 0;
	foreach ($arr as $elem) { echo "$elem "; } // prints "2 1 0" !!
	echo("\n");
}
abc($argv[0]);
