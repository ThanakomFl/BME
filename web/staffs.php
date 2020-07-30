<?php define('BMEI_WWW', 1);
include_once(__DIR__ . '/lib.inc.php');

$SECTION = 'menu_about';

$type = param_optional('type', STAFF_LECTURER);

$staffs = db_get_records_array('staffs', ['type' => $type], 'sequence', SORT_ASC);
foreach ($staffs as &$staff) {
    $staff->name = $staff->{'name_' . $SESSION['language']};
    $staff->detail = textarea_display($staff->{'detail_' . $SESSION['language']});
}
unset($staff);
unset($staff);

render_header(str('menu_staff'));

$smarty->assign('type', $type);
$smarty->assign('staffs', $staffs);

$smarty->display('staffs.tpl');

render_footer();