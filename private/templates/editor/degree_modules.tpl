{if $mode == 'new'}
    <ul style="margin-top: 10px;">
        {foreach $modules as $moduleObj}
            <li>
                <a href="{url('/editor/degree_modules.php')}?degree={$degree}&module={$moduleObj->id}" class="btn btn-xs btn-default">
                    <i class="fa fa-edit"></i>
                    แก้ไข
                </a>
                {$moduleObj->name_th}
            </li>
        {/foreach}
    </ul>
{/if}

<hr>

<form action="{url('/editor/degree_modules.php')}" method="post" enctype="application/x-www-form-urlencoded">
    <div class="panel {($mode == 'new')? 'panel-success' : 'panel-primary'}">
        <div class="panel-heading">
            {if $mode == 'new'}
                เพิ่มกลุ่มกระบวนวิชาใหม่ในหลักสูตร
            {elseif $mode == 'edit'}
                แก้ไขกลุ่มกระบวนวิชา {$module->name_th}
                <a href="{url('/editor/degree_modules.php')}?degree={$degree}" class="btn btn-xs btn-default">
                    ยกเลิก
                </a>
            {/if}
        </div>
        <div class="panel-body">
            {if $error}
                <div class="alert alert-danger">
                    {$error}
                </div>
            {/if}
            <div class="input-group">
                <span class="input-group-addon">ชื่อกลุ่ม</span>
                <input type="text" name="name_th" title="name_th" placeholder="ชื่อกลุ่ม (ภาษาไทย)" class="form-control" value="{$module->name_th}">
                <input type="text" name="name_en" title="name_en" placeholder="ชื่อกลุ่ม (ภาษาอังกฤษ)" class="form-control" value="{$module->name_en}">
            </div>
            <div class="input-group">
                <span class="input-group-addon">หน่วยกิตขั้นต่ำ</span>
                <input type="text" name="minimum_credits" title="minimum_credits" class="form-control" value="{$module->minimum_credits}">
            </div>
            <hr>
            <strong>กระบวนวิชาในกลุ่ม</strong>
            {foreach $courseList as $courseObj}
                <div>
                    <label>
                        <input type="checkbox" name="courses[]" value="{$courseObj->id}"{if in_array($courseObj->id, $courses)} checked{/if}>
                        ({$courseObj->code}) {$courseObj->name_th}
                    </label>
                </div>
            {/foreach}
        </div>
        <div class="panel-footer">
            {if $mode == 'new'}
                <button type="submit" class="btn btn-success">เพิ่ม</button>
            {elseif $mode == 'edit'}
                <button type="submit" class="btn btn-primary">แก้ไข</button>
                <a href="{url('/editor/degree_modules.php')}?degree={$degree}&module={$module->id}&action=remove" class="btn btn-xs btn-danger" onclick="return confirm('แน่ใจหรือไม่ว่าต้องการลบ');">
                    <i class="fa fa-trash-o"></i>
                    ลบ
                </a>
            {/if}
        </div>
    </div>
    <input type="hidden" name="submit" value="1">
    <input type="hidden" name="mode" value="{$mode}">
    <input type="hidden" name="degree" value="{$degree}">
    <input type="hidden" name="module" value="{$module->id}">
</form>