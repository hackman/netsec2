<?php
// Regular Expression Injection attack: http://hauser-wenz.de/playground/papers/RegExInjection.pdf
// input: $username, $password, $newpassword
// e.g.:
$username = (isset($_GET['username'])) ? $_GET['username'] : '';
$password = (isset($_GET['password'])) ? $_GET['password'] : '';
$newpassword = (isset($_GET['newpassword'])) ? $_GET['newpassword'] : '';
echo("New pass: $newpassword<br />\n\n");
$users = file_get_contents('users');
$users = preg_replace("/($username):$password(:.*)/e", "'\\1:'.strtolower('$newpassword').'\\2'", $users );
$users = preg_replace("#[\r\n]+#", "<br />\n", $users, -1 );
echo($users);
?>
