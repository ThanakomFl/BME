<?php session_start();
defined('BMEI_WWW') or die();

include_once(__DIR__ . '/version.inc.php');

include_once(__DIR__ . '/config.inc.php');
include_once(__DIR__ . '/libs/const.inc.php');
include_once(__DIR__ . '/libs/date.inc.php');
include_once(__DIR__ . '/libs/document.inc.php');
include_once(__DIR__ . '/libs/db.inc.php');
include_once(__DIR__ . '/libs/editor.inc.php');
include_once(__DIR__ . '/libs/general.inc.php');
include_once(__DIR__ . '/libs/language.inc.php');
include_once(__DIR__ . '/libs/news.inc.php');
include_once(__DIR__ . '/libs/renderer.inc.php');
include_once(__DIR__ . '/libs/string.inc.php');
include_once(__DIR__ . '/libs/text.inc.php');
include_once(__DIR__ . '/libs/staff.inc.php');

include_once(__DIR__ . '/libs/smarty/Smarty.class.php');

$CONNECTION = mysqli_connect(
    $CONFIG['mysql_host'],
    $CONFIG['mysql_username'],
    $CONFIG['mysql_password'],
    $CONFIG['mysql_database'],
    $CONFIG['mysql_port'] ? $CONFIG['mysql_port'] : null);

if (!$CONNECTION) {
    echo 'ไม่สามารถเชื่อมต่อฐานข้อมูลได้';
    exit;
}
mysqli_query($CONNECTION, 'SET CHARSET UTF8');

date_default_timezone_set('Asia/Bangkok');

$SESSION = &$_SESSION[$CONFIG['session_name']];

if (!isset($SESSION)) {
    $SESSION = array();
}

load_user_language();

$REQUEST_URL = (isset($_SERVER['HTTPS']) ? "https" : "http") . "://{$_SERVER['HTTP_HOST']}{$_SERVER['REQUEST_URI']}";

$smarty = new smarty();
$smarty->setTemplateDir($CONFIG['template_path']);
$smarty->setCompileDir($CONFIG['upload_path'] . '/smarty_complies');