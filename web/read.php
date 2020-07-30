<?php define('BMEI_WWW', 1);
include_once(__DIR__ . '/lib.inc.php');

$SECTION = 'menu_news';

$id = param_require('id');
$news = db_get_record('news', ['id' => $id]);
if ($news && $news->visible) {
    $news->title = $news->{'title_' . $SESSION['language']};
    $news->detail = textarea_display($news->{'detail_' . $SESSION['language']});
    $news->published_date = date_thai(str('date_time_format'), $news->published_dt);
    $news->image = get_news_image($news);
} else if (!$news->visible) {
    $news = false;
}
$attachments = db_get_records_array('news_files', ['news' => $id, 'image' => 0]);
$images = db_get_records_array('news_files', ['news' => $id, 'image' => 1]);

foreach ($attachments as &$attachment) {
    $attachment->fileObj = db_get_record('files', ['id' => $attachment->file]);
}
unset($attachment);

foreach ($images as &$image) {
    $image->description = $image->{'description_' . $SESSION['language']};
}
unset($image);

$properties = $news && $news->visible ? [
    'og:url' => url('/read.php', PATH_INTERNAL, ['id' => $id]),
    'og:type' => 'website',
    'og:title' => $news->title,
    'og:description' => preview_text(strip_tags($news->detail), 200) . '…',
] : array();
if ($news && $news->image) {
    $properties['og:image'] = file_url($news->image->file);
    $properties['og:image:url'] = file_url($news->image->file);
    $properties['og:image:type'] = $news->image->type;
}

render_header($news ? $news->title : false, false, $properties);

$smarty->assign('news', $news);
$smarty->assign('attachments', $attachments);
$smarty->assign('images', $images);

$smarty->assign('jsFiles', [url('/js/read.js')]);

$smarty->display('read.tpl');

render_footer();