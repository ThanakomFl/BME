<h3>
    แก้ไขข่าว {$news->title_th}
    <a href="{url('/editor/news.php?category=')}{$news->category}" class="btn btn-xs btn-default"><i class="fa fa-caret-left"></i> กลับ</a>
</h3>

<form action="{url('/editor/news_edit.php')}" method="post" enctype="multipart/form-data">
    <div class="input-group">
        <span class="input-group-addon">หัวข้อ (ภาษาไทย)</span>
        <input title="หัวข้อ (ภาษาไทย)" type="text" name="title_th" class="form-control" value="{$news->title_th}">
    </div>
    <div class="input-group">
        <span class="input-group-addon">หัวข้อ (ภาษาอังกฤษ)</span>
        <input title="หัวข้อ (ภาษาอังกฤษ)" type="text" name="title_en" class="form-control" value="{$news->title_en}">
    </div>
    <div class="input-group">
        <span class="input-group-addon">ประเภทข่าว</span>
        <select title="ประเภทข่าว" name="category" class="form-control">
            <option value="{constant('NEWS_ANNOUNCEMENT')}" {if $news->category == {constant('NEWS_ANNOUNCEMENT')}}selected{/if}>ข่าวประกาศ</option>
            <option value="{constant('NEWS_RESEARCH')}" {if $news->category == {constant('NEWS_RESEARCH')}}selected{/if}>โครงการงานวิจัย</option>
            <option value="{constant('NEWS_PROJECT')}" {if $news->category == {constant('NEWS_PROJECT')}}selected{/if}>ประกวดราคา</option>
            <option value="{constant('NEWS_JOBS')}" {if $news->category == {constant('NEWS_JOBS')}}selected{/if}>รับสมัครงาน</option>
        </select>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading">
            วันที่และเวลา
        </div>
        <div class="panel-body">
            <input id="dateInput" type="text" name="date" class="form-control" style="width: auto; display: inline-block;"
                   data-provide="datepicker" data-date-format="dd/mm/yyyy" data-date-language="th"
                   placeholder="วันที่" value="{$date}" autocomplete="off">
            <input id="timeInput" type="text" name="time" class="form-control" style="width: auto; display: inline-block;"
                   placeholder="เวลา ({date('H:i')}" value="{$time}" autocomplete="off">
        </div>
    </div>
    <div style="margin: 10px 0;">
        <table class="table table-bordered table-hover">
            <thead>
            <tr class="bg-info">
                <th><i class="fa fa-picture-o"></i> ภาพข่าว</strong></th>
            </tr>
            </thead>
            <tbody>
            {foreach $news->images as $image}
                <tr>
                    <td>
                        <img src="{file_url($image->file)}" style="height: 100px; width: auto;">
                        {$image->description_th} / {$image->description_en}
                        <a href="{url('/editor/news_edit.php')}?id={$news->id}&action=remove_file&ref_id={$image->id}" class="btn btn-xs btn-danger" onclick="return confirm('แน่ใจหรือไม่ว่าต้องการลบ');"><i class="fa fa-trash-o"></i> ลบ</a>
                    </td>
                </tr>
            {/foreach}
            <tr>
                <td>
                    <strong>อัปโหลดภาพใหม่:</strong>
                    <input type="file" name="new_image" style="display: inline-block;">
                    <input type="text" name="new_image_description_th" placeholder="คำอธิบาย (ภาษาไทย)" class="form-control form-inline" style="display: inline-block; width: auto;">
                    <input type="text" name="new_image_description_en" placeholder="คำอธิบาย (ภาษาอังกฤษ)" class="form-control form-inline" style="display: inline-block; width: auto;">
                    <button type="submit" class="btn btn-xs btn-info"><i class="fa fa-upload"></i> อัปโหลด</button>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
    <div style="margin: 10px 0;">
        <table class="table table-bordered table-hover">
            <thead>
            <tr class="bg-success">
                <th><i class="fa fa-archive"></i> ไฟล์แนบ</th>
            </tr>
            </thead>
            <tbody>
            {foreach $news->attachments as $attachment}
                <tr>
                    <td>
                        <a href="{file_url($attachment->fileObj->id)}" target="_blank">
                            <i class="fa fa-file"></i>
                            {$attachment->fileObj->name}
                        </a>
                        <a href="{url('/editor/news_edit.php')}?id={$news->id}&action=remove_file&ref_id={$attachment->id}" class="btn btn-xs btn-danger" onclick="return confirm('แน่ใจหรือไม่ว่าต้องการลบ');"><i class="fa fa-trash-o"></i> ลบ</a>
                    </td>
                </tr>
            {/foreach}
            <tr>
                <td>
                    <strong>อัปโหลดไฟล์แนบใหม่</strong>
                    <input type="file" name="new_file" style="display: inline-block;">
                    <button type="submit" class="btn btn-xs btn-info"><i class="fa fa-upload"></i> อัปโหลด</button>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
    <div style="margin: 10px 0;" class="panel panel-primary">
        <div class="panel-heading">เนื้อข่าว</div>
        <div class="panel-body">
            <div class="row">
                <div class="col-md-6">
                    <textarea title="เนื้อข่าว (ภาษาไทย)" name="detail_th" placeholder="เนื้อข่าว (ภาษาไทย)" class="form-control" style="height: 10em;">{$news->detail_th}</textarea>
                </div>
                <div class="col-md-6">
                    <textarea title="เนื้อข่าว (ภาษาอังกฤษ)" name="detail_en" placeholder="เนื้อข่าว (ภาษาอังกฤษ)" class="form-control" style="height: 10em;">{$news->detail_en}</textarea>
                </div>
            </div>
        </div>
    </div>
    <div style="margin: 10px 0;">
        <label>
            <input type="checkbox" name="visible" value="1"{if $news->visible} checked{/if}>
            แสดงข่าวในเว็บ
        </label>
        <label>
            <input type="checkbox" name="show_front" value="1"{if $news->show_front} checked{/if}>
            แสดงข่าวในหน้าแรก
        </label>
    </div>
    <div style="margin:  10px 0;">
        <button type="submit" class="btn btn-success"><i class="fa fa-save"></i> บันทึก</button>
        <a href="{url('/editor/news_edit.php?action=remove&id=')}{$news->id}" class="btn btn-xs btn-danger" onclick="return confirm('แน่ใจหรือไม่ว่าต้องการลบ');"><i class="fa fa-trash-o"></i> ลบ</a>
        <a href="{url('/editor/news.php?category=')}{$news->category}">ยกเลิก</a>
    </div>
    <input type="hidden" name="submit" value="1">
    <input type="hidden" name="id" value="{$news->id}">
</form>