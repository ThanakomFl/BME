<ul style="margin-top: 10px;">
    {foreach $courses as $course}
        <li>
            <a href="{url('/editor/courses.php')}?id={$course->id}" class="btn btn-xs btn-default">
                <i class="fa fa-edit"></i>
                แก้ไข
            </a>
            ({$course->code})
            {$course->name_th}
        </li>
    {/foreach}
</ul>
<hr>
<form action="{url('/editor/courses.php')}" method="post" enctype="application/x-www-form-urlencoded">
    <div class="panel {($mode == 'new') ? 'panel-success' : 'panel-primary'}">
        <div class="panel-heading">
            {($mode == 'new') ? 'เพิ่มกระบวนวิชาใหม่' : 'แก้ไขกระบวนวิชา'}
            {if $mode == 'edit'}
                <a href="{url('/editor/courses.php')}" class="btn btn-xs btn-default">ยกเลิก</a>
            {/if}
        </div>
        <div class="panel-body">
            {if $error}
                <div class="alert alert-danger">
                    {$error}
                </div>
            {/if}
            <div class="input-group">
                <span class="input-group-addon">รหัสกระบวนวิชา (ตัวเลข)</span>
                <input type="text" name="code" title="code" class="form-control" value="{$course->code}">
            </div>
            <div class="input-group">
                <span class="input-group-addon">รหัสกระบวนวิชา (ตัวหนังสือ + ตัวเลข)</span>
                <input type="text" name="code_th" title="code_th" class="form-control" placeholder="รหัสกระบวนวิชา (ภาษาไทย)" value="{$course->code_th}">
                <input type="text" name="code_en" title="code_en" class="form-control" placeholder="รหัสกระบวนวิชา (ภาษาอังกฤษ)" value="{$course->code_en}">
            </div>
            <div class="input-group">
                <span class="input-group-addon">ชื่อกระบวนวิชา</span>
                <input type="text" name="name_th" title="name_th" class="form-control" placeholder="ชื่อกระบวนวิชา (ภาษาไทย)" value="{$course->name_th}">
                <input type="text" name="name_en" title="name_en" class="form-control" placeholder="ชื่อกระบวนวิชา (ภาษาอังกฤษ)" value="{$course->name_en}">
            </div>
            <div class="input-group">
                <span class="input-group-addon">จำนวนหน่วยกิต</span>
                <input type="text" name="credit" title="credit" class="form-control" value="{$course->credit}">
            </div>
            <div>
                <strong>คำอธิบาย:</strong>
                <div class="row">
                    <div class="col-md-6"><textarea name="detail_th" title="detail_th" placeholder="คำอธิบาย (ภาษาไทย)" class="form-control" style="height: 10em;">{$course->detail_th}</textarea></div>
                    <div class="col-md-6"><textarea name="detail_en" title="detail_en" placeholder="คำอธิบาย (ภาษาอังกฤษ)" class="form-control" style="height: 10em;">{$course->detail_en}</textarea></div>
                </div>
            </div>
            <div>
                <div>
                    <strong>เงื่อนไขของกระบวนวิชา</strong>
                </div>
                <label>
                    <input type="checkbox" name="condition_department" value="1"{($course->condition_department) ? ' checked' : ''}>
                    เงื่อนไขการพิจารณาของภาควิชา
                </label>
                <label>
                    <input type="checkbox" name="condition_instructor" value="1"{($course->condition_instructor) ? ' checked' : ''}>
                    เงื่อนไขการพิจารณาของอาจารย์ผู้สอน
                </label>
                <div>
                    {foreach $courses as $preCourse}
                        {if $preCourse->id == $course->id}
                            {continue}
                        {/if}

                        <label style="padding-right: 10px;">
                            <input type="checkbox" name="prerequisites[]" value="{$preCourse->id}"{(in_array($preCourse->id, $course->prerequisites)) ? ' checked' : ''}>
                            ({$preCourse->code}) {$preCourse->name_th}
                        </label>
                    {/foreach}
                </div>
            </div>
        </div>
        <div class="panel-footer">
            <button type="submit" class="btn {($mode == 'new') ? 'btn-success' : 'btn-primary'}">{($mode == 'new') ? 'เพิ่ม' : 'แก้ไข'}</button>
            {if $mode == 'edit'}
                <a href="{url('/editor/courses.php')}?action=remove&id={$course->id}" class="btn btn-xs btn-danger" onclick="return confirm('แน่ใจหรือไม่ว่าต้องการลบ');">
                    <i class="fa fa-trash-o"></i>
                    ลบ
                </a>
            {/if}
        </div>
    </div>
    <input type="hidden" name="mode" value="{$mode}">
    <input type="hidden" name="id" value="{$course->id}">
    <input type="hidden" name="submit" value="1">
</form>