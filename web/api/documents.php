<?php define('BMEI_WWW', 1);
require_once(__DIR__ . '/../lib.inc.php');

$mode = param_optional('mode', 0);

$documents = $mode ?
    document_list($mode) :
    db_get_records_array('documents', [], 'uploaded_dt', SORT_DESC);
foreach ($documents as $document) {
    $file = db_get_record('files', ['id' => $document->file]);
    $document->file_name = $file ? $file->name : '-';
    $document->file_size = $file ? $file->size : 0;
    $document->file_secret = $file ? $file->access_key : '';

    $preview = db_get_record('files', ['id' => $document->preview]);
    $document->preview_secret = $preview ? $preview->access_key : '';

    $document->type_text = document_type($document->type);
}

header('Content-Type: application/json');
echo json_encode($documents);
