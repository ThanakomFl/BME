<?php defined('BMEI_WWW') or die();

function open_tag($tagName, $attributes = array())
{
    $str = "<{$tagName}";
    foreach ($attributes as $name => $value) {
        $str .= " {$name}=\"{$value}\"";
    }
    $str .= '>';

    return $str;
}

function close_tag($tagName)
{
    return "</{$tagName}>";
}

function wrap_tag($tagName, $innerHTML = '', $attrbutes = array())
{
    $str = open_tag($tagName, $attrbutes);
    $str .= $innerHTML;
    $str .= close_tag($tagName);

    return $str;
}

function html_button($href, $text, $style = 'default', $size = false, $confirm_message = false)
{
    $attr = array('href' => $href, 'class' => "btn btn-{$style}");
    if ($confirm_message) {
        $attr['onclick'] = "return confirm('{$confirm_message}');";
    }

    if ($size) {
        $attr['class'] .= " btn-{$size}";
    }
    return wrap_tag('a', $text, $attr);
}

function html_dropdown($title, $name, $objArr, $textKey, $valueKey, $attr = array(), $selectedValue = false)
{
    $attr['title'] = $title;
    $attr['name'] = $name;

    $str = open_tag('select', $attr);
    foreach ($objArr as $obj) {
        $text = isset($obj->$textKey) ? $obj->$textKey : '';
        $value = isset($obj->$valueKey) ? $obj->$valueKey : '';
        $optAttr = array('value' => $value);

        if ($selectedValue && $selectedValue == $value) {
           $optAttr['selected'] = 'selected';
        }
        $str .= wrap_tag('option', $text, $optAttr);
    }
    $str .= close_tag('select');

    return $str;
}

function append_version($path) {
    global $VERSION;
    if (strpos($path, '?')) {
        return $path . '&v=' . $VERSION;
    }

    return $path . '?v=' . $VERSION;
}

function include_js($path, $type = PATH_INTERNAL)
{
    $path = append_version($path);
    echo wrap_tag('script', '', array('src' => url($path, $type)));
}

function include_css($path, $type = PATH_INTERNAL)
{
    $path = append_version($path);
    echo open_tag('link', array(
        'href' => url($path, $type),
        'rel' => 'stylesheet'
    ));
}

function render_header($title = false, $editor = false, $properties = [])
{
    global $SESSION, $SECTION, $REQUEST_URL, $smarty;

    if ($editor) {
        $menu = array('/index.php' => array('section' => 'menu_index'));
    } else {
        $menu = array(
            '/index.php' => array('section' => 'menu_index'),
            '/about.php' => array(
                'section' => 'menu_about',
                'subs' => array(
                    '/about.php' => 'menu_about',
                    '/staffs.php' => 'menu_staff',
                    '/structure.php' => 'menu_structure'
                ),
                'translate_sub' => true
            ),
            '/researches.php' => array(
                'section' => 'menu_research',
                'subs' => array(),
                'translate_sub' => false
            ),
            '/degrees.php' => array('section' => 'menu_curriculum'),
            '/news.php' => array(
                'section' => 'menu_news',
                'subs' => array(
                    '/news.php?category=' . NEWS_ANNOUNCEMENT => 'menu_news_announcement',
                    '/news.php?category=' . NEWS_RESEARCH => 'menu_news_research',
                    '/news.php?category=' . NEWS_PROJECT => 'menu_news_project',
                    '/news.php?category=' . NEWS_JOBS => 'menu_news_jobs'
                ),
                'translate_sub' => true
            ),
            '/contact.php' => array('section' => 'menu_contact'),
            '/switch_language.php?return_url=' . base64_encode($REQUEST_URL) => array('section' => 'menu_switch_language')
        );

        $propName = "title_{$SESSION['language']}";
        $researchCategories = db_get_records_array('research_categories', [], $propName, SORT_ASC);
        foreach ($researchCategories as $category) {
            $menu['/researches.php']['subs']['/researches.php?category=' . $category->id] = $category->$propName;
        }
    }

    $smarty->assign('SESSION', $SESSION);
    $smarty->assign('TITLE', $title);
    $smarty->assign('MENU', $menu);
    $smarty->assign('SECTION', $SECTION);
    $smarty->assign('PROPERTIES', $properties);

    $smarty->display('default/header.tpl');
}

function render_footer()
{
    global $smarty;
    $smarty->display('default/footer.tpl');
}

function alert_error($message)
{
    return wrap_tag('div', '<i class=\'fa fa-times-o\'></i>' . $message, array('class' => 'alert alert-danger'));
}

function upload_image_html($fileID, $attr = array())
{
    $attr = array_merge($attr, array('src' => file_url($fileID)));
    return open_tag('img', $attr);
}