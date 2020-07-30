<?php defined('BMEI_WWW') or die();

function str($name, $vars = array(), $lang = false)
{
    global $SESSION, $STRING;

    if (!$lang) {
        $lang = $SESSION['language'];
    }

    if (!isset($STRING)) {
        include(__DIR__ . "/../strings/{$lang}.inc.php");
    }

    if (!isset($STRING[$name])) {
        return "[[{$name}]]";
    }

    $str = $STRING[$name];
    foreach ($vars as $index => $var) {
        $str = str_replace("[{$index}]", $var, $str);
    }

    return $str;
}

function preview_text($text, $length)
{
    $subStr = mb_substr($text, 0, $length);
    if (mb_strlen($text) > $length) {
        $subStr .= '…';
    }

    return $subStr;
}

function document_type($type_value) {
    switch ($type_value) {
        case DOCUMENT_ANNOUNCEMENT: return 'ประกาศ';
        case DOCUMENT_INSTITUTE_COMMAND: return 'คำสั่งสถาบัน';
        case DOCUMENT_UNIVERSITY_COMMAND: return 'คำสั่งมหาวิทยาลัย';

        case REPORT_DIRECTOR_BOARD: return 'การประชุมกรรมการอำนวยการ';
        case REPORT_MANAGER_BOARD: return 'การประชุมกรรมการบริหาร';
        case REPORT_MANAGER: return 'การประชุมคณะผู้บริหาร';
    }

    return 'ไม่มี';
}
