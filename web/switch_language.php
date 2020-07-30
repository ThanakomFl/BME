<?php define('BMEI_WWW', 1);
include_once(__DIR__ . '/lib.inc.php');

if ($SESSION['language'] == 'th') {
    $SESSION['language'] = 'en';
} else {
    $SESSION['language'] = 'th';
}

$return_url = base64_decode($_GET['return_url']);

header('location: ' . $return_url);