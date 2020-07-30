<h3>จัดการบุคลากร</h3>

{if $mode == 'new'}
    <div class="row">
        {foreach $staff_types as $staff_type}
            <div class="col-md-4">
                <h4>{$staff_type['name']}</h4>
                {foreach $staffs[$staff_type['type']] as $index => $staff_info}
                    <div>
                        <a href="{url('/editor/staffs.php')}?id={$staff_info->id}" class="btn btn-xs btn-default">
                            <i class="fa fa-edit"></i>
                            แก้ไขข้อมูล
                        </a>
                        {if $index > 0}
                            <a href="{url('/editor/staffs.php')}?action=resequence&id1={$staff_info->id}&id2={$staffs[$staff_info->type][$index - 1]->id}"
                               class="btn btn-xs btn-default">
                                <i class="fa fa-caret-up"></i>
                            </a>
                        {else}
                            <button type="button" class="btn btn-xs btn-default" disabled>
                                <i class="fa fa-caret-up"></i>
                            </button>
                        {/if}
                        {if $index < count($staffs[$staff_type['type']]) - 1}
                            <a href="{url('/editor/staffs.php')}?action=resequence&id1={$staff_info->id}&id2={$staffs[$staff_info->type][$index + 1]->id}"
                               class="btn btn-xs btn-default">
                                <i class="fa fa-caret-down"></i>
                            </a>
                        {else}
                            <button type="button" class="btn btn-xs btn-default" disabled>
                                <i class="fa fa-caret-down"></i>
                            </button>
                        {/if}
                        {$staff_info->name_th}
                    </div>
                {/foreach}
            </div>
        {/foreach}
    </div>
{/if}

<hr>

<form action="{url('/editor/staffs.php')}" method="post" enctype="multipart/form-data">
    <div class="panel {($mode == 'new') ? 'panel-success' : 'panel-primary'}">
        <div class="panel-heading">
            {($mode == 'new') ? 'เพิ่มบุคลากรใหม่' : 'แก้ไขบุคลากร'}
            {if $mode == 'edit'}
                <a href="{url('/editor/staffs.php')}" class="btn btn-xs btn-default">ยกเลิก</a>
            {/if}
        </div>
        <div class="panel-body">
            {if $error}
                <div class="alert alert-danger">
                    {$error}
                </div>
            {/if}
            <div class="input-group">
                <span class="input-group-addon">ชื่อ (ภาษาไทย)</span>
                <input type="text" name="name_th" title="ชื่อ (ภาษาไทย)" class="form-control" value="{$staff->name_th}">
            </div>
            <div class="input-group">
                <span class="input-group-addon">ชื่อ (ภาษาอังกฤษ)</span>
                <input type="text" name="name_en" title="ชื่อ (ภาษาอังกฤษ)" class="form-control" value="{$staff->name_en}">
            </div>
            <div class="input-group">
                <span class="input-group-addon">ประเภท</span>
                <select title="ประเภท" name="type" class="form-control">
                    <option value="{constant('STAFF_LECTURER')}"{($staff->type == constant('STAFF_LECTURER')) ? ' selected' : ''}>คณาจารย์</option>
                    <option value="{constant('STAFF_RESEARCHER')}"{($staff->type == constant('STAFF_RESEARCHER')) ? ' selected' : ''}>นักวิจัย</option>
                    <option value="{constant('STAFF_OFFICER')}"{($staff->type == constant('STAFF_OFFICER')) ? ' selected' : ''}>เจ้าหน้าที่</option>
                </select>
            </div>
            <hr>
            <strong>{($staff->picture) ? 'เปลี่ยนรูปภาพ' : 'อัปโหลดรูปภาพ'}</strong>
            {if $staff->picture}
                <div>
                    <img src="{file_url($staff->picture)}" style="width: 100px; height: auto;">
                </div>
            {/if}
            <input type="file" name="picture">
            {if $staff->picture}
                <label>
                    หรือ
                    <input type="checkbox" name="remove_picture" value="1">
                    ลบรูปทิ้ง
                </label>
            {/if}
            <hr>
            <div class="row">
                <div class="col-md-6">
                    <textarea title="คำอธิบาย (ภาษาไทย)" name="detail_th" class="form-control" placeholder="คำอธิบาย (ภาษาไทย)" style="height: 10em;">{$staff->detail_th}</textarea>
                </div>
                <div class="col-md-6">
                    <textarea title="คำอธิบาย (ภาษาอังกฤษ)" name="detail_en" class="form-control" placeholder="คำอธิบาย (ภาษาอังกฤษ)" style="height: 10em;">{$staff->detail_en}</textarea>
                </div>
            </div>
        </div>
        <div class="panel-footer">
            <button type="submit" class="btn {($mode == 'new') ? 'btn-success' : 'btn-primary'}">{($mode == 'new') ? 'เพิ่มข้อมูล' : 'แก้ไขข้อมูล'}</button>
            {if $mode == 'edit'}
                <a href="{url('/editor/staffs.php')}?action=remove&id={$id}" class="btn btn-xs btn-danger" onclick="return confirm('แน่ใจหรือไม่ว่าต้องการลบ');"><i class="fa fa-trash-o"></i> ลบข้อมูล</a>
            {/if}
        </div>
    </div>
    <input type="hidden" name="submit" value="1">
    <input type="hidden" name="mode" value="{$mode}">
    <input type="hidden" name="id" value="{$id}">
</form>
