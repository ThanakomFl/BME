<?php defined('BMEI_WWW') || die();

function get_news_image($newsObj)
{
    global $SESSION;

    $image = db_get_record_sql('SELECT * FROM news_files WHERE news = ? AND image = 1 ORDER BY id ASC LIMIT 1', [$newsObj->id]);
    if ($image) {
        $image->description = $image->{'description_' . $SESSION['language']};
    }

    return $image;
}