<?php define('BMEI_WWW', 1);
include_once(__DIR__ . '/../lib.inc.php');
authentication_required();

authentication_required();

editor_render_header();
research_render_header('categories');

echo wrap_tag('h3', 'ประเภทงานวิจัย');

if (param_sent('action')) {
    $action = param_require('action');
    $id = param_require('id');

    $category = db_get_record('research_categories', array('id' => $id));
    if ($category) {
        if ($action == 'remove') {
            db_delete_record('research_categories', array('id' => $id));
        }
    }

    redirect(url('/editor/research_categories.php')); exit;
}

$mode = param_optional('mode', 'new');

$defaultTitleTH = '';
$defaultTitleEN = '';

$panelStyle = 'primary';
if ($mode == 'new') {
    $panelStyle = 'success';

    echo open_tag('ul');
    $categories = db_get_records_array('research_categories', array(), 'id', SORT_ASC);
    foreach ($categories as $category) {
        echo wrap_tag('li',
            html_button(url('/editor/research_categories.php?mode=edit&id=' . $category->id), 'แก้ไข', 'default', 'xs')
            . html_button(url('/editor/research_categories.php?action=remove&id=' . $category->id), 'ลบ', 'danger', 'xs', 'แน่ใจหรือไม่ว่าต้องการลบ?')
            . ' ' . $category->title_th . ' / ' . $category->title_en);
    }
    echo close_tag('ul');
} else {
    $id = param_require('id');
    $category = db_get_record('research_categories', array('id' => $id));

    if (!$category) {
        http_response_code(404); exit;
    }

    $defaultTitleTH = $category->title_th;
    $defaultTitleEN = $category->title_en;
}

?>
<hr>
<form action="research_categories.php" method="post">
    <?php
    if (param_sent('submit')) {
        $title_th = param_require('title_th');
        $title_en = param_require('title_en');

        if (trim($title_th) == '' || trim($title_en) == '') {
            $error = 'กรุณากรอกข้อมูลให้ครบ';
        } else {
            if ($mode == 'new') {
                $category = new stdClass();
                $category->id = 0;
                $category->title_th = $title_th;
                $category->title_en = $title_en;
                $newID = db_insert_record('research_categories', $category);
                if (!$newID) {
                    $error = 'ไม่สามารถเพิ่มได้';
                } else {
                    redirect(url('/editor/research_categories.php')); exit;
                }
            } else if ($mode == 'edit') {
                $category->title_th = $title_th;
                $category->title_en = $title_en;

                if (!db_update_records('research_categories', $category)) {
                    $error = 'ไม่สามารถแก้ไขได้';
                }
            }
        }

        if (!isset($error)) {
            redirect(url('/editor/research_categories.php')); exit;
        }
    }
    ?>
    <div class="panel panel-<?php echo $panelStyle; ?>">
        <div class="panel-heading"><?php echo $mode == 'new' ? 'เพิ่มประเภทใหม่' : 'แก้ไขประเภท ' . $defaultTitleTH; ?></div>
        <div class="panel-body">
            <?php
            if (isset($error)) {
               echo alert_error($error);
            }
            ?>
            <div class="row">
                <div class="col-md-6">
                    <div class="input-group">
                        <span class="input-group-addon">ชื่อประเภท (ภาษาไทย)</span>
                        <input type="text" name="title_th" title="ชื่อประเภท (ภาษาไทย)" class="form-control" value="<?php echo $defaultTitleTH; ?>">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon">ชื่อประเภท (ภาษาอังกฤษ)</span>
                        <input type="text" name="title_en" title="ชื่อประเภท (ภาษาอังกฤษ)" class="form-control" value="<?php echo $defaultTitleEN; ?>">
                    </div>
                </div>
            </div>
        </div>
        <div class="panel-footer">
            <button type="submit" class="btn btn-<?php echo $panelStyle; ?>"><?php echo $mode == 'new' ? 'เพิ่ม' : 'แก้ไข'; ?></button>
            <?php
            echo open_tag('input', array('type' => 'hidden', 'name' => 'mode', 'value' => $mode));
            if ($mode == 'edit') {
                echo open_tag('input', array('type' => 'hidden', 'name' => 'id', 'value' => $category->id));
                echo wrap_tag('a', 'ยกเลิก', array('href' => url('/editor/research_categories.php')));
            }
            ?>
        </div>
    </div>
    <input type="hidden" name="submit" value="1">
</form>
<?php

editor_render_footer();