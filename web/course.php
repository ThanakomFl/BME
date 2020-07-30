<?php define('BMEI_WWW', 1);
include_once(__DIR__ . '/lib.inc.php');

$SECTION = 'menu_curriculum';

$id = param_require('id');
$course = db_get_record('courses', ['id' => $id]);
if (!$course) {
    http_response_code(404); exit;
}

$course->code_lang = $course->{'code_' . $SESSION['language']};
$course->name = $course->{'name_' . $SESSION['language']};
$course->detail = textarea_display($course->{'detail_' . $SESSION['language']});
$course->prerequisites = db_get_records_sql('
  SELECT courses.*
    FROM courses
      JOIN course_prerequisites ON courses.id = course_prerequisites.required_course
    WHERE course_prerequisites.course = ?
    ORDER BY code ASC', [$course->id]);

render_header($course->name);

$smarty->assign('course', $course);

$smarty->display('course.tpl');

render_footer();