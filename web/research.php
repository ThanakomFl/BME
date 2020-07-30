<?php define('BMEI_WWW', 1);
include_once(__DIR__ . '/lib.inc.php');

$SECTION = 'menu_research';

$id = param_require('id');
$research = db_get_record('researches', array('id' => $id));
if (!$research || !$research->visible) {
    http_response_code(404); exit;
}

$LANGUAGE = $SESSION['language'];

$research->title = $research->{"title_{$LANGUAGE}"};

$category = db_get_record('research_categories', array('id' => $research->category));
$research->categoryName = $category ? $category->{"title_{$LANGUAGE}"} : '-';

$organization = db_get_record('research_organizations', array('id' => $research->organization));
$research->organizationName = $organization ? $organization->{"name_{$LANGUAGE}"} : '-';

$research->startDate = date_str($research->start_dt);
$research->endDate = date_str($research->end_dt);

$research->budgetName = $research->{"budget_{$LANGUAGE}"};
$research->budgetAmount = '฿' . number_format($research->budget_amount, 2, '.', ',');

$researchers = db_get_records_sql('SELECT * FROM researchers WHERE id IN (SELECT researcher FROM research_researchers WHERE research = ?)', array($research->id));
$researcherNames = get_property_array($researchers, "name_{$LANGUAGE}");
$research->author = implode(', ', $researcherNames);

$research->abstract = textarea_display($research->{"abstract_{$LANGUAGE}"});

render_header($research->title);

$smarty->assign('research', $research);
$smarty->display('research.tpl');

render_footer();