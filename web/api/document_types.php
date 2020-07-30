<?php define('BMEI_WWW', 1);
require_once(__DIR__ . '/../lib.inc.php');

$mode = param_optional('mode', 0);
$types = document_mode_types($mode);
$result = [];
foreach ($types as $type) {
    $result[] = [
        'value' => $type,
        'text' => document_type($type)
    ];
}

header('Content-Type: application/json');
echo json_encode($result);
