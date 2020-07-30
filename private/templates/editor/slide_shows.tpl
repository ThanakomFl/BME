<style>
    img.item {
        width: 200px;
        height: auto;
    }
</style>

<h3>รูปภาพหน้าแรก</h3>

<ul>
    {foreach $objects as $carouselObj}
        <li>
            <a href="{url('/editor/slide_shows.php')}?action=move&direction=up&id={$carouselObj->id}" class="btn btn-xs btn-default"><i class="fa fa-arrow-up"></i> ย้ายขึ้น</a>
            <a href="{url('/editor/slide_shows.php')}?action=move&direction=down&id={$carouselObj->id}" class="btn btn-xs btn-default"><i class="fa fa-arrow-down"></i> ย้ายลง</a>
            <a href="{url('/editor/slide_shows.php')}?action=remove&id={$carouselObj->id}" class="btn btn-xs btn-danger" onclick="return confirm('แน่ใจหรือไม่ว่าต้องการลบ');"><i class="fa fa-trash-o"></i> ลบ</a>

            <img src="{file_url($carouselObj->image)}" class="item">
            <a href="{$carouselObj->url}">{$carouselObj->url}</a>
        </li>
    {/foreach}
</ul>

<form action="{url('/editor/slide_shows.php')}" method="post" enctype="multipart/form-data">
    <div class="panel panel-success">
        <div class="panel-heading">
            เพิ่มข้อมูลใหม่
        </div>
        <div class="panel-body">
            <p>
                <strong>อัปโหลดไฟล์ภาพ:</strong>
                <input type="file" name="image">
            </p>
            <div class="input-group">
                <span class="input-group-addon">URL</span>
                <input type="text" name="url" title="URL" class="form-control" value="{$object->url}">
            </div>
        </div>
        <div class="panel-footer">
            <button type="submit" class="btn btn-success">เพิ่มข้อมูล</button>
        </div>
    </div>
    <input type="hidden" name="submit" value="1">
</form>