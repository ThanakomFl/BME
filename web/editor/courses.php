<?php define('BMEI_WWW', 1);
include_once(__DIR__ . '/../lib.inc.php');
authentication_required();

$mode = param_optional('mode', 'new');
$id = param_optional('id', 0);

$error = false;
$course = new stdClass();
$courses = db_get_records_array('courses', [], 'code', SORT_ASC);

if (param_sent('action')) {
    $action = param_require('action');

    if ($action == 'remove') {
        db_delete_record('course_prerequisites', ['course' => $id]);
        db_delete_record('courses', ['id' => $id]);

        redirect(url('/editor/courses.php'));
    }

    http_response_code(400); exit;
} else if (param_sent('submit')) {
    $course = new stdClass();
    $course->id = $id;
    $course->code = param_require('code');
    $course->code_th = param_require('code_th');
    $course->code_en = param_require('code_en');
    $course->name_th = param_require('name_th');
    $course->name_en = param_require('name_en');
    $course->credit = param_require('credit');
    $course->detail_th = param_require('detail_th');
    $course->detail_en = param_require('detail_en');
    $course->condition_department = param_optional('condition_department', 0);
    $course->condition_instructor = param_optional('condition_instructor', 0);

    $prerequisites = param_optional('prerequisites', []);

    if (!is_numeric($course->code) || trim($course->code_th) == '' || trim($course->code_en) == ''
    || trim($course->name_th) == '' || trim($course->name_en) == '' || !is_numeric($course->credit)) {
        $error = 'กรุณากรอกข้อมูลให้ถูกต้อง';
    }

    if (!$error) {
        if ($mode == 'new') {
            $newID = db_insert_record('courses', $course);

            foreach ($prerequisites as $prerequisite) {
                if ($prerequisite == $course->id) {
                    continue;
                }
                $coursePre = new stdClass();
                $coursePre->id = 0;
                $coursePre->course = $newID;
                $coursePre->required_course = $prerequisite;
                db_insert_record('course_prerequisites', $coursePre);
            }

            if ($newID) {
                redirect(url('/editor/courses.php')); exit;
            }

            $error = 'ไม่สามารถเพิ่มข้อมูลได้';
        } else if ($mode == 'edit') {

            db_delete_record('course_prerequisites', ['course' => $course->id]);
            foreach ($prerequisites as $prerequisite) {
                if ($prerequisite == $course->id) {
                    continue;
                }
                $coursePre = new stdClass();
                $coursePre->id = 0;
                $coursePre->course = $course->id;
                $coursePre->required_course = $prerequisite;
                db_insert_record('course_prerequisites', $coursePre);
            }

            if (db_update_records('courses', $course)) {
                redirect(url('/editor/courses.php')); exit;
            }

            $error = 'ไม่สามารถแก้ไขข้อมูลได้';
        }
    }
} else {
    if (!$id) {
        $mode = 'new';
        $course = new stdClass();
        $course->id = 0;
        $course->code = '';
        $course->code_th = '';
        $course->code_en = '';
        $course->name_th = '';
        $course->name_en = '';
        $course->credit = '';
        $course->detail_th = '';
        $course->detail_en = '';
        $course->condition_department = 0;
        $course->condition_instructor = 0;
        $course->prerequisites = [];
    } else if ($id) {
        $mode = 'edit';
        $course = db_get_record('courses', ['id' => $id]);

        $prerequisites = db_get_records_array('course_prerequisites', ['course' => $course->id]);
        $course->prerequisites = get_property_array($prerequisites, 'required_course');

        if (!$course) {
            http_response_code(404); exit;
        }
    }
}

editor_render_header();
degree_render_header('courses');

$smarty->assign('mode', $mode);
$smarty->assign('id', $id);
$smarty->assign('error', $error);
$smarty->assign('courses', $courses);
$smarty->assign('course', $course);

$smarty->display('editor/courses.tpl');

editor_render_footer();