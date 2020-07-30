<?php defined('BMEI_WWW') or die();

function get_text($id, $language = false)
{
    global $SESSION;
    if (!$language) {
        $language = $SESSION['language'];
    }

    $text = db_get_record('texts', array('id' => $id));
    if (!$text) {
        return '';
    }

    return $text->{'text_' . $language};
}