<style>
    img.item {
        width: 200px;
        height: auto;
    }
</style>

<h3>โครงสร้างองค์กร</h3>

<ul>
    {foreach $objects as $structureObj}
        <li>
            <a href="{url('/editor/structure.php')}?action=move&direction=up&id={$structureObj->id}" class="btn btn-xs btn-default"><i class="fa fa-arrow-up"></i> ย้ายขึ้น</a>
            <a href="{url('/editor/structure.php')}?action=move&direction=down&id={$structureObj->id}" class="btn btn-xs btn-default"><i class="fa fa-arrow-down"></i> ย้ายลง</a>
            <a href="{url('/editor/structure.php')}?action=remove&id={$structureObj->id}" class="btn btn-xs btn-danger" onclick="return confirm('แน่ใจหรือไม่ว่าต้องการลบ');"><i class="fa fa-trash-o"></i> ลบ</a>

            <img src="{file_url($structureObj->image_th)}" class="item">
            <img src="{file_url($structureObj->image_en)}" class="item">
        </li>
    {/foreach}
</ul>

<form action="{url('/editor/structure.php')}" method="post" enctype="multipart/form-data">
    <div class="panel panel-success">
        <div class="panel-heading">
            เพิ่มข้อมูลใหม่
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-md-6">
                    <div class="input-group">
                        <span class="input-group-addon">หัวข้อ (ภาษาไทย)</span>
                        <input type="text" name="heading_th" title="หัวข้อ (ภาษาไทย)" class="form-control" value="{$object->heading_th}">
                    </div>
                    <p>
                        <strong>อัปโหลดไฟล์ภาพ (ภาษาไทย):</strong>
                        <input type="file" name="image_th">
                    </p>
                </div>
                <div class="col-md-6">
                    <div class="input-group">
                        <span class="input-group-addon">หัวข้อ (ภาษาอังกฤษ)</span>
                        <input type="text" name="heading_en" title="หัวข้อ (ภาษาอังกฤษ)" class="form-control" value="{$object->heading_en}">
                    </div>
                    <p>
                        <strong>อัปโหลดไฟล์ภาพ (ภาษาอังกฤษ):</strong>
                        <input type="file" name="image_en">
                    </p>
                </div>
            </div>
        </div>
        <div class="panel-footer">
            <button type="submit" class="btn btn-success">เพิ่มข้อมูล</button>
        </div>
    </div>
    <input type="hidden" name="submit" value="1">
</form>