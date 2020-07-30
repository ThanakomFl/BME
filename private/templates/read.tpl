{literal}
    <script>
        (function(d, s, id) {
            var js, fjs = d.getElementsByTagName(s)[0];
            if (d.getElementById(id)) return;
            js = d.createElement(s); js.id = id;
            js.src = "https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v3.0";
            fjs.parentNode.insertBefore(js, fjs);
        }(document, 'script', 'facebook-jssdk'));
    </script>
{/literal}
<section style="padding-top: 150px;">
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-8 col-lg-offset-2">
                {if $news}
                    <h3>{$news->title}</h3>
                    {if $PROPERTIES}
                        <div class="pull-right">
                            <div class="fb-share-button"
                                 data-href="{$PROPERTIES['og:url']}"
                                 data-layout="button">
                            </div>
                        </div>
                    {/if}
                    <small><i>{$news->published_date}</i></small>
                    {if $news->image}
                        <div class="text-center" style="height: 300px;">
                            <a href="{file_url($news->image->file)}" target="_blank">
                                <img src="{file_url($news->image->file)}" alt="{$news->image->description}" style="height: 100%; width: auto;" class="img-rounded">
                            </a>
                        </div>
                    {/if}
                    <p>
                        {$news->detail}
                    </p>
                    {if count($attachments) > 0 || count($images) > 0}<hr>{/if}
                    {if count($attachments) > 0}
                        <div style="margin: 20px 0;">
                            <div>
                                <strong><i class="fa fa-files-o"></i> {str('news_attachments')}</strong>
                            </div>
                            {foreach $attachments as $attachment}
                                <div style="margin-left: 20px;">
                                    <a href="{file_url($attachment->file)}" target="_blank"><i class="fa fa-file-o"></i> {$attachment->fileObj->name} <small>({display_file_size($attachment->fileObj->size)})</small></a>
                                </div>
                            {/foreach}
                        </div>
                    {/if}
                    {if count($images) > 0}
                        <div style="margin: 20px 0; display: flex; flex-wrap: wrap;" class="row">
                            <div style="width: 100%; margin-bottom: 10px;">
                                <strong><i class="fa fa-picture-o"></i> {str('news_images')}</strong>
                            </div>
                            {foreach $images as $index => $image}
                                <div class="col-lg-2 col-md-4 col-sm-6 col-xs-12" style="display: flex; flex-direction: column; margin-bottom: 20px;">
                                    <a href="javascript:void(0);" class="imageA" data-index="{$index}">
                                        <img src="{file_url($image->file)}" class="img-thumbnail">
                                    </a>
                                    {$image->description}
                                </div>
                            {/foreach}
                        </div>
                    {/if}
                {else}
                    <div class="alert alert-danger">{str('not_found')}</div>
                {/if}
            </div>
        </div>
    </div>
</section>

{if count($images) > 0}
    <div id="popUpCarouselDialog" class="modal">
        <div class="modal-dialog" style="margin-top: 10px; width: 80vw;">
            <div class="modal-content">
                <div class="modal-header">
                    &nbsp;
                    <button class="close" data-dismiss="modal"><i class="fa fa-times"></i></button>
                </div>
                <div class="modal-body">
                    <div id="popUpCarousel" class="carousel" data-ride="carousel">
                        <ol class="carousel-indicators">
                            {foreach $images as $index => $image}
                                <li data-target="#popUpCarousel" data-slide-to="{$index}" {if $index == 0}class="active"{/if}></li>
                            {/foreach}
                        </ol>

                        <div class="carousel-inner">
                            {foreach $images as $index => $image}
                                <div class="item {if $index == 0}active{/if}" style="height: 70vh;">
                                    <a href="{file_url($image->file)}" target="_blank">
                                        <img src="{file_url($image->file)}" alt="{$image->description}" style="height: 100%; width: auto;">
                                    </a>
                                    <div class="carousel-caption">
                                        {$image->description}
                                    </div>
                                </div>
                            {/foreach}
                        </div>

                        <a class="left carousel-control" href="#popUpCarousel" role="button" data-slide="prev">
                            <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                        </a>

                        <a class="right carousel-control" href="#popUpCarousel" role="button" data-slide="next">
                            <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
{/if}
