<?

if ($argc!=2) {
	echo "Usage: {$argv[0]} filename\n";
	exit(2);
}

define("ST_OUT", 1);
define("ST_IN", 2);

$fp = fopen($argv[1],"r");

$state=ST_OUT;
$slide=1;
$slidetitle="title";

while (!feof($fp)) {
	$row = fgets($fp);
	if ($row === false) break;

//	echo "DBG: st:$state sl:$slide  $row";

	if ($state==ST_OUT) {
		if ($row[0] == '#') {
			$slidetitle = preg_replace('/^[# ]*/','', $row);
			$slidetitle = str_replace(array("\n", "\r"), '', $slidetitle);
			$slide++;
			continue;
		}
		if (strncmp($row, "<!--", 4)==0) {
			echo "[slide $slide $slidetitle]\n\n";
			$state=ST_IN;
			continue;
		} 

	} else if ($state==ST_IN) {
		if (strncmp($row, "-->", 3)==0) {
			$state=ST_OUT;
			echo "\n";
			continue;
		} 
		echo $row;
	} 
	
}

