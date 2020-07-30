<?php define('BMEI_WWW', 1);
include_once(__DIR__ . '/../lib.inc.php');
authentication_required();

editor_render_header();

if (param_sent('action')) {
    $action = param_require('action');
    $id = param_require('id');

    $slideShow = db_get_record('slide_shows', array('id' => $id));

    if (!$slideShow) {
        http_response_code(500); exit;
    }

    if ($action == 'hide') {
        $slideShow->visible = 0;
        db_update_records('slide_shows', $slideShow);
    } else if ($action == 'show') {
        $slideShow->visible = 1;
        db_update_records('slide_shows', $slideShow);
    } else if ($action == 'moveup') {
        $previousItem = db_get_record_sql('SELECT * FROM slide_shows WHERE sequence < ? ORDER BY sequence DESC LIMIT 1', array($slideShow->sequence));
        if ($previousItem) {
            swap($previousItem->sequence, $slideShow->sequence);
            db_update_records('slide_shows', array($previousItem, $slideShow));
        }
    } else if ($action == 'movedown') {
        $nextItem = db_get_record_sql('SELECT * FROM slide_shows WHERE sequence > ? ORDER BY sequence ASC LIMIT 1', array($slideShow->sequence));
        if ($nextItem) {
            swap($nextItem->sequence, $slideShow->sequence);
            db_update_records('slide_shows', array($nextItem, $slideShow));
        }
    } else if ($action == 'remove') {
        editor_remove_file($slideShow->image);
        db_delete_record('slide_shows', array('id' => $slideShow->id));
    }

    redirect(url('/editor/slide_shows.php')); exit;
}

echo wrap_tag('h3', 'รูปภาพหน้าแรก');

$slideShows = db_get_records_array('slide_shows', array(), 'sequence', SORT_ASC);
echo open_tag('ul');
foreach ($slideShows as $slideShow) {
    $visibleButton = '';
    echo open_tag('li');
    if ($slideShow->visible) {
        echo wrap_tag('span', '<i class="fa fa-check"></i> แสดง', array('class' => 'label label-success'));
        $visibleButton = html_button('slide_shows.php?action=hide&id=' . $slideShow->id, 'ซ่อน', 'default', 'xs');
    } else {
        echo wrap_tag('span', '<i class="fa fa-times"></i> ซ่อน', array('class' => 'label label-default'));
        $visibleButton = html_button('slide_shows.php?action=show&id=' . $slideShow->id, 'แสดง', 'default', 'xs');
    }
    echo ' ';
    echo upload_image_html($slideShow->image, array('style' => 'width: 200px; height: auto;'));

    echo ' ';

    echo html_button('slide_shows.php?action=moveup&id=' . $slideShow->id, '<i class="fa fa-arrow-up"></i> ย้ายขึ้น', 'default', 'xs');
    echo html_button('slide_shows.php?action=movedown&id=' . $slideShow->id, '<i class="fa fa-arrow-down"></i> ย้ายลง', 'default', 'xs');
    echo $visibleButton;
    echo html_button('slide_shows.php?action=remove&id=' . $slideShow->id, '<i class="fa fa-trash-o"></i> ลบ', 'danger', 'xs', 'แน่ใจหรือไม่ว่าต้องการลบ?');

    echo close_tag('li');
}
echo close_tag('ul');

?>
<hr>
<form action="slide_shows.php" method="post" enctype="multipart/form-data">
    <div class="panel panel-success">
        <div class="panel-heading">เพิ่มรูปใหม่</div>
        <div class="panel-body">
            <?php
            if (param_sent('submit')) {
                $error = false;

                $fileID = editor_add_file('image');
                if (!$fileID) {
                    $error = 'ไม่สามารถอัปโหลดไฟล์ได้';
                } else {
                    $visible = param_optional('visible', 0);
                    $url = param_require('url');


                    $slide = new stdClass();
                    $slide->id = 0;
                    $slide->image = $fileID;
                    $slide->sequence = 1;
                    $slide->visible = $visible;
                    $slide->url = $url;

                    $other_slides = db_get_records_array('slide_shows', [], 'sequence', SORT_ASC);
                    foreach ($other_slides as $other_slide) {
                        $other_slide->sequence++;
                    }
                    db_update_records('slide_shows', $other_slides);

                    $slideID = db_insert_record('slide_shows', $slide);

                    if (!$slideID) {
                        $error = 'ไม่สามารถเพิ่มข้อมูลได้';
                    }

                    if (!$error) {
                        reload();
                    }
                }

                if ($error) {
                    echo alert_error($error);
                }
            }
            ?>
            <p>
                <strong>อัปโหลดรูป:</strong>
                <input type="file" name="image">
            </p>
            <div class="input-group" style="margin: 10px 0;">
                <span class="input-group-addon">URL</span>
                <input type="text" name="url" title="URL" class="form-control">
            </div>
            <p>
                <label>
                    <input type="checkbox" name="visible" value="1" checked>
                    แสดงผลในหน้าแรก
                </label>
            </p>
        </div>
        <div class="panel-footer">
            <button type="submit" class="btn btn-success">ตกลง</button>
        </div>
    </div>
    <input type="hidden" name="submit" value="add">
</form>
<?php

editor_render_footer();