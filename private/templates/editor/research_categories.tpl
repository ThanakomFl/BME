<h3>ประเภทงานวิจัย</h3>

{if $mode == new}
    <ul>
        {foreach $categories as $categoryObj}
            <li>
                <a href="{url('/editor/research_categories.php')}?mode=edit&id={$categoryObj->id}" class="btn btn-xs btn-default">แก้ไข</a>
                <a href="{url('/editor/research_categories.php')}?action=remove&id={$categoryObj->id}" class="btn btn-xs btn-danger" onclick="return confirm('แน่ใจหรือไม่ว่าต้องการลบ');"><i class="fa fa-trash-o"></i> ลบ</a>
                {$categoryObj->title_th} / {$categoryObj->title_en}
            </li>
        {/foreach}
    </ul>
{/if}

<hr>

<form action="{url('/editor/research_categories.php')}" method="post" enctype="application/x-www-form-urlencoded">
    <div class="panel {($mode == 'new') ? 'panel-success' : 'panel-primary'}">
        <div class="panel-heading">
            {($mode == 'new') ? 'เพิ่มประเภทใหม่' : 'แก้ไขประเภท '}{$defaultTitleTH}
        </div>
        <div class="panel-body">
            {if $error}
                <div class="alert alert-danger">{$error}</div>
            {/if}
            <div class="row">
                <div class="col-md-6">
                    <div class="input-group">
                        <span class="input-group-addon">ชื่อประเภท (ภาษาไทย)</span>
                        <input type="text" name="title_th" title="ชื่อประเภท (ภาษาไทย)" class="form-control" value="{$defaultTitleTH}">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon">ชื่อประเภท (ภาษาอังกฤษ)</span>
                        <input type="text" name="title_en" title="ชื่อประเภท (ภาษาอังกฤษ)" class="form-control" value="{$defaultTitleEN}">
                    </div>
                </div>
            </div>
        </div>
        <div class="panel-footer">
            <button type="submit" class="btn {($mode == 'new') ? 'btn-success' : 'btn-primary'}">
                {($mode == 'new') ? 'เพิ่ม' : 'แก้ไข'}
            </button>
            {if $mode == 'edit'}
                <input type="hidden" name="id" value="{$category->id}">
                <a href="{url('/editor/research_categories.php')}">ยกเลิก</a>
            {/if}
        </div>
    </div>
    <input type="hidden" name="id" value="{$id}">
    <input type="hidden" name="mode" value="{$mode}">
    <input type="hidden" name="submit" value="1">
</form>