<h2>
    {if $mode == constant('DOCUMENT_MODE_DOCUMENT')}
        รายการเอกสาร
    {elseif $mode == constant('DOCUMENT_MODE_REPORT')}
        รายงานการประชุม
    {/if}
</h2>
<div class="panel {if $id}panel-primary{else}panel-success{/if}" style="margin-top: 10px;">
    <div class="panel-heading">
        {if $id}
            <i class="fa fa-edit"></i>
            แก้ไขข้อมูลเอกสาร
        {else}
            <i class="fa fa-plus"></i>
            เพิ่มเอกสารใหม่
        {/if}
    </div>
    <div class="panel-body">
        {if $error}
            <div class="alert alert-danger">
                <i class="fa fa-times-circle"></i>
                {$error}
            </div>
        {elseif $success}
            <div class="alert alert-success">
                <i class="fa fa-check"></i>
                บันทึกข้อมูลเรียบร้อยแล้ว
            </div>
        {/if}
        <form method="post" enctype="multipart/form-data"
            action="{url('/editor/documents.php')}">
            {if $id}
                <p>
                    {$current_document->file_name}
                </p>
            {else}
                <div class="form-group">
                    <label for="fileFile">ไฟล์เอกสารหลัก</label>
                    <input id="fileFile" type="file" name="file">
                </div>
                <div class="form-group">
                    <label for="previewFile">ไฟล์ภาพตัวอย่าง</label>
                    <input id="previewFile" type="file" name="preview">
                </div>
            {/if}
            <div class="form-group">
                <label for="dateInput">วันเวลา</label>
                <input id="dateInput" type="text" name="date" class="form-control" style="width: auto; display: inline-block;"
                    data-provide="datepicker" data-date-format="dd/mm/yyyy" data-date-language="th" placeholder="วันที่"
                    value="{$current_document->date}" autocomplete="off">
                <input title="เวลา" type="text" name="time" class="form-control" style="width: auto; display: inline-block;"
                    placeholder="เวลา ({{date('H:i')}})"
                    value="{$current_document->time}" autocomplete="off">
                <div class="small" style="color: #666666;">
                    　- เว้นว่างช่องวันที่เพิ่อใช้วันเวลาที่อัปโหลดไฟล์เป็นวันที่ของเอกสาร<br>
                    　- เว้นว่างช่องเวลาเพื่อไม่ระบุเวลาของเอกสาร (00:00 น.)
                </div>
            </div>
            <div class="form-group">
                <label for="typeSelect">ประเภท</label>
                <select id="typeSelect" name="type" class="form-control" style="width: auto;">
                    {foreach mode_type_strings($mode) as $value => $name}
                        <option value="{$value}" {if $current_document->type == $value}selected{/if}>
                            {$name}
                        </option>
                    {/foreach}
                </select>
            </div>
            <button type="submit" class="btn btn-success">
                <i class="fa fa-check"></i>
                ตกลง
            </button>
            {if $id}
                <a href="{url('/editor/documents.php', constant('PATH_INTERNAL'),
                        ['action' => 'delete', 'mode' => $mode, 'id' => $current_document->id])}"
                    class="btn btn-sm btn-danger" onclick="return confirm('แน่ใจหรือไม่ว่าต้องการลบ');">
                    <i class="fa fa-trash-o"></i>
                    ลบ
                </a>
                <a href="{url('/editor/documents.php', constant('PATH_INTERNAL'), ['mode' => $mode])}">
                    ยกเลิก
                </a>
            {/if}
            <input type="hidden" name="submit" value="1">
            <input type="hidden" name="id" value="{$current_document->id}">
            <input type="hidden" name="mode" value="{$mode}">
        </form>
    </div>
</div>
<div ng-app="angularApp">
    <a id="list"></a>
    <app-documents mode="{$mode}"></app-documents>
</div>
