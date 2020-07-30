<?php define('BMEI_WWW', 1);
include_once(__DIR__ . '/../lib.inc.php');
authentication_required();

authentication_required();

editor_render_header(['datepicker']);

research_render_header('researches');

echo wrap_tag('h3', 'งานวิจัย');

if (param_sent('submit')) {
    $research = new stdClass();
    $research->id = param_require('id');
    $research->title_th = param_require('title_th');
    $research->title_en = param_require('title_en');
    $research->category = param_require('category');
    $research->organization = param_require('organization');
    $research->start_dt = get_date_timestamp(param_optional('start_dt', null));
    $research->end_dt = get_date_timestamp(param_optional('end_dt', null));
    $research->budget_th = param_optional('budget_th', null);
    $research->budget_en = param_optional('budget_en', null);
    $research->budget_amount = param_require('budget_amount');
    $research->abstract_th = param_optional('abstract_th', null);
    $research->abstract_en = param_optional('abstract_en', null);
    $research->visible = param_optional('visible', 0);

    $researchers = param_optional('researchers', []);

    if(trim($research->title_th) == '' || trim($research->title_en) == ''
    || !$research->category || !$research->organization) {
        $error = 'กรุณากรอกข้อมูลให้ครบ';
    } else if (!$research->id) {
        $research->id = 0;
        $newID = db_insert_record('researches', $research);

        if (!$newID) {
            $error = 'ไม่สามารถเพิ่มได้';
        }

        foreach ($researchers as $researcherID) {
            $researchResearcher = new stdClass();
            $researchResearcher->id = 0;
            $researchResearcher->research = $newID;
            $researchResearcher->researcher = $researcherID;

            db_insert_record('research_researchers', $researchResearcher);
        }

        if (!isset($error)) {
            redirect(url('/editor/researches.php', PATH_INTERNAL, array('category' => $research->category))); exit;
        }
    } else if ($research->id) {
        db_update_records('researches', $research);
        db_delete_record('research_researchers', array('research' => $research->id));

        foreach ($researchers as $researcherID) {
            $researchResearcher = new stdClass();
            $researchResearcher->id = 0;
            $researchResearcher->research = $research->id;
            $researchResearcher->researcher = $researcherID;

            db_insert_record('research_researchers', $researchResearcher);
        }

        redirect(url('/editor/researches.php', PATH_INTERNAL, array('category' => $research->category))); exit;
    }

    reload(); exit;
} else if (param_sent('action')) {
    $action = param_require('action');

    if ($action == 'remove') {
        $id = param_require('id');

        db_delete_record('research_researchers', ['research' => $id]);
        db_delete_record('researches', ['id' => $id]);

        redirect(url('/editor/researches.php'));
    }
}

$selectedCategory = param_optional('category', 0);
$keyword = param_optional('keyword', false);

$mode = 'new';
$style = 'success';
$research = new stdClass();
$research->id = 0;
$research->title_th = '';
$research->title_en = '';
$research->category = '';
$research->organization = '';
$research->start_dt = '';
$research->end_dt = '';
$research->budget_th = '';
$research->budget_en = '';
$research->budget_amount = '';
$research->abstract_th = '';
$research->abstract_en = '';
$research->visible = 1;
$selectedResearcherIDs = array();
if (param_sent('id')) {
    $mode = 'edit';
    $style = 'primary';
    $id = param_require('id');
    $research = db_get_record('researches', array('id' => $id));
    $research->start_dt = is_null($research->start_dt) ? '' : date('d/m/Y', $research->start_dt);
    $research->end_dt = is_null($research->end_dt) ? '' : date('d/m/Y', $research->end_dt);
    $selectedCategory = $research->category;
    $keyword = $research->title_th;
    if (!$research) {
        http_response_code(404); exit;
    }

    foreach (db_get_records_array('research_researchers', array('research' => $research->id)) as $researchResearcher) {
        array_push($selectedResearcherIDs, $researchResearcher->researcher);
    }
}

$categories = db_get_records_array('research_categories', array(), 'id');

$default = new stdClass();
$default->id = 0;
$default->title_th = 'ทั้งหมด';
$default->title_en = 'ทั้งหมด';

$searchCategories = array_merge(array($default), $categories);

echo open_tag('div', array('class' => 'row'));
echo open_tag('div', array('class' => 'col-md-6'));

echo open_tag('form', array('action' => url('/editor/researches.php'), 'method' => 'get'));
echo open_tag('div', array('class' => 'input-group', 'style' => 'margin-bottom: 10px;'));
echo wrap_tag('span', 'ค้นหา', array('class' => 'input-group-addon'));
echo html_dropdown('ประเภท', 'category', $searchCategories, 'title_th', 'id', array('class' => 'form-control'), $selectedCategory);
echo open_tag('input', array('name' => 'keyword', 'title' => 'keyword', 'class' => 'form-control', 'placeholder' => 'ค้นชื่องานวิจัย', 'value' => $keyword));
echo wrap_tag('span', '<button type="submit" class="btn btn-success"><i class="fa fa-search"></i> ค้นหา</button>', array('class' => 'input-group-addon'));
echo close_tag('div');
echo close_tag('form');

$params = array();
$sql = 'SELECT * FROM researches';
if ($selectedCategory || $keyword) {
    $sql .= ' WHERE ';
}
if ($selectedCategory) {
    $sql .= 'category = ? ';
    array_push($params, $selectedCategory);
}
if ($selectedCategory && $keyword) {
    $sql .= 'AND ';
}
if ($keyword) {
    $keyword = trim($keyword);
    $keyword = "%{$keyword}%";
    $sql .= '(title_th LIKE ? OR title_en LIKE ?)';
    array_push($params, $keyword);
    array_push($params, $keyword);
}
$sql .= ' ORDER BY title_th ASC';

$researchResults = db_get_records_sql($sql, $params);
if (count($researchResults) == 0) {
    echo '- ไม่พบงานวิจัย -';
} else {
    echo open_tag('ul');
    foreach ($researchResults as $researchResult) {
        echo wrap_tag('li', html_button(url('/editor/researches.php?id=' . $researchResult->id), 'แก้ไข', 'default', 'xs') . ' ' . $researchResult->title_th . ' / ' . $researchResult->title_en);
    }
    echo close_tag('ul');
}

echo close_tag('div');

?>
<div class="col-md-6">
    <form action="researches.php" method="post" enctype="application/x-www-form-urlencoded">
        <div class="panel panel-<?php echo $style; ?>">
            <div class="panel-heading"><?php echo $mode == 'new' ? 'เพิ่มงานวิจัยใหม่' : 'แก้ไขงานวิจัย ' . html_button(url('/editor/researches.php'), 'ยกเลิก', 'default', 'xs'); ?></div>
            <div class="panel-body">
                <?php
                if (isset($error)) {
                    echo alert_error($error);
                }
                ?>
                <div class="input-group">
                    <span class="input-group-addon">ชื่องานวิจัย (ภาษาไทย)</span>
                    <input type="text" name="title_th" title="ชื่องานวิจัย (ภาษาไทย)" class="form-control" style="font-weight: bold;" value="<?php echo $research->title_th; ?>">
                </div>
                <div class="input-group">
                    <span class="input-group-addon">ชื่องานวิจัย (ภาษาอังกฤษ)</span>
                    <input type="text" name="title_en" title="ชื่องานวิจัย (ภาษาอังกฤษ)" class="form-control" style="font-weight: bold;" value="<?php echo $research->title_en; ?>">
                </div>
                <div class="input-group">
                    <span class="input-group-addon">ประเภทงานวิจัย</span>
                    <?php echo html_dropdown('ประเภทงานวิจัย', 'category', db_get_records_array('research_categories', array(), 'id'), 'title_th', 'id', array('class' => 'form-control'), $research->category); ?>
                </div>
                <div class="input-group">
                    <span class="input-group-addon">หน่วยงานวิจัย</span>
                    <?php echo html_dropdown('หน่วยงานวิจัย', 'organization', db_get_records_array('research_organizations', array(), 'name_th'), 'name_th', 'id', array('class' => 'form-control'), $research->organization); ?>
                </div>
                <div class="input-group">
                    <span class="input-group-addon">วันที่เริ่มงานวิจัย</span>
                    <input type="text" name="start_dt" title="วันที่เริ่มงานวิจัย" class="form-control" data-provide="datepicker" data-date-format="dd/mm/yyyy" data-date-language="th" value="<?php echo $research->start_dt; ?>">
                </div>
                <div class="input-group">
                    <span class="input-group-addon">วันที่สิ้นสุดงานวิจัย</span>
                    <input type="text" name="end_dt" title="วันที่สิ้นสุดงานวิจัย" class="form-control" data-provide="datepicker" data-date-format="dd/mm/yyyy" data-date-language="th" value="<?php echo $research->end_dt; ?>">
                </div>
                <div class="input-group">
                    <span class="input-group-addon">ชื่องบประมาณ (ภาษาไทย)</span>
                    <input type="text" name="budget_th" title="ชื่องานวิจัย (ภาษาอังกฤษ)" class="form-control" value="<?php echo $research->budget_th; ?>">
                </div>
                <div class="input-group">
                    <span class="input-group-addon">ชื่องบประมาณ (ภาษาอังกฤษ)</span>
                    <input type="text" name="budget_en" title="ชื่องานวิจัย (ภาษาอังกฤษ)" class="form-control" value="<?php echo $research->budget_en; ?>">
                </div>
                <div class="input-group">
                    <span class="input-group-addon">จำนวนเงิน (บาท)</span>
                    <input type="text" name="budget_amount" title="จำนวนเงิน (บาท)" class="form-control" value="<?php echo $research->budget_amount; ?>">
                </div>
                <div>
                    <strong>นักวิจัย</strong>
                    <?php
                    foreach (db_get_records_array('researchers', array(), 'name_th') as $researcher) {
                        $checkBoxAttrs = array('type' => 'checkbox', 'name' => 'researchers[]', 'value' => $researcher->id);
                        if (in_array($researcher->id, $selectedResearcherIDs)) {
                            $checkBoxAttrs['checked'] = 'checked';
                        }

                        echo open_tag('div', array('style' => 'margin: 0 0 0 20px;'));
                        echo wrap_tag('label',
                            open_tag('input', $checkBoxAttrs)
                            . ' ' . $researcher->name_th);
                        echo close_tag('div');
                    }
                    ?>
                </div>
                <div>
                    <textarea name="abstract_th" title="บทคัดย่อ (ภาษาไทย)" placeholder="บทคัดย่อ (ภาษาไทย)" style="height: 15em;" class="form-control"><?php echo $research->abstract_th; ?></textarea>
                    <textarea name="abstract_en" title="Abstract (English)" placeholder="Abstract (English)" style="height: 15em;" class="form-control"><?php echo $research->abstract_en; ?></textarea>
                </div>
                <div class="input-group">
                    <label class="input-group-addon">
                        <input type="checkbox" name="visible" value="1"<?php echo $research->visible ? ' checked' : ''; ?>>
                        แสดงผล
                    </label>
                </div>
            </div>
            <div class="panel-footer">
                <button type="submit" class="btn btn-<?php echo $style; ?>"><?php echo $mode == 'new' ? 'เพิ่ม' : 'แก้ไข'; ?></button>
                <?php
                if ($mode == 'edit') {
                    echo html_button(url('/editor/researches.php', PATH_INTERNAL, ['id' => $research->id, 'action' => 'remove']), 'ลบ', 'danger', 'xs', 'แน่ใจหรือไม่ว่าต้องการลบ');
                }
                ?>
            </div>
        </div>
        <input type="hidden" name="submit" value="1">
        <input type="hidden" name="id" value="<?php echo $research->id; ?>">
    </form>
</div>
<?php
echo close_tag('div');
editor_render_footer();