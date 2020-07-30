<h3>รายชื่อนักวิจัย</h3>

{if $mode == 'new'}
    <ul>
        {foreach $researchers as $researcherObj}
            <li>
                <a href="{url('/editor/researchers.php')}?mode=edit&id={$researcherObj->id}" class="btn btn-xs btn-default">แก้ไข</a>
                <a href="{url('/editor/researchers.php')}?action=remove&id={$researcherObj->id}" class="btn btn-xs btn-danger" onclick="return confirm('แน่ใจหรือไม่ว่าต้องการลบ');">
                    <i class="fa fa-trash-o"></i>
                    ลบ
                </a>
                {$researcherObj->name_th} / {$researcherObj->name_en}
            </li>
        {/foreach}
    </ul>
{/if}
<hr>
<form action="{url('/editor/researchers.php')}" method="post" enctype="application/x-www-form-urlencoded">
    <div class="panel {($mode == 'new')? 'panel-success' : 'panel-primary'}">
        <div class="panel-heading">{($mode == 'new')? 'เพิ่มนักวิจัยใหม่' : 'แก้ไขนักวิจัย '}{$defaultNameTH}</div>
        <div class="panel-body">
            {if $error}
                <div class="alert alert-danger">
                    {$error}
                </div>
            {/if}
            <div class="row">
                <div class="col-md-6">
                    <div class="input-group">
                        <span class="input-group-addon">ชื่อนักวิจัย (ภาษาไทย)</span>
                        <input type="text" name="name_th" title="ชื่อนักวิจัย (ภาษาไทย)" class="form-control" value="{$defaultNameTH}">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon">ชื่อนักวิจัย (ภาษาอังกฤษ)</span>
                        <input type="text" name="name_en" title="ชื่อนักวิจัย (ภาษาอังกฤษ)" class="form-control" value="{$defaultNameEN}">
                    </div>
                </div>
            </div>
        </div>
        <div class="panel-footer">
            <button type="submit" class="btn {($mode == 'new')? 'btn-success' : 'btn-primary'}">
                {($mode == 'new')? 'เพิ่ม' : 'แก้ไข'}
            </button>
            {if $mode == 'edit'}
                <a href="{url('/editor/researchers.php')}">ยกเลิก</a>
            {/if}
        </div>
    </div>
    <input type="hidden" name="submit" value="1">
    <input type="hidden" name="mode" value="{$mode}">
    <input type="hidden" name="id" value="{$id}">
</form>