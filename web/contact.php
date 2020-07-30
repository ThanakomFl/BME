<?php define('BMEI_WWW', 1);
include_once(__DIR__ . '/lib.inc.php');

$SECTION = 'menu_contact';

$contact = [
    'address' => get_text('address'),
    'email' => get_text('email'),
    'tel' => get_text('tel'),
    'fax' => get_text('fax'),
    'facebook_name' => get_text('facebook_name'),
    'facebook_url' => get_text('facebook_url'),
    'twitter' => get_text('twitter'),
    'instagram' => get_text('instagram'),
    'youtube_url' => get_text('youtube_url'),
    'youtube_name' => get_text('youtube_name'),
    'line_ad' => get_text('line_ad')
];

render_header(str('contact'));

$smarty->assign('contact', $contact);
$smarty->display('contact.tpl');

render_footer();