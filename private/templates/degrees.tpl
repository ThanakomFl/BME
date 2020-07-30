<div style="margin-top: 100px;" class="row">
    <div class="col-sm-8 col-sm-offset-2">
        <h3>{str('menu_curriculum')}</h3>
        {foreach $degrees as $degree}
            <blockquote class="faq">
                <h3><a href="{url('/degree.php')}?id={$degree->id}">({$degree->short_name}) {$degree->name}</a></h3>
            </blockquote>
        {foreachelse}
            <div class="alert alert-warning">
                {str('no_data')}
            </div>
        {/foreach}
    </div>
</div>