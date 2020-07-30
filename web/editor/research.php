<?php define('BMEI_WWW', 1);
include_once(__DIR__ . '/../lib.inc.php');
authentication_required();

$id = param_require('id');
$research = db_get_record('researches', array('id' => $id));
if (!$research) {
    http_response_code(404); exit;
}

editor_render_header();
research_render_header('researches');

$id = param_require('id');

$research = db_get_record('researches', array('id' => $id));
if (!$research) {
    http_response_code(404);
}

echo wrap_tag('h3', "{$research->title_th} / {$research->title_en} " . html_button(url('/editor/research_detail.php?id=' . $id), '<i class="fa fa-edit"></i> แก้ไขชื่อ', 'default', 'xs'));

?>

<?php

editor_render_footer();