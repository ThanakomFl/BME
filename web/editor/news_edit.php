<?php define('BMEI_WWW', 1);
include_once(__DIR__ . '/../lib.inc.php');
authentication_required();

editor_render_header(['datepicker']);

$id = param_require('id');
$news = db_get_record('news', ['id' => $id]);
if (!$news) {
    http_response_code(404); exit;
}

$dateInput = date('d/m/Y', $news->published_dt);
$timeInput = date('H:i:s', $news->published_dt);

if (param_sent('action')) {
    $action = param_require('action');
    if ($action == 'remove') {
        db_delete_record('news', ['id' => $id]);
        foreach (db_get_records_array('news_files', ['news' => $id]) as $news_file) {
            editor_remove_file($news_file->file);
        }
        db_delete_record('news_files', ['news' => $id]);
        redirect(url('/editor/news.php'));
    } else if ($action == 'remove_file') {
        $ref_id = param_require('ref_id');
        $news_file = db_get_record('news_files', ['id' => $ref_id]);
        editor_remove_file($news_file->file);
        db_delete_record('news_files', ['id' => $ref_id]);
        redirect(url('/editor/news_edit.php', PATH_INTERNAL, ['id' => $news->id])); exit;
    }
}

if (param_sent('submit')) {
    $news->category = param_require('category');

    $news->title_th = param_require('title_th');
    $news->title_en = param_require('title_en');

    $news->detail_th = param_require('detail_th');
    $news->detail_en = param_require('detail_en');

    $news->visible = param_optional('visible', 0) ? 1 : 0;
    $news->show_front = param_optional('show_front', 0) ? 1 : 0;

    $dateInput = param_require('date');
    $timeInput = param_require('time');

    $date = get_date_timestamp(param_require('date'));
    $time = get_time_timestamp(param_require('time'));
    $timestamp = $date ? $date : null;
    if ($timestamp) {
        $timestamp += $time ? $time : 0;
        $news->published_dt = $timestamp;
    }

    $imageFile = $_FILES['new_image'];
    if ($imageFile['error'] == UPLOAD_ERR_OK) {
        $newImageID = editor_add_file('new_image');
        if ($newImageID) {
            $news_file = new stdClass();
            $news_file->id = 0;
            $news_file->news = $news->id;
            $news_file->file = $newImageID;
            $news_file->image = 1;
            $news_file->description_th = param_require('new_image_description_th');
            $news_file->description_en = param_require('new_image_description_en');
            db_insert_record('news_files', $news_file);
        }
    }

    $attachmentFile = $_FILES['new_file'];
    if ($attachmentFile['error'] == UPLOAD_ERR_OK) {
        $newFileID = editor_add_file('new_file');
        if ($newFileID) {
            $news_file = new stdClass();
            $news_file->id = 0;
            $news_file->news = $news->id;
            $news_file->file = $newFileID;
            $news_file->image = 0;
            $news_file->description_th = '';
            $news_file->description_en = '';
            db_insert_record('news_files', $news_file);
        }
    }

    db_update_records('news', $news);

    redirect(url('/editor/news_edit.php', PATH_INTERNAL, ['id' => $news->id]));
}

$news->attachments = db_get_records_array('news_files', ['news' => $news->id, 'image' => 0]);
$news->images = db_get_records_array('news_files', ['news' => $news->id, 'image' => 1]);

foreach ($news->attachments as &$attachment) {
    $attachment->fileObj = db_get_record('files', ['id' => $attachment->file]);
}
unset($attachment);

$smarty->assign('news', $news);
$smarty->assign('date', $dateInput);
$smarty->assign('time', $timeInput);

$smarty->display('editor/news_edit.tpl');

editor_render_footer();