<?php define('BMEI_WWW', 1);
include_once(__DIR__ . '/../lib.inc.php');
authentication_required();

authentication_required();

editor_render_header();
research_render_header('organizations');

echo wrap_tag('h3', 'รายชื่อหน่วยงานวิจัย');

if (param_sent('action')) {
    $action = param_require('action');
    $id = param_require('id');

    $organization = db_get_record('research_organizations', array('id' => $id));
    if ($organization) {
        if ($action == 'remove') {
            db_delete_record('research_organizations', array('id' => $id));
            db_sql('UPDATE researches SET organization = 0 WHERE organization = ?', array($id));
        }
    }

    redirect(url('/editor/organizations.php')); exit;
}

$mode = param_optional('mode', 'new');

$defaultNameTH = '';
$defaultNameEN = '';

$panelStyle = 'primary';
if ($mode == 'new') {
    $panelStyle = 'success';

    echo open_tag('ul');
    $organizations = db_get_records_array('research_organizations', array(), 'name_th', SORT_ASC);
    foreach ($organizations as $organization) {
        echo wrap_tag('li',
            html_button(url('/editor/research_organizations.php?mode=edit&id=' . $organization->id), 'แก้ไข', 'default', 'xs')
            . html_button(url('/editor/research_organizations.php?action=remove&id=' . $organization->id), 'ลบ', 'danger', 'xs', 'แน่ใจหรือไม่ว่าต้องการลบ?')
            . ' ' . $organization->name_th . ' / ' . $organization->name_en);
    }
    echo close_tag('ul');
} else {
    $id = param_require('id');
    $organization = db_get_record('research_organizations', array('id' => $id));

    if (!$organization) {
        http_response_code(404); exit;
    }

    $defaultNameTH = $organization->name_th;
    $defaultNameEN = $organization->name_en;
}

?>
    <hr>
    <form action="research_organizations.php" method="post">
        <?php
        if (param_sent('submit')) {
            $name_th = param_require('name_th');
            $name_en = param_require('name_en');

            if (trim($name_th) == '' || trim($name_en) == '') {
                $error = 'กรุณากรอกข้อมูลให้ครบ';
            } else {
                if ($mode == 'new') {
                    $organization = new stdClass();
                    $organization->id = 0;
                    $organization->name_th = $name_th;
                    $organization->name_en = $name_en;
                    $newID = db_insert_record('research_organizations', $organization);
                    if (!$newID) {
                        $error = 'ไม่สามารถเพิ่มได้';
                    } else {
                        redirect(url('/editor/research_organizations.php')); exit;
                    }
                } else if ($mode == 'edit') {
                    $organization->name_th = $name_th;
                    $organization->name_en = $name_en;

                    if (!db_update_records('research_organizations', $organization)) {
                        $error = 'ไม่สามารถแก้ไขได้';
                    }
                }
            }

            if (!isset($error)) {
                redirect(url('/editor/research_organizations.php')); exit;
            }
        }
        ?>
        <div class="panel panel-<?php echo $panelStyle; ?>">
            <div class="panel-heading"><?php echo $mode == 'new' ? 'เพิ่มหน่วยงานใหม่' : 'แก้ไขหน่วยงาน ' . $defaultNameTH; ?></div>
            <div class="panel-body">
                <?php
                if (isset($error)) {
                    echo alert_error($error);
                }
                ?>
                <div class="row">
                    <div class="col-md-6">
                        <div class="input-group">
                            <span class="input-group-addon">ชื่อหน่วยงานวิจัย (ภาษาไทย)</span>
                            <input type="text" name="name_th" title="ชื่อหน่วยงานวิจัย (ภาษาไทย)" class="form-control" value="<?php echo $defaultNameTH; ?>">
                        </div>
                        <div class="input-group">
                            <span class="input-group-addon">ชื่อหน่วยงานวิจัย (ภาษาอังกฤษ)</span>
                            <input type="text" name="name_en" title="ชื่อหน่วยงานวิจัย (ภาษาอังกฤษ)" class="form-control" value="<?php echo $defaultNameEN; ?>">
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel-footer">
                <button type="submit" class="btn btn-<?php echo $panelStyle; ?>"><?php echo $mode == 'new' ? 'เพิ่ม' : 'แก้ไข'; ?></button>
                <?php
                echo open_tag('input', array('type' => 'hidden', 'name' => 'mode', 'value' => $mode));
                if ($mode == 'edit') {
                    echo open_tag('input', array('type' => 'hidden', 'name' => 'id', 'value' => $organization->id));
                    echo wrap_tag('a', 'ยกเลิก', array('href' => url('/editor/research_organizations.php')));
                }
                ?>
            </div>
        </div>
        <input type="hidden" name="submit" value="1">
    </form>
<?php

editor_render_footer();