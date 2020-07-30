<?php define('BMEI_WWW', 1);
include_once(__DIR__ . '/lib.inc.php');

$SECTION = 'menu_curriculum';

$id = param_require('id');
$degree = db_get_record('degrees', ['id' => $id]);
if (!$degree || !$degree->visible) {
    http_response_code(404);
    exit;
}

$degree->name = $degree->{'name_' . $SESSION['language']};
$degree->short_name = $degree->{'short_name_' . $SESSION['language']};
$degree->detail = textarea_display($degree->{'detail_' . $SESSION['language']});
$degree->fileObj = $degree->file ? db_get_record('files', ['id' => $degree->file]) : false;
$degree->modules = db_get_records_array('degree_modules', ['degree' => $degree->id], 'name_' . $SESSION['language']);
foreach ($degree->modules as &$module) {
    $module->name = $module->{'name_' . $SESSION['language']};
    $module->moduleCourses = db_get_records_sql('SELECT module_courses.* FROM module_courses JOIN courses ON courses.id = module_courses.course WHERE module = ? ORDER BY code ASC', [$module->id]);
    foreach ($module->moduleCourses as &$moduleCourse) {
        $moduleCourse->course = db_get_record('courses', ['id' => $moduleCourse->course]);

        $moduleCourse->course_code = $moduleCourse->course ? $moduleCourse->course->code : str('no_data');
        $moduleCourse->course_name = $moduleCourse->course ? $moduleCourse->course->{'name_' . $SESSION['language']} : '-';
    }
    unset($moduleCourse);
}
unset($module);

render_header($degree->name);

$smarty->assign('degree', $degree);

$smarty->display('degree.tpl');

render_footer();