{if $mode == 'new'}
    <div class="row" style="margin-top: 10px;">
        <div class="col-md-6">
            <table class="table table-bordered table-hover">
                <thead class="bg-primary">
                <tr>
                    <th>ชื่อหลักสูตร</th>
                    <th>จัดการ</th>
                </tr>
                </thead>
                <tbody>
                {foreach $degrees as $degreeObj}
                    <tr>
                        <td>{$degreeObj->name_th}</td>
                        <td>
                            <a href="{url('/editor/degrees.php')}?id={$degreeObj->id}" class="btn btn-xs btn-default">
                                <i class="fa fa-edit"></i> แก้ไขข้อมูลหลักสูตร
                            </a>
                            <a href="{url('/editor/degree_modules.php')}?degree={$degreeObj->id}" class="btn btn-xs btn-default">
                                <i class="fa fa-edit"></i> แก้ไขข้อมูลกระบวนวิชาในหลักสูตร
                            </a>
                        </td>
                    </tr>
                    {foreachelse}
                    <tr>
                        <td colspan="2" class="bg-warning text-center">- ไม่มีข้อมูล -</td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
        </div>
    </div>
{/if}

<hr>

<form action="{url('/editor/degrees.php')}" method="post" enctype="multipart/form-data">
    <div class="panel {($mode == 'new') ? 'panel-success' : 'panel-primary'}">
        <div class="panel-heading">
            {if $mode == 'new'}
                เพิ่มหลักสูตรใหม่
            {else}
                แก้ไขหลักสูตร {$degree->name_th}
                <a href="{url('/editor/degrees.php')}" class="btn btn-xs btn-default">ยกเลิก</a>
            {/if}
        </div>
        <div class="panel-body">
            {if $error}
                <div class="alert alert-danger">{$error}</div>
            {/if}
            <div class="input-group">
                <span class="input-group-addon">ชื่อหลักสูตร</span>
                <input type="text" name="name_th" title="name_th" class="form-control" placeholder="ชื่อหลักสูตร (ภาษาไทย)" value="{$degree->name_th}">
                <input type="text" name="name_en" title="name_en" class="form-control" placeholder="ชื่อหลักสูตร (ภาษาอังกฤษ)" value="{$degree->name_en}">
            </div>
            <div class="input-group">
                <span class="input-group-addon">ชื่อหลักสูตร (ย่อ)</span>
                <input type="text" name="short_name_th" title="short_name_th" class="form-control" placeholder="ชื่อหลักสูตรแบบย่อ (ภาษาไทย)" value="{$degree->short_name_th}">
                <input type="text" name="short_name_en" title="short_name_en" class="form-control" placeholder="ชื่อหลักสูตรแบบย่อ (ภาษาอังกฤษ)" value="{$degree->short_name_en}">
            </div>
            <hr>
            <div>
                <strong>คำอธิบาย:</strong>
                <div class="row">
                    <div class="col-md-6">
                        <textarea name="detail_th" title="detail_th" placeholder="คำอธิบาย (ภาษาไทย)" class="form-control" style="height: 10em;">{$degree->detail_th}</textarea>
                    </div>
                    <div class="col-md-6">
                        <textarea name="detail_en" title="detail_en" placeholder="คำอธิบาย (ภาษาอังกฤษ)" class="form-control" style="height: 10em;">{$degree->detail_en}</textarea>
                    </div>
                </div>
            </div>
            <hr>
            <div>
                <strong>ไฟล์ประกอบหลักสูตร:</strong>
                <input type="file" name="upload" title="file">
                {if $degree->file}
                    <a href="{file_url($degree->file)}" target="_blank">ดาวน์โหลดไฟล์</a>
                    <label>
                        <input type="checkbox" name="remove_file" value="1">
                        ลบไฟล์เดิม
                    </label>
                {/if}
            </div>
            <hr>
            <div>
                <label>
                    <input type="checkbox" name="visible" value="1"{($degree->visible) ? ' checked' : ''}>
                    แสดงในหน้าเว็บ
                </label>
            </div>
        </div>
        <div class="panel-footer">
            <button type="submit" class="btn {($mode == 'new') ? 'btn-success' : 'btn-primary'}">{($mode == 'new') ? 'เพิ่ม' : 'แก้ไข'}</button>
            {if $mode == 'edit'}
                <a href="{url('/editor/degrees.php')}?action=remove&id={$degree->id}" class="btn btn-xs btn-danger" onclick="return confirm('แน่ใจหรือไม่ว่าต้องการลบ');">
                    <i class="fa fa-trash-o"></i>
                    ลบ
                </a>
            {/if}
        </div>
    </div>
    <input type="hidden" name="mode" value="{$mode}">
    <input type="hidden" name="id" value="{$degree->id}">
    <input type="hidden" name="submit" value="1">
</form>