<section style="padding-top: 150px;">
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-8 col-lg-offset-2">
                <h3>{$categoryTitle}</h3>

                {foreach $newsArr as $newsObj}
                    <div class="row news-item">
                        <div class="col-xs-2">
                            {if $newsObj->image}
                                <img src="{file_url($newsObj->image->file)}" alt="{$newsObj->image->description}" class="img-rounded" style="width: 100%; height: auto;">
                            {/if}
                        </div>
                        <div class="col-xs-10">
                            <h3 style="margin: 0;"><a href="{url('/read.php')}?id={$newsObj->id}">{$newsObj->title}</a></h3>
                            <small style="margin-left: 5px;"><i>{$newsObj->published_date}</i></small>
                            <p style="margin-top: 10px;">
                                {$newsObj->detail}
                            </p>
                            <div class="text-right">
                                <a href="{url('/read.php')}?id={$newsObj->id}">{str('read_more')} <i class="fa fa-chevron-right"></i></a>
                            </div>
                        </div>
                    </div>
                    <hr>
                {foreachelse}
                    <div class="alert alert-warning" style="text-align: center;">
                        {str('news_none')}
                    </div>
                {/foreach}
            </div>
        </div>
    </div>
</section>