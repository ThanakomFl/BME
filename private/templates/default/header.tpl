<!DOCTYPE html>
<html lang="{$SESSION['language']}">
<head>
    <meta charset="utf-8">
    <meta name="description" content="{get_text('home_about')}">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    {foreach $PROPERTIES as $property => $content}
        <meta property="{$property}" content="{$content}">
    {/foreach}
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>{str('page_title')}{if $TITLE} - {$TITLE}{/if}</title>
    <link rel="stylesheet" type="text/css" href="{url('/css/bootstrap.min.css')}">
    <link rel="stylesheet" type="text/css" href="{url('/css/font-awesome.min.css')}">
    <link rel="stylesheet" type="text/css" href="{url('/css/animate.min.css')}">
    <link rel="stylesheet" type="text/css" href="{url('/css/animate.css')}">
    <link rel="stylesheet" type="text/css" href="{url('/css/prettyPhoto.css')}">
    <link rel="stylesheet" type="text/css" href="{url('/css/style.css')}">
    <!-- =======================================================
      Theme Name: OnePage
      Theme URL: https://bootstrapmade.com/onepage-multipurpose-bootstrap-template/
      Author: BootstrapMade
      Author URL: https://bootstrapmade.com
    ======================================================= -->
    <script>var WWW_ROOT = '{url('')}';</script>
</head>
<body>
<nav class="navbar navbar-default navbar-fixed-top">
    <div class="container">
        <div class="row">
            <div class="navbar-brand">
                <a href="{url('/')}">
                    <img alt="brand" src="{url("/images/logo-{$SESSION['language']}.png")}">
                </a>
            </div>
            <div class="site-logo">
                <div class="hidden-sm">
                    <a href="{url('/index.php')}" class="brand">{str('header_logo_side_top')}</a>
                </div>
                <small class="hidden-xs hidden-sm">{str('header_logo_side_bottom')}</small>
            </div>

            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#menu">
                    <i class="fa fa-bars"></i>
                </button>
            </div>

            <div class="collapse navbar-collapse" id="menu">
                <ul class="nav navbar-nav navbar-right">
                    {foreach $MENU as $url => $item}
                        <li class="{if $item['section'] == $SECTION}active{/if} {if isset($item['subs'])} dropdown{/if}">
                            <a href="{url($url)}" {if isset($item['subs'])}class="dropdown-toggle"{/if}>
                                {str($item['section'])}
                            </a>

                            {if isset($item['subs'])}
                                <ul class="dropdown-menu">
                                    {foreach $item['subs'] as $subUrl => $subMenu}
                                        <li>
                                            <a href="{url($subUrl)}">
                                                {if $item['translate_sub']}{str($subMenu)}{else}{$subMenu}{/if}
                                            </a>
                                        </li>
                                    {/foreach}
                                </ul>
                            {/if}
                        </li>
                    {/foreach}
                </ul>
            </div>
        </div>
    </div>
</nav>