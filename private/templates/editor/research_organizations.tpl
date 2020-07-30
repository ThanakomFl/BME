<h3>รายชื่อหน่วยงานวิจัย</h3>

{if $mode == 'new'}
    <ul>
        {foreach $organizations as $organizationObj}
            <li>
                <a href="{url('/editor/research_organizations.php')}?mode=edit&id={$organizationObj->id}" class="btn btn-xs btn-default">แก้ไข</a>
                <a href="{url('/editor/research_organizations.php')}?action=remove&id={$organizationObj->id}" class="btn btn-xs btn-danger" onclick="return confirm('แน่ใจหรือไม่ว่าต้องการลบ');">
                    <i class="fa fa-trash-o"></i>
                    ลบ
                </a>
                {$organizationObj->name_th} / {$organizationObj->name_en}
            </li>
        {/foreach}
    </ul>
{/if}
<hr>
<form action="{url('/editor/research_organizations.php')}" method="post" enctype="application/x-www-form-urlencoded">
    <div class="panel {($mode == 'new')? 'panel-success' : 'panel-primary'}">
        <div class="panel-heading">{($mode == 'new')? 'เพิ่มหน่วยงานใหม่' : 'แก้ไขหน่วยงาน '}{$defaultNameTH}</div>
        <div class="panel-body">
            {if $error}
                <div class="alert alert-danger">
                    {$error}
                </div>
            {/if}
            <div class="row">
                <div class="col-md-6">
                    <div class="input-group">
                        <span class="input-group-addon">ชื่อหน่วยงานวิจัย (ภาษาไทย)</span>
                        <input type="text" name="name_th" title="ชื่อหน่วยงานวิจัย (ภาษาไทย)" class="form-control" value="{$defaultNameTH}">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon">ชื่อหน่วยงานวิจัย (ภาษาอังกฤษ)</span>
                        <input type="text" name="name_en" title="ชื่อหน่วยงานวิจัย (ภาษาอังกฤษ)" class="form-control" value="{$defaultNameEN}">
                    </div>
                </div>
            </div>
        </div>
        <div class="panel-footer">
            <button type="submit" class="btn {($mode == 'new')? 'btn-success' : 'btn-primary'}">
                {($mode == 'new')? 'เพิ่ม' : 'แก้ไข'}
            </button>
            {if $mode == 'edit'}
                <a href="{url('/editor/research_organizations.php')}">ยกเลิก</a>
            {/if}
        </div>
    </div>
    <input type="hidden" name="submit" value="1">
    <input type="hidden" name="mode" value="{$mode}">
    <input type="hidden" name="id" value="{$id}">
</form>