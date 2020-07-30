<?php define('BMEI_WWW', 1);
include_once(__DIR__ . '/../lib.inc.php');
authentication_required();

editor_render_header();

$mode = param_optional('mode', 'new');
$id = param_optional('id', 0);
$accounts = array();
$error = false;

$currentAccount = new stdClass();

if (param_sent('submit')) {
    $account = new stdClass();
    $account->id = param_require('id');
    $account->username = param_require('username');
    $account->display_name = param_require('display_name');

    $password = param_require('password');
    $password_confirmation = param_require('password_confirmation');

    if (trim($account->username) == '' || trim($account->display_name) == '') {
        $error = 'กรุณากรอกข้อมูลให้ครบ';
    } else if ($password != $password_confirmation) {
        $error = 'รหัสผ่านยืนยันไม่ตรงกัน';
    } else if ($account->id) {
        if ($password != '') {
            $account->password = password_hash($password, PASSWORD_BCRYPT);
        }

        if (!db_update_records('accounts', $account)) {
            $error = 'ไม่สามารถแก้ไขข้อมูลได้';
        }
    } else {
        if ($password == '') {
            $error = 'กรุณากรอกรหัสผ่าน';
        } else {
            $account->password = password_hash($password, PASSWORD_BCRYPT);

            if (!db_insert_record('accounts', $account)) {
                $error = 'ไม่สามารถเพิ่มข้อมูลได้';
            }
        }
    }

    if (!$error) {
        redirect(url('/editor/accounts.php')); exit;
    }

    $currentAccount = $account;
} else if (param_sent('action')) {
    $action = param_require('action');

    if ($action == 'remove') {
        $id = param_require('id');
        if ($id == $SESSION['editor']->id) {
            $error = 'ไม่สามารถลบบัญชีปัจุบันได้ ให้ลบจากบัญชีอื่น';
        } else {
            db_delete_record('accounts', ['id' => $id]);
            redirect(url('/editor/accounts.php'));
        }
    } else {
        http_response_code(400); exit;
    }
}

if ($id) {
    $mode = 'edit';
    $currentAccount = db_get_record('accounts', ['id' => $id]);
    if (!$currentAccount) {
        http_response_code(404); exit;
    }
} else {
    if (!$error) {
        $currentAccount->id = 0;
        $currentAccount->username = '';
        $currentAccount->display_name = '';
    }

    $accounts = db_get_records_array('accounts', [], 'display_name', SORT_ASC);
}

$smarty->assign('mode', $mode);
$smarty->assign('accounts', $accounts);
$smarty->assign('error', $error);
$smarty->assign('currentAccount', $currentAccount);
$smarty->assign('id', $id);

$smarty->display('editor/accounts.tpl');

editor_render_footer();