<?php define('BMEI_WWW', 1);
include_once(__DIR__ . '/../lib.inc.php');
authentication_required();

$mode = param_optional('mode', 'new');
$id = param_optional('id', 0);

$degrees = [];
$degree = false;
$error = false;

if (param_sent('action')) {
    $action = param_require('action');
    if ($action == 'remove') {
        $degree = db_get_record('degrees', ['id' => $id]);
        if (!$degree) {
            http_response_code(404); exit;
        }

        editor_remove_file($degree->file);

        $degreeModules = db_get_records_array('degree_modules', ['degree' => $id]);
        foreach ($degreeModules as $degreeModule) {
            db_delete_record('module_courses', ['module' => $degreeModule->id]);
        }
        db_delete_record('degree_modules', ['degree' => $id]);
        db_delete_record('degrees', ['id' => $id]);

        redirect(url('/editor/degrees.php'));
        exit;
    }

    http_response_code(400); exit;
} else if (param_sent('submit')) {
    $degree = new stdClass();
    $degree->id = $id;
    $degree->name_th = param_require('name_th');
    $degree->name_en = param_require('name_en');
    $degree->short_name_th = param_require('short_name_th');
    $degree->short_name_en = param_require('short_name_en');
    $degree->detail_th = param_require('detail_th');
    $degree->detail_en = param_require('detail_en');
    $degree->visible = param_optional('visible', 0);

    $newFileID = editor_add_file('upload');

    if (trim($degree->name_th) == '' || trim($degree->name_en) == ''
    || trim($degree->short_name_th) == '' || trim($degree->short_name_en) == ''
    || trim($degree->detail_th) == '' || trim($degree->detail_en) == '') {
        $error = 'กรุณากรอกข้อมูลให้ครบ';
    } else {
        if ($mode == 'new') {
            $degree->file = $newFileID ? $newFileID : 0;

            $newID = db_insert_record('degrees', $degree);
            if ($newID) {
                redirect(url('/editor/degree_modules.php', PATH_INTERNAL, ['degree' => $newID]));
                exit;
            }

            $error = 'ไม่สามารถเพิ่มข้อมูลได้';
        } else if ($mode == 'edit') {
            $oldData = db_get_record('degrees', ['id' => $id]);
            if (!$oldData) {
                http_response_code(500); exit;
            }

            if (param_optional('remove_file', false)) {
                editor_remove_file($oldData->file);
                $degree->file = 0;
            }

            if ($newFileID) {
                editor_remove_file($oldData->file);
                $degree->file = $newFileID;
            }

            if (db_update_records('degrees', $degree)) {
                redirect(url('/editor/degrees.php'));
                exit;
            }

            $error = 'ไม่สามารถแก้ไขข้อมูลได้';
        }
    }
} else {
    $degree = new stdClass();
    if (!$id) {
        $mode = 'new';
        $degree->id = 0;
        $degree->name_th = '';
        $degree->name_en = '';
        $degree->short_name_th = '';
        $degree->short_name_en = '';
        $degree->detail_th = '';
        $degree->detail_en = '';
        $degree->file = 0;
        $degree->visible = 0;

        $degrees = db_get_records_array('degrees', [], 'name_th', SORT_ASC);
    } else {
        $mode = 'edit';
        $degree = db_get_record('degrees', ['id' => $id]);
        if (!$degree) {
            http_response_code(404); exit;
        }
    }
}

editor_render_header();
degree_render_header('degrees');

$smarty->assign('mode', $mode);
$smarty->assign('degrees', $degrees);
$smarty->assign('degree', $degree);
$smarty->assign('error', $error);

$smarty->display('editor/degrees.tpl');

editor_render_footer();