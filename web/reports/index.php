<?php define('BMEI_WWW', 1);
include_once(__DIR__ . '/../lib.inc.php');

render_header('รายการเอกสาร');

$smarty->assign('mode', DOCUMENT_MODE_REPORT);
$smarty->display('documents.tpl');

include_js('/js/angular.min.js');
include_js('/js/angular-app.js');
include_js('/js/directives/documents.js');

render_footer();
