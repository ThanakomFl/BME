<?php define('BMEI_WWW', 1);
include_once(__DIR__ . '/lib.inc.php');

$SECTION = 'menu_index';
render_header();

$slideShows = db_get_records_array('slide_shows', array('visible' => 1), 'sequence', SORT_ASC);

$news = db_get_records_array('news', ['visible' => 1, 'show_front' => 1], 'published_dt', SORT_DESC);
foreach ($news as &$newsObj) {
    $newsObj->title = $newsObj->{'title_' . $SESSION['language']};
    $newsObj->detail = preview_text($newsObj->{'detail_' . $SESSION['language']}, 100);
    $newsObj->image = get_news_image($newsObj);
}
unset($newsObj);

include_js('/js/jquery-2.1.1.min.js');

$smarty->assign('slideShows', $slideShows);
$smarty->assign('newsArr', $news);

$smarty->display('index.tpl');

render_footer();
