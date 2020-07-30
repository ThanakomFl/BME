<?php define('BMEI_WWW', 1);
include_once(__DIR__ . '/../lib.inc.php');
authentication_required();

account_sign_out();
redirect(url('/'));