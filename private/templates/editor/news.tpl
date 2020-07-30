<div class="row">
    <div class="container-fluid">
        <p>
            <a href="{url('/editor/news.php?action=new&category=')}{$category}" class="btn btn-success"><i class="fa fa-plus"></i> เพิ่มข่าวใหม่</a>
        </p>

        <select title="ประเภทข่าว" class="form-control" onchange="window.location = '{url('/editor/news.php?category=')}' + this.value;">
            <option value="0" {if !$category}selected{/if}>- ดูข่าวทุกประเภท -</option>
            <option value="{constant('NEWS_ANNOUNCEMENT')}" {if $category == {constant('NEWS_ANNOUNCEMENT')}}selected{/if}>ข่าวประกาศ</option>
            <option value="{constant('NEWS_RESEARCH')}" {if $category == {constant('NEWS_RESEARCH')}}selected{/if}>โครงการงานวิจัย</option>
            <option value="{constant('NEWS_PROJECT')}" {if $category == {constant('NEWS_PROJECT')}}selected{/if}>ประกวดราคา</option>
            <option value="{constant('NEWS_JOBS')}" {if $category == {constant('NEWS_JOBS')}}selected{/if}>รับสมัครงาน</option>
        </select>
        <table class="table table-bordered">
            <thead class="bg-primary">
            <tr>
                <th>หัวข้อ</th>
                <th>วันที่ลง</th>
                <th>สถานะ</th>
                <th>จัดการ</th>
            </tr>
            </thead>
            <tbody>
            {foreach $newsArr as $newsObj}
                <tr>
                    <td>{$newsObj->title_th} / {$newsObj->title_en}</td>
                    <td style="white-space: nowrap;">{date_thai('฿วท ฿ด ฿ปปปป H:i น.', $newsObj->published_dt)}</td>
                    <td>
                        {if $newsObj->visible}
                            {if $newsObj->show_front}
                                <span class="label label-primary"><i class="fa fa-check-circle"></i> แสดงในหน้าแรก</span>
                            {else}
                                <span class="label label-success"><i class="fa fa-check"></i> แสดง</span>
                            {/if}
                        {else}
                            <span class="label label-default"><i class="fa fa-times"></i> ซ่อน</span>
                        {/if}
                    </td>
                    <td>
                        <a href="{url('/editor/news_edit.php?id=')}{$newsObj->id}" class="btn btn-xs btn-default"><i class="fa fa-edit"></i> แก้ไข</a>
                    </td>
                </tr>
                {foreachelse}
                <tr>
                    <td colspan="4" class="text-center">
                        - ไม่พบข่าว -
                    </td>
                </tr>
            {/foreach}
            </tbody>
        </table>
    </div>
</div>
