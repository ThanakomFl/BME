<?php define('BMEI_WWW', 1);
include_once(__DIR__ . '/lib.inc.php');
// ob_clean();

session_write_close();

$id = param_require('id');
$key = param_optional('key', null);

$file = db_get_record('files', array('id' => $id));
if (!$file) {
    http_response_code(404); exit;
}

if ($file->access_key && $file->access_key != $key) {
    http_response_code(403); exit;
}

$filePath = $CONFIG['upload_path'] . '/' . $file->id;

if (!file_exists($filePath)) {
    http_response_code(404); exit;
}

header('Cache-control: public, max-age=31536000');
header('Pragma: public, max-age=31536000');
header('Content-Type: ' . $file->type);
header('Content-Length: ' . $file->size);
header('Content-Disposition: inline; filename="' . $file->name . '"');
readfile($filePath);
