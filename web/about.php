<?php define('BMEI_WWW', 1);
include_once(__DIR__ . '/lib.inc.php');

$SECTION = 'menu_about';

render_header(str('about'));

$smarty->assign('title', str('about'));
$smarty->assign('message', textarea_display(get_text('about')));

$smarty->display('simple.tpl');

render_footer();