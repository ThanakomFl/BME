<?php define('BMEI_WWW', 1);
include_once(__DIR__ . '/../lib.inc.php');
authentication_required();

editor_render_header();

echo wrap_tag('h3', 'ข่าวประกาศ');

$category = param_optional('category', 0);

if (param_sent('action')) {
    $action = param_require('action');

    if ($action == 'new') {
        $news = new stdClass();
        $news->id = 0;
        $news->category = $category;
        $news->title_th = '';
        $news->title_en = '';
        $news->detail_th = '';
        $news->detail_en = '';
        $news->published_dt = time();
        $news->show_front = 0;
        $news->visible = 0;

        $newID = db_insert_record('news', $news);
        if ($newID) {
            redirect(url('/editor/news_edit.php', PATH_INTERNAL, array('id' => $newID)));
        } else {
            http_response_code(500); exit;
        }
    }

    http_response_code(400); exit;
}

$newsArr = array();
if ($category) {
    $newsArr = db_get_records_array('news', array('category' => $category), 'published_dt', SORT_DESC);
} else {
    $newsArr = db_get_records_array('news', array(), 'published_dt', SORT_DESC);
}

$smarty->assign('newsArr', $newsArr);
$smarty->assign('category', $category);

$smarty->display('editor/news.tpl');

editor_render_footer();