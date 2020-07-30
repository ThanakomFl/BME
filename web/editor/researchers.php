<?php define('BMEI_WWW', 1);
include_once(__DIR__ . '/../lib.inc.php');
authentication_required();

authentication_required();

editor_render_header();
research_render_header('researchers');

echo wrap_tag('h3', 'รายชื่อนักวิจัย');

if (param_sent('action')) {
    $action = param_require('action');
    $id = param_require('id');

    $researcher = db_get_record('researchers', array('id' => $id));
    if ($researcher) {
        if ($action == 'remove') {
            db_delete_record('researchers', array('id' => $id));
            db_delete_record('research_researchers', array('researcher' => $id));
        }
    }

    redirect(url('/editor/researchers.php')); exit;
}

$mode = param_optional('mode', 'new');

$defaultNameTH = '';
$defaultNameEN = '';

$panelStyle = 'primary';
if ($mode == 'new') {
    $panelStyle = 'success';

    echo open_tag('ul');
    $researchers = db_get_records_array('researchers', array(), 'name_th', SORT_ASC);
    foreach ($researchers as $researcher) {
        echo wrap_tag('li',
            html_button(url('/editor/researchers.php?mode=edit&id=' . $researcher->id), 'แก้ไข', 'default', 'xs')
            . html_button(url('/editor/researchers.php?action=remove&id=' . $researcher->id), 'ลบ', 'danger', 'xs', 'แน่ใจหรือไม่ว่าต้องการลบ?')
            . ' ' . $researcher->name_th . ' / ' . $researcher->name_en);
    }
    echo close_tag('ul');
} else {
    $id = param_require('id');
    $researcher = db_get_record('researchers', array('id' => $id));

    if (!$researcher) {
        http_response_code(404); exit;
    }

    $defaultNameTH = $researcher->name_th;
    $defaultNameEN = $researcher->name_en;
}

?>
    <hr>
    <form action="researchers.php" method="post">
        <?php
        if (param_sent('submit')) {
            $name_th = param_require('name_th');
            $name_en = param_require('name_en');

            if (trim($name_th) == '' || trim($name_en) == '') {
                $error = 'กรุณากรอกข้อมูลให้ครบ';
            } else {
                if ($mode == 'new') {
                    $researcher = new stdClass();
                    $researcher->id = 0;
                    $researcher->name_th = $name_th;
                    $researcher->name_en = $name_en;
                    $newID = db_insert_record('researchers', $researcher);
                    if (!$newID) {
                        $error = 'ไม่สามารถเพิ่มได้';
                    } else {
                        redirect(url('/editor/researchers.php')); exit;
                    }
                } else if ($mode == 'edit') {
                    $researcher->name_th = $name_th;
                    $researcher->name_en = $name_en;

                    if (!db_update_records('researchers', $researcher)) {
                        $error = 'ไม่สามารถแก้ไขได้';
                    }
                }
            }

            if (!isset($error)) {
                redirect(url('/editor/researchers.php')); exit;
            }
        }
        ?>
        <div class="panel panel-<?php echo $panelStyle; ?>">
            <div class="panel-heading"><?php echo $mode == 'new' ? 'เพิ่มนักวิจัยใหม่' : 'แก้ไขนักวิจัย ' . $defaultNameTH; ?></div>
            <div class="panel-body">
                <?php
                if (isset($error)) {
                    echo alert_error($error);
                }
                ?>
                <div class="row">
                    <div class="col-md-6">
                        <div class="input-group">
                            <span class="input-group-addon">ชื่อนักวิจัย (ภาษาไทย)</span>
                            <input type="text" name="name_th" title="ชื่อประเภท (ภาษาไทย)" class="form-control" value="<?php echo $defaultNameTH; ?>">
                        </div>
                        <div class="input-group">
                            <span class="input-group-addon">ชื่อนักวิจัย (ภาษาอังกฤษ)</span>
                            <input type="text" name="name_en" title="ชื่อประเภท (ภาษาอังกฤษ)" class="form-control" value="<?php echo $defaultNameEN; ?>">
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel-footer">
                <button type="submit" class="btn btn-<?php echo $panelStyle; ?>"><?php echo $mode == 'new' ? 'เพิ่ม' : 'แก้ไข'; ?></button>
                <?php
                echo open_tag('input', array('type' => 'hidden', 'name' => 'mode', 'value' => $mode));
                if ($mode == 'edit') {
                    echo open_tag('input', array('type' => 'hidden', 'name' => 'id', 'value' => $researcher->id));
                    echo wrap_tag('a', 'ยกเลิก', array('href' => url('/editor/researchers.php')));
                }
                ?>
            </div>
        </div>
        <input type="hidden" name="submit" value="1">
    </form>
<?php

editor_render_footer();