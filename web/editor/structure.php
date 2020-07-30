<?php define('BMEI_WWW', 1);
include_once(__DIR__ . '/../lib.inc.php');
authentication_required();

$id = param_optional('id', 0);

$objects = [];
$object = new stdClass();

$error = false;

if ($id) {
    $mode = 'edit';
}

if (param_sent('action')) {
    $action = param_require('action');

    if ($action == 'move') {
        $direction = param_require('direction');

        $currentObj = db_get_record('organization_structure_images', ['id' => $id]);
        if (!$currentObj) {
            http_response_code(500); exit;
        }

        $swapObj = false;
        if ($direction == 'up') {
            $swapObj = db_get_record_sql('SELECT * FROM organization_structure_images WHERE sequence < ? ORDER BY sequence DESC LIMIT 1', [$currentObj->sequence]);
        } else if ($direction == 'down') {
            $swapObj = db_get_record_sql('SELECT * FROM organization_structure_images WHERE sequence > ? ORDER BY sequence ASC LIMIT 1', [$currentObj->sequence]);
        } else {
            http_response_code(400); exit;
        }

        if ($swapObj) {
            $tempSequence = $currentObj->sequence;
            $currentObj->sequence = $swapObj->sequence;
            $swapObj->sequence = $tempSequence;

            db_update_records('organization_structure_images', [$currentObj, $swapObj]);
        }

        redirect(url('/editor/structure.php')); exit;
    } else if ($action == 'remove') {
        $currentObj = db_get_record('organization_structure_images', ['id' => $id]);
        if ($currentObj) {
            editor_remove_file($currentObj->image_th);
            editor_remove_file($currentObj->image_en);
        }

        db_delete_record('organization_structure_images', ['id' => $id]);
        editor_reorder('organization_structure_images');

        redirect(url('/editor/structure.php')); exit;
    }

    http_response_code(400); exit;
} else if (param_sent('submit')) {
    $lastObj = db_get_record_sql('SELECT * FROM organization_structure_images ORDER BY sequence DESC LIMIT 1');

    $object->id = 0;
    $object->heading_th = param_require('heading_th');
    $object->heading_en = param_require('heading_en');
    $object->image_th = editor_add_file('image_th');
    $object->image_en = editor_add_file('image_en');
    $object->sequence = $lastObj->sequence + 1;

    if (!$object->image_th || !$object->image_en) {
        $error = 'มีปัญหาในการอัปโหลดไฟล์ กรุณาตรวจสอบ';
    } else {
        $newID = db_insert_record('organization_structure_images', $object);

        if ($newID) {
            editor_reorder('organization_structure_images');
            redirect(url('/editor/structure.php')); exit;
        }

        $error = 'ไม่สามารถเพิ่มข้อมูลได้';
    }
} else {
    $object->heading_th = '';
    $object->heading_en = '';
}

$objects = db_get_records_array('organization_structure_images', [], 'sequence', SORT_ASC);

editor_render_header();

$smarty->assign('id', $id);
$smarty->assign('objects', $objects);
$smarty->assign('object', $object);
$smarty->assign('error', $error);

$smarty->display('editor/structure.tpl');

editor_render_footer();