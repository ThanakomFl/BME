<?php define('BMEI_WWW', 1);
include_once(__DIR__ . '/lib.inc.php');

$SECTION = 'menu_curriculum';

$degrees = db_get_records_array('degrees', ['visible' => 1], 'name_th', SORT_ASC);
foreach ($degrees as &$degree) {
    $degree->name = $degree->{'name_' . $SESSION['language']};
    $degree->short_name = $degree->{'short_name_' . $SESSION['language']};
}
unset($degree);

render_header(str('menu_curriculum'));

$smarty->assign('degrees', $degrees);

$smarty->display('degrees.tpl');

render_footer();