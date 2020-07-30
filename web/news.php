<?php define('BMEI_WWW', 1);
include_once(__DIR__ . '/lib.inc.php');

$SECTION = 'menu_news';

$category = param_optional('category', 0);

$news = [];
if ($category) {
    $news = db_get_records_array('news', ['visible' => 1, 'category' => $category], 'published_dt', SORT_DESC);
} else {
    $news = db_get_records_array('news', ['visible' => 1], 'published_dt', SORT_DESC);
}

foreach ($news as &$newsObj) {
    $newsObj->title = $newsObj->{'title_' . $SESSION['language']};
    $newsObj->detail = preview_text($newsObj->{'detail_' . $SESSION['language']}, 200);
    $newsObj->image = get_news_image($newsObj);
    $newsObj->published_date = date_str($newsObj->published_dt);
}
unset($newsObj);

$categoryTitle = '';
switch ($category) {
    case NEWS_ANNOUNCEMENT:
        $categoryTitle = str('menu_news_announcement'); break;
    case NEWS_RESEARCH:
        $categoryTitle = str('menu_news_research'); break;
    case NEWS_PROJECT:
        $categoryTitle = str('menu_news_project'); break;
    case NEWS_JOBS:
        $categoryTitle = str('menu_news_jobs'); break;
    default:
        $categoryTitle = str('menu_news');
}

render_header($categoryTitle, false);

$smarty->assign('categoryTitle', $categoryTitle);
$smarty->assign('newsArr', $news);

$smarty->display('news.tpl');

render_footer();