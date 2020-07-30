<?php define('BMEI_WWW', 1);
include_once(__DIR__ . '/../lib.inc.php');
authentication_required();

$degreeID = param_require('degree');
$degree = db_get_record('degrees', ['id' => $degreeID]);
if (!$degree) {
    http_response_code(404); exit;
}

$mode = param_optional('mode', 'new');
$moduleID = param_optional('module', 0);

if ($moduleID) {
    $mode = 'edit';
}

$error = false;
$courses = [];

$module = new stdClass();
$modules = [];

$courseList = [];

if (param_sent('action')) {
    $action = param_require('action');

    if ($action == 'remove') {
        db_delete_record('module_courses', ['module' => $moduleID]);
        db_delete_record('degree_modules', ['id' => $moduleID]);

        redirect(url('/editor/degree_modules.php', PATH_INTERNAL, ['degree' => $degreeID]));
        exit;
    }

    http_response_code(400); exit;
} else if (param_sent('submit')) {
    $module = new stdClass();
    $module->id = $moduleID;
    $module->degree = $degree->id;
    $module->name_th = param_require('name_th');
    $module->name_en = param_require('name_en');
    $module->minimum_credits = param_require('minimum_credits');

    $courses = param_optional('courses', []);

    if (trim($module->name_th) == '' || trim($module->name_en) == '' || !is_numeric($module->minimum_credits)) {
        $error = 'กรุณากรอกข้อมูลให้ถูกต้อง';
    } else {
        if ($mode == 'new') {
            $newID = db_insert_record('degree_modules', $module);

            if ($newID) {
                foreach ($courses as $courseID) {
                    $moduleCourse = new stdClass();
                    $moduleCourse->id = 0;
                    $moduleCourse->module = $newID;
                    $moduleCourse->course = $courseID;
                    db_insert_record('module_courses', $moduleCourse);
                }
                redirect(url('/editor/degree_modules.php', PATH_INTERNAL, ['degree' => $degreeID]));
                exit;
            }

            $error = 'ไม่สามารถเพิ่มข้อมูลได้';
        } else if ($mode == 'edit') {
            db_delete_record('module_courses', ['module' => $moduleID]);
            foreach ($courses as $courseID) {
                $moduleCourse = new stdClass();
                $moduleCourse->id = 0;
                $moduleCourse->module = $moduleID;
                $moduleCourse->course = $courseID;
                db_insert_record('module_courses', $moduleCourse);
            }
            db_update_records('degree_modules', $module);
            redirect(url('/editor/degree_modules', PATH_INTERNAL, ['degree' => $degreeID]));
            exit;
        }
    }
} else {
    if ($mode == 'new') {
        $modules = db_get_records_array('degree_modules', ['degree' => $degreeID], 'name_th', SORT_ASC);
        $module = new stdClass();
        $module->id = 0;
        $module->degree = $degreeID;
        $module->name_th = '';
        $module->name_en = '';
        $module->minimum_credits = '';
    } else if ($mode == 'edit') {
        $module = db_get_record('degree_modules', ['id' => $moduleID, 'degree' => $degreeID]);
        if (!$module) {
            http_response_code(400);
            exit;
        }

        $moduleCourses = db_get_records_array('module_courses', ['module' => $moduleID]);
        $courses = get_property_array($moduleCourses, 'course');
    }
}

$courseList = db_get_records_array('courses', [], 'code', SORT_ASC);

editor_render_header();
degree_render_header('degrees');

$smarty->assign('mode', $mode);
$smarty->assign('degree', $degreeID);
$smarty->assign('error', $error);
$smarty->assign('modules', $modules);
$smarty->assign('module', $module);
$smarty->assign('courses', $courses);
$smarty->assign('courseList', $courseList);

$smarty->display('editor/degree_modules.tpl');

editor_render_footer();