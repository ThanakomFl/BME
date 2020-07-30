<div id="home">
    {if count($slideShows) > 0}
        <div class="slider">
            <div class="about-slider">
                <div id="carousel-slider" class="carousel slide" data-ride="carousel">
                    <ol class="carousel-indicators visible-xs">
                        {foreach $slideShows as $index => $slideShow}
                            <li data-target="#carousel-slider" data-slide-to="{$index}" {if $index == 0}class="active"{/if}>
                            </li>
                        {/foreach}
                    </ol>

                    <div class="carousel-inner">
                        {foreach $slideShows as $index => $slideShow}
                            <div class="item{if $index == 0} active{/if}">
                                <a href="{($slideShow->url && trim($slideShow->url) != '') ? $slideShow->url : file_url($slideShow->image)}" target="_blank">
                                    <img src="{file_url($slideShow->image)}" class="img-responsive" align="">
                                </a>
                            </div>
                        {/foreach}
                    </div>

                    {if count($slideShows) > 1}
                        <a class="left carousel-control hidden-xs" href="#carousel-slider" data-slide="prev"><i class="fa fa-angle-left"></i></a>
                        <a class="right carousel-control hidden-xs" href="#carousel-slider" data-slide="next"><i class="fa fa-angle-right"></i></a>
                    {/if}
                </div>
            </div>
        </div>
        <hr>
    {/if}
</div>

{if count($slideShows) == 0}
    <div style="margin-top: 100px">&nbsp;</div>
{/if}

<section>
    <div class="container">
        <h3>{str('page_title')}</h3>
        <div class="row">
            <div class="col-md-10 col-md-offset-1">
                <p style="text-align: {str('text_align')};">{get_text('home_about')}</p>
            </div>
        </div>
    </div>
</section>

<hr>

<section id="features">
    <div class="container">
        <h3>ข่าวประกาศ</h3>
        <div class="row">
            <div class="container">
                <a href="{url('/news.php')}?category={constant('NEWS_ANNOUNCEMENT')}" class="btn btn-default">{str('menu_news_announcement')}</a>
                <a href="{url('/news.php')}?category={constant('NEWS_RESEARCH')}" class="btn btn-default">{str('menu_news_research')}</a>
                <a href="{url('/news.php')}?category={constant('NEWS_PROJECT')}" class="btn btn-default">{str('menu_news_project')}</a>
                <a href="{url('/news.php')}?category={constant('NEWS_JOBS')}" class="btn btn-default">{str('menu_news_jobs')}</a>
            </div>
        </div>
        <div class="row" style="display: flex; flex-wrap: wrap;">
            {foreach $newsArr as $newsObj}
                <div class="news news-item col-md-4" style="display: flex; flex-direction: column;">
                    <h3><a href="{url('/read.php')}?id={$newsObj->id}">{$newsObj->title}</a></h3>
                    {if $newsObj->image}
                        <div style="height: 150px; text-align: center;">
                            <img src="{file_url($newsObj->image->file)}" alt="{$newsObj->image->description}" style="height: 100%; width: auto;">
                        </div>
                    {/if}
                    <p>
                        {$newsObj->detail}
                        <a href="{url('/read.php')}?id={$newsObj->id}" style="white-space: nowrap;">{str('read_more')} <i class="fa fa-chevron-right"></i></a>
                    </p>
                </div>
            {foreachelse}
                <div class="news" style="margin: 20px;">
                    {str('news_none')}
                </div>
            {/foreach}
        </div>
    </div>
</section>
