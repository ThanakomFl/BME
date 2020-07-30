<div class="row" style="margin-top: 100px;">
    <div class="col-xs-8 col-xs-offset-2">
        <h2 class="text-center">{str('menu_structure')}</h2>

        {foreach $objects as $object}
            <h3>{$object->heading}</h3>
            <p class="text-center">
                <img src="{file_url($object->image)}" alt="{$object->heading}" style="width: 80%; height: auto;">
            </p>
            <hr>
        {foreachelse}
            <div class="alert alert-warning">
                {str('no_data')}
            </div>
        {/foreach}
    </div>
</div>