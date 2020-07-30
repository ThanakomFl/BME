<?php defined('BMEI_WWW') or die();

function account_create($username, $password, $display_name)
{
    $account = new stdClass();
    $account->id = 0;
    $account->username = $username;
    $account->password = password_hash($password, PASSWORD_BCRYPT);
    $account->display_name = $display_name;

    if (db_insert_record('accounts', $account)) {
        return true;
    }
    return false;
}

function account_validate($username, $password)
{
    global $SESSION;

    $account = db_get_record('accounts', array('username' => $username));
    if ($account && password_verify($password, $account->password)) {
        $SESSION['editor'] = $account;

        return true;
    }

    return false;
}

function account_sign_out()
{
    global $SESSION;
    $SESSION['editor'] = null;
}

function is_authenticated()
{
    global $SESSION;
    if(isset($SESSION['editor']) && $SESSION['editor']->id) {
        return true;
    }

    return false;
}

function authentication_required()
{
    if (!is_authenticated()) {
        redirect(url('/'));
    }
}

function editor_render_header($components = array())
{
    global $smarty, $COMPONENTS;

    $COMPONENTS = $components;

    $smarty->assign('COMPONENTS', $COMPONENTS);
    $smarty->display('editor/default/header.tpl');
}

function editor_render_footer()
{
    global $smarty;

    $smarty->display('editor/default/footer.tpl');
}

function research_render_header($section = '')
{
    $items = array(
        'categories' => array('url' => url('/editor/research_categories.php'), 'title' => 'จัดการหมวดหมู่งานวิจัย'),
        'researches' => array('url' => url('/editor/researches.php'), 'title' => 'จัดการงานวิจัย'),
        'organizations' => array('url' => url('/editor/research_organizations.php'), 'title' => 'จัดการหน่วยงานวิจัย'),
        'researchers' => array('url' => url('/editor/researchers.php'), 'title' => 'จัดการรายชื่อนักวิจัย')
    );

    render_tabs($items, $section);
}

function degree_render_header($section = '')
{
    $items = [
        'degrees' => ['url' => url('/editor/degrees.php'), 'title' => 'จัดการหลักสูตร'],
        'courses' => ['url' => url('/editor/courses.php'), 'title' => 'จัดการกระบวนวิชา']
    ];

    render_tabs($items, $section);
}

function render_tabs($items, $selected_section = '')
{
    echo open_tag('ul', array('class' => 'nav nav-tabs', 'style' => 'margin-top: 20px;'));
    foreach ($items as $key => $item) {
        echo wrap_tag('li',
            wrap_tag('a', $item['title'], array('href' => $item['url'])),
            array('class' => ($key == $selected_section ? 'active' : '')));
    }
    echo close_tag('ul');
}

function editor_fix_jpeg_orientation($filePath)
{
    $image = imagecreatefromjpeg($filePath);
    $exif = exif_read_data($filePath);

    if (!isset($exif['Orientation']) || !$exif['Orientation']) {
        return;
    }

    switch ($exif['Orientation']) {
        case 3:
            $image = imagerotate($image, 180, 0);
            break;
        case 6:
            $image = imagerotate($image, -90, 0);
            break;
        case 8:
            $image = imagerotate($image, 90, 0);
            break;
    }

    imagejpeg($image, $filePath);
}

function editor_add_file($upload_name, $with_key = false)
{
    global $CONFIG;

    if (!isset($_FILES[$upload_name])) {
        return false;
    }

    $upload_file = $_FILES[$upload_name];

    if ($upload_file['error'] != UPLOAD_ERR_OK) {
        return false;
    }

    if (!file_exists($upload_file['tmp_name'])) {
        return false;
    }

    $file = new stdClass();
    $file->id = 0;
    $file->name = $upload_file['name'];
    $file->type = $upload_file['type'];
    $file->size = $upload_file['size'];
    $file->uploaded_dt = time();
    $file->access_key = $with_key ? generate_key() : null;

    if ($file->type == 'image/jpeg' || $file->type == 'image/jpg') {
        editor_fix_jpeg_orientation($upload_file['tmp_name']);
        $file->size = filesize($upload_file['tmp_name']);
    }

    $id = db_insert_record('files', $file);
    if (!$id) {
        return false;
    }

    if (!copy($upload_file['tmp_name'], $CONFIG['upload_path'] . '/' . $id)) {
        db_delete_record('files', array('id' => $id));
        return false;
    }

    return $id;
}

function editor_remove_file($fileID)
{
    global $CONFIG;

    $file = db_get_record('files', array('id' => $fileID));

    if (!$file) {
        return false;
    }

    $filePath = $CONFIG['upload_path'] . '/' . $file->id;
    if (!file_exists($filePath)) {
        return false;
    }

    unlink($filePath);
    return db_delete_record('files', array('id' => $file->id));
}

function get_date_timestamp($dateStr)
{
    if (!$dateStr || trim($dateStr) == '') {
        return null;
    }

    $explodedDate = explode('/', $dateStr);
    if (count($explodedDate) != 3) {
        return null;
    }

    return DateTime::createFromFormat('d/m/Y H:i:s', $dateStr . ' 00:00:00')->getTimestamp();
}

function get_time_timestamp($timeStr) {
    if (!$timeStr || trim($timeStr) == '') {
        return null;
    }

    $explodedTime = explode(':', $timeStr);
    foreach ($explodedTime as $time) {
        if (!is_numeric($time)) {
            return null;
        }
    }

    if (count($explodedTime) == 2) {
        return ($explodedTime[0] * 3600)
            + ($explodedTime[1] * 60);
    } else if (count($explodedTime) == 3) {
        return ($explodedTime[0] * 3600)
            + ($explodedTime[1] * 60)
            + ($explodedTime[2]);
    }
    return null;
}

function editor_reorder($tableName, $fieldName = 'sequence')
{
    $i = 1;
    $reorderObjs = db_get_records_array($tableName, [], $fieldName, SORT_ASC);
    foreach ($reorderObjs as $reorderObj) {
        $reorderObj->sequence = $i++;
        db_update_records($tableName, $reorderObj);
    }
}
