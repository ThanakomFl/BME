<h3>แก้ไขข้อความ {$text->description}</h3>

<form action="{url('/editor/text.php')}" method="post" enctype="application/x-www-form-urlencoded">
    <strong>ภาษาไทย</strong>
    <textarea name="text_th" title="text_th" class="form-control" style="height: 10em;">{$text->text_th}</textarea>

    <strong>ภาษาอังกฤษ</strong>
    <textarea name="text_en" title="text_en" class="form-control" style="height: 10em;">{$text->text_en}</textarea>

    <div style="margin-top: 10px;">
        <button type="submit" class="btn btn-success">
            ตกลง
        </button>
        <a href="{url('/editor/texts.php')}">ยกเลิก</a>
    </div>

    <input type="hidden" name="id" value="{$id}">
    <input type="hidden" name="submit" value="1">
</form>