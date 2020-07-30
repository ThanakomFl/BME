<?php define('BMEI_WWW', 1);
include_once(__DIR__ . '/../lib.inc.php');
authentication_required();

editor_render_header();

$id = param_require('id');
$text = db_get_record('texts', array('id' => $id));
if (!$text) {
    http_response_code(404); exit;
}

if (param_sent('submit')) {
    $text->text_th = param_require('text_th');
    $text->text_en = param_require('text_en');

    db_update_records('texts', $text);
    redirect(url('/editor/texts.php')); exit;
}

echo wrap_tag('h3', 'แก้ไขข้อความ: ' . $text->description);

echo open_tag('form', array('action' => url('/editor/text.php'), 'method' => 'post', 'enctype' => 'application/x-www-form-urlencoded'));
echo wrap_tag('strong', 'ภาษาไทย');
echo wrap_tag('textarea', $text->text_th, array('name' => 'text_th', 'class' => 'form-control'));
echo wrap_tag('strong', 'ภาษาอังกฤษ');
echo wrap_tag('textarea', $text->text_en, array('name' => 'text_en', 'class' => 'form-control'));
echo open_tag('input', array('type' => 'hidden', 'name' => 'id', 'value' => $id));
echo open_tag('input', array('type' => 'hidden', 'name' => 'submit', 'value' => 1));

echo wrap_tag('div', wrap_tag('button', 'ตกลง', array('type' => 'submit', 'class' => 'btn btn-success')), array('style' => 'margin-top: 10px;'));

echo close_tag('form');

editor_render_footer();