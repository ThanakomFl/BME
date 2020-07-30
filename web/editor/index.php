<?php define('BMEI_WWW', 1) or die();
include_once(__DIR__ . '/../lib.inc.php');
authentication_required();

editor_render_header();

echo wrap_tag('h3', "ยินดีต้อนรับ {$SESSION['editor']->display_name}");

editor_render_footer();