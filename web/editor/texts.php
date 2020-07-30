<?php define('BMEI_WWW', 1);
include_once(__DIR__ . '/../lib.inc.php');
authentication_required();

editor_render_header();

echo wrap_tag('h3', 'แก้ไขข้อความ');

$texts = db_get_records_array('texts');

echo open_tag('ul');
foreach ($texts as $text) {
    echo wrap_tag('a', wrap_tag('li', $text->description), ['href' => url('/editor/text.php', PATH_INTERNAL, ['id' => $text->id])]);
}
echo close_tag('ul');

foreach ($texts as $text) {
    echo open_tag('div', array('class' => 'panel panel-info'));
    echo wrap_tag('div', $text->description . " ({$text->id})", array('class' => 'panel-heading'));
    echo wrap_tag('div',
        wrap_tag('strong', 'ภาษาไทย') . '<br>' . textarea_display($text->text_th)
        . open_tag('hr')
        . wrap_tag('strong', 'ภาษาอังกฤษ') . '<br>' . textarea_display($text->text_en)
        , array('class' => 'panel-body'));
    echo wrap_tag('div', html_button(url('/editor/text.php', PATH_INTERNAL, array('id' => $text->id)), '<i class="fa fa-edit"></i> แก้ไข', 'default'), array('class' => 'panel-footer'));
    echo close_tag('div');
}

editor_render_footer();