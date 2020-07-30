<h3>แก้ไขข้อความ</h3>

<ul>
    {foreach $texts as $text}
        <li>
            <a href="{url('/editor/text.php')}?id={$text->id}">
                {$text->description}
            </a>
        </li>
    {/foreach}
</ul>

{foreach $texts as $text}
    <div class="panel panel-info">
        <div class="panel-heading">
            {$text->description} ({$text->id})
        </div>
        <div class="panel-body">
            <strong>ภาษาไทย</strong>
            <p>
                {textarea_display($text->text_th)}
            </p>
            <hr>
            <strong>ภาษาอังกฤษ</strong>
            <p>
                {textarea_display($text->text_en)}
            </p>
        </div>
        <div class="panel-footer">
            <a href="{url('/editor/text.php')}?id={$text->id}" class="btn btn-default">
                <i class="fa fa-edit"></i>
                แก้ไข
            </a>
        </div>
    </div>
{/foreach}