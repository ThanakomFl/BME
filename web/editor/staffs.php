<?php define('BMEI_WWW', 1);
include_once(__DIR__ . '/../lib.inc.php');
authentication_required();

$id = param_optional('id', 0);
$mode = $id ? 'edit' : 'new';

$staff = new stdClass();
$staff->id = 0;
$staff->name_th = '';
$staff->name_en = '';
$staff->type = 0;
$staff->picture = 0;
$staff->detail_th = '';
$staff->detail_en = '';

$error = false;

if (param_sent('action')) {
    $action = param_require('action');

    if ($action == 'remove' && $id) {
        $staff = db_get_record('staffs', ['id' => $id]);
        $staff->picture && editor_remove_file($staff->picture);
        db_delete_record('staffs', ['id' => $staff->id]);

        redirect(url('/editor/staffs.php')); exit;
    } else if ($action == 'resequence') {
        $id1 = param_require('id1');
        $id2 = param_require('id2');

        $staff1 = db_get_record('staffs', ['id' => $id1]);
        $staff2 = db_get_record('staffs', ['id' => $id2]);
        if (!$staff1 || !$staff2 || $staff1->type != $staff2->type) {
            redirect(url('/editor/staffs.php')); exit;
        }

        $temp = $staff1->sequence;
        $staff1->sequence = $staff2->sequence;
        $staff2->sequence = $temp;
        db_update_records('staffs', [$staff1, $staff2]);
        staffs_resequence($staff1->type);
        redirect(url('/editor/staffs.php')); exit;
    }

    http_response_code(400); exit;
} else if (param_sent('submit')) {
    $mode = param_require('mode');

    $staff = new stdClass();
    $staff->name_th = param_require('name_th');
    $staff->name_en = param_require('name_en');
    $staff->type = param_require('type');
    $staff->detail_th = param_require('detail_th');
    $staff->detail_en = param_require('detail_en');

    if (trim($staff->name_th) == '' || trim($staff->name_en) == '') {
        $error = 'กรุณากรอกข้อมูลให้ครบ';
    } else {

        $newPictureID = editor_add_file('picture');
        if ($newPictureID) {
            $oldData = db_get_record('staffs', ['id' => $id]);
            if ($oldData->picture) {
                editor_remove_file($oldData->picture);
            }

            $staff->picture = $newPictureID;
        } else if ($mode == 'new') {
            $staff->picture = 0;
        }

        if ($mode == 'new') {
            $staff->sequence = get_staff_last_sequence($staff->type) + 1;
            if (!db_insert_record('staffs', $staff)) {
                $error = 'ไม่สามารถเพิ่มได้';
            }
        } else if ($mode == 'edit') {
            $oldData = db_get_record('staffs', ['id' => $id]);
            $staff->sequence = $oldData->sequence;
            $staff->id = param_require('id');

            if (param_optional('remove_picture', false)) {
                if ($oldData->picture) {
                    editor_remove_file($oldData->picture);
                }
                $staff->picture = 0;
            }

            if (!db_update_records('staffs', $staff)) {
                $error = 'ไม่สามารถแก้ไขได้';
            }
        }

        if (!$error) {
            staffs_resequence($staff->type);
            redirect(url('/editor/staffs.php'));
            exit;
        }
    }
}

$staffs = [];
$staff_types = [
    [ 'type' => STAFF_LECTURER,
        'name' => 'คณาจารย์' ],
    [ 'type' => STAFF_RESEARCHER,
        'name' => 'นักวิจัย'],
    [ 'type' => STAFF_OFFICER,
        'name' => 'เจ้าหน้าที่']
];
if ($mode == 'new') {
    $staffs = [
        STAFF_LECTURER => [],
        STAFF_OFFICER => [],
        STAFF_RESEARCHER => []
    ];
    $all_staffs = db_get_records_array('staffs', [], 'sequence', SORT_ASC);
    foreach ($all_staffs as $each_staff) {
        if (!isset($staffs[$each_staff->type])) {
            continue;
        }
        $staffs[$each_staff->type][] = $each_staff;
    }
} else if ($mode == 'edit') {
    $staff = db_get_record('staffs', ['id' => $id]);
} else {
    http_response_code(400); exit;
}

editor_render_header();

$smarty->assign('mode', $mode);
$smarty->assign('id', $id);
$smarty->assign('staff_types',$staff_types);
$smarty->assign('staffs', $staffs);
$smarty->assign('staff', $staff);
$smarty->assign('error', $error);
$smarty->display('editor/staffs.tpl');

editor_render_footer();