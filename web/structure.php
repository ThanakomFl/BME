<?php define('BMEI_WWW', 1);
include_once(__DIR__ . '/lib.inc.php');

$SECTION = 'menu_about';

$objects = db_get_records_array('organization_structure_images', [], 'sequence', SORT_ASC);
foreach ($objects as &$object) {
    $object->heading = $object->{'heading_' . $SESSION['language']};
    $object->image = $object->{'image_' . $SESSION['language']};
}
unset($object);

render_header(str('menu_structure'));

$smarty->assign('objects', $objects);
$smarty->display('structure.tpl');

render_footer();