<?php define('BMEI_WWW', 1);
include_once(__DIR__ . '/lib.inc.php');

if (is_authenticated()) {
    redirect(url('/editor/index.php'));
}

render_header('ผู้ดูแล', true);

$incorrectLogIn = false;
if (param_sent('submit')) {
    $username = param_require('username');
    $password = param_require('password');

    if (account_validate($username, $password)) {
        redirect(url('/editor/index.php'));
        exit;
    }

    $incorrectLogIn = true;
}

$smarty->assign('incorrectLogIn', $incorrectLogIn);
$smarty->display('editor.tpl');

render_footer();