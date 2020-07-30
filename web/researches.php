<?php define('BMEI_WWW', 1);
include_once(__DIR__ . '/lib.inc.php');

$SECTION = 'menu_research';

$category = param_optional('category', 0);
$keyword = param_optional('keyword', '');

$categories = array();

$propName = "title_{$SESSION['language']}";
$defaultCategory = new stdClass();
$defaultCategory->id = 0;
$defaultCategory->title = str('category_all');
array_push($categories, $defaultCategory);
foreach (db_get_records_array('research_categories', array(), $propName, SORT_ASC) as $categoryObj) {
    $categoryObj->title = $categoryObj->$propName;
    array_push($categories, $categoryObj);
}

$titlePropName = "title_{$SESSION['language']}";
$researches = array();
if (trim($keyword) == '') {
    $condition = array('visible' => 1);
    if ($category) {
        $condition['category'] = $category;
    }

    $researches = db_get_records_array('researches', $condition, $titlePropName, SORT_ASC);
} else {
    $params = array();
    for ($i = 0; $i < 6; $i++) {
        array_push($params, "%{$keyword}%");
    }
    $sql = 'SELECT researches.*
      FROM researches
        JOIN research_organizations ON organization = research_organizations.id
      WHERE researches.visible = 1 AND ((title_th LIKE ? OR title_en LIKE ?
        OR research_organizations.name_th LIKE ? OR research_organizations.name_en LIKE ?
        OR EXISTS
          (SELECT * FROM researchers
            WHERE researchers.name_th LIKE ?
              OR researchers.name_en LIKE ?
              AND id IN (SELECT researcher FROM research_researchers WHERE research = researches.id)
          )
      ))';
    if ($category) {
        $sql .= ' AND category = ?';
        array_push($params, $category);
    }
    $sql .= ' ORDER BY ' . $titlePropName . ' ASC';

    $researches = db_get_records_sql($sql, $params);
    echo mysqli_error($CONNECTION);
}

$propName = "name_{$SESSION['language']}";
$propTitle = "title_{$SESSION['language']}";
foreach ($researches as &$research) {
    $research->name = $research->$propTitle;
    $research->category = db_get_record('research_categories', array('id' => $research->category));
    $research->category->name = $research->category->$propTitle;
    $research->organization = db_get_record('research_organizations', array('id' => $research->organization));
    $research->organization->name = $research->organization->$propName;

    $researchers = db_get_records_sql('SELECT * FROM researchers WHERE id IN (SELECT researcher FROM research_researchers WHERE research = ?)', array($research->id));
    $researcherNames = get_property_array($researchers, $propName);
    $research->researcherName = implode(', ', $researcherNames);
}
unset($research);

render_header(str('menu_research'));

$smarty->assign('HTMLCategoriesDropDown', html_dropdown(str('research_category'), 'category', $categories, 'title', 'id', array('class' => 'form-control'), $category));
$smarty->assign('keyword', $keyword);
$smarty->assign('researches', $researches);

$smarty->display('researches.tpl');

render_footer();