<?php define('BMEI_WWW', 1);
require_once(__DIR__ . '/../lib.inc.php');
authentication_required();

$success = false;
$error = null;
$id = param_optional('id', 0);
$mode = param_require('mode');

$current_document = null;
if ($id) {
    $document = db_get_record('documents', ['id' => $id]);
    $file = $document ? db_get_record('files', ['id' => $document->file]) : null;
    if ($document && $file) {
        $current_document = new stdClass();
        $current_document->id = $id;
        $current_document->file_name = $file->name;
        $current_document->date = date('d/m/Y', $document->uploaded_dt);
        $current_document->time = date('H:i:s', $document->uploaded_dt);
        $current_document->type = $document->type;
    }
}

if (!$current_document) {
    $id = 0;
    $current_document = new stdClass();
    $current_document->id = 0;
    $current_document->file_name = null;
    $current_document->date = param_optional('date', '');
    $current_document->time = param_optional('time', '');
    $current_document->type = param_optional('type', '');
}

if (param_sent('action')) {
    $action = param_require('action');
    if ($action == 'delete') {
        $id = param_require('id');

        $document = db_get_record('documents', ['id' => $id]);
        editor_remove_file($document->file);
        editor_remove_file($document->preview);
        db_delete_record('documents', ['id' => $id]);
        redirect(url("/editor/documents.php?mode={$mode}#list"));
    }
} else if (param_sent('submit')) {
    $date = get_date_timestamp(param_optional('date', null));
    $time = get_time_timestamp(param_optional('time', null));

    if ($id) {
        // Edit
        $document = db_get_record('documents', ['id' => $id]);
        $file = db_get_record('files', ['id' => $document->file]);
        if ($date) {
            $timestamp = $date;
            $timestamp += $time ? $time : 0;
        } else {
            $timestamp = $file->uploaded_dt;
        }

        $document->type = param_require('type');
        $document->uploaded_dt = $timestamp;
        if (db_update_records('documents', $document)) {
            $success = true;
            redirect(url("/editor/documents.php?mode={$mode}#list"));
        } else {
            $error = 'ไม่สามารถแก้ไขข้อมูลได้';
        }
    } else {
        // Add
        $file_id = editor_add_file('file', true);
        if ($file_id) {
            $file = db_get_record('files', ['id' => $file_id]);
            if ($date) {
                $timestamp = $date;
                $timestamp += $time ? $time : 0;
            } else {
                $timestamp = $file->uploaded_dt;
            }

            $preview_id = editor_add_file('preview', true);
            if ($preview_id) {
                $document = new stdClass();
                $document->id = 0;
                $document->file = $file_id;
                $document->preview = $preview_id;
                $document->type = param_require('type');
                $document->uploaded_dt = $timestamp;

                if (db_insert_record('documents', $document)) {
                    $success = true;
                } else {
                    $error = 'ไม่สามารถเพิ่มข้อมูลได้';
                    editor_remove_file($file_id);
                    editor_remove_file($preview_id);
                }

            } else {
                $error = 'ไม่สามารถอัปโหลดไฟล์ได้';
                editor_remove_file($file_id);
            }
        } else {
            $error = 'ไม่สามารถอัปโหลดไฟล์ได้';
        }
    }
}

editor_render_header(['datepicker']);

$smarty->assign('error', $error);
$smarty->assign('success', $success);
$smarty->assign('id', $id);
$smarty->assign('current_document', $current_document);
$smarty->assign('mode', $mode);
$smarty->display('editor/documents.tpl');

include_js('/js/angular.min.js');
include_js('/js/angular-app.js');
include_js('/js/directives/documents.js');

editor_render_footer();
