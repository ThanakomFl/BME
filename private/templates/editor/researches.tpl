<h3>งานวิจัย</h3>

<div class="row">
    <div class="col-md-6">
        <form action="{url('/editor/researches.php')}" method="get">
            <div class="input-group" style="margin-bottom: 10px;">
                <span class="input-group-addon">ค้นหา</span>
                {$searchCategoryDropDown}
                <input type="text" name="keyword" title="keyword" class="form-control" placeholder="ค้นหาชื่องานวิจัย" value="{$keyword}">
                <span class="input-group-addon">
                    <button type="submit" class="btn btn-success">
                        <i class="fa fa-search"></i>
                        ค้นหา
                    </button>
                </span>
            </div>
        </form>

        {if count($researchResults) == 0}
            - ไม่พบงานวิจัย -
        {else}
            <ul>
                {foreach $researchResults as $researchResult}
                    <li>
                        <a href="{url('/editor/researches.php')}?id={$researchResult->id}" class="btn btn-xs btn-default">
                            แก้ไข
                        </a>
                        {$researchResult->title_th} / {$researchResult->title_en}
                    </li>
                {/foreach}
            </ul>
        {/if}
    </div>
    <div class="col-md-6">
        <form action="{url('/editor/researches.php')}" method="post" enctype="application/x-www-form-urlencoded">
            <div class="panel {($mode == 'new')? 'panel-success' : 'panel-primary'}">
                <div class="panel-heading">
                    {if $mode == 'new'}
                        เพิ่มงานวิจัยใหม่
                    {else}
                        แก้ไขงานวิจัย {$research->title_th}
                        <a href="{url('/editor/researches.php')}" class="btn btn-xs btn-default">ยกเลิก</a>
                    {/if}
                </div>
                <div class="panel-body">
                    {if $error}
                        <div class="alert alert-danger">
                            {$error}
                        </div>
                    {/if}
                    <div class="input-group">
                        <span class="input-group-addon">ชื่องานวิจัย (ภาษาไทย)</span>
                        <input type="text" name="title_th" title="ชื่องานวิจัย (ภาษาไทย)" class="form-control" style="font-weight: bold;" value="{$research->title_th}">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon">ชื่องานวิจัย (ภาษาอังกฤษ)</span>
                        <input type="text" name="title_en" title="ชื่องานวิจัย (ภาษาอังกฤษ)" class="form-control" style="font-weight: bold;" value="{$research->title_en}">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon">ประเภทงานวิจัย</span>
                        {$researchCategoryDropDown}
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon">หน่วยงานวิจัย</span>
                        {$researchOrganizationDropDown}
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon">วันที่เริ่มงานวิจัย</span>
                        <input type="text" name="start_dt" title="วันที่เริ่มงานวิจัย" class="form-control" data-provide="datepicker" data-date-format="dd/mm/yyyy" data-date-language="th" value="{$research->start_dt}">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon">วันที่สิ้นสุดงานวิจัย</span>
                        <input type="text" name="end_dt" title="วันที่สิ้นสุดงานวิจัย" class="form-control" data-provide="datepicker" data-date-format="dd/mm/yyyy" data-date-language="th" value="{$research->end_dt}">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon">ชื่องบประมาณ (ภาษาไทย)</span>
                        <input type="text" name="budget_th" title="ชื่องานวิจัย (ภาษาอังกฤษ)" class="form-control" value="{$research->budget_th}">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon">ชื่องบประมาณ (ภาษาอังกฤษ)</span>
                        <input type="text" name="budget_en" title="ชื่องานวิจัย (ภาษาอังกฤษ)" class="form-control" value="{$research->budget_en}">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon">จำนวนเงิน (บาท)</span>
                        <input type="text" name="budget_amount" title="จำนวนเงิน (บาท)" class="form-control" value="{$research->budget_amount}">
                    </div>
                    <div>
                        <strong>นักวิจัย</strong>
                        {foreach db_get_records_array('researchers', [], 'name_th') as $researcher}
                            <div style="margin: 0 0 0 20px;">
                                <label>
                                    <input type="checkbox" name="researchers[]" value="{$researcher->id}"{(in_array($researcher->id, $selectedResearcherIDs))? ' checked' : ''}>
                                    {$researcher->name_th}
                                </label>
                            </div>
                        {/foreach}
                    </div>
                    <div>
                        <textarea name="abstract_th" title="บทคัดย่อ (ภาษาไทย)" placeholder="บทคัดย่อ (ภาษาไทย)" style="height: 15em;" class="form-control">{$research->abstract_th}</textarea>
                        <textarea name="abstract_en" title="Abstract (English)" placeholder="Abstract (English)" style="height: 15em;" class="form-control">{$research->abstract_en}</textarea>
                    </div>
                    <div class="input-group">
                        <label class="input-group-addon">
                            <input type="checkbox" name="visible" value="1"{($research->visible)? ' checked' : ''}>
                            แสดงผล
                        </label>
                    </div>
                </div>
                <div class="panel-footer">
                    <button type="submit" class="btn {($mode == 'new')? 'btn-success' : 'btn-primary'}">
                        {($mode == 'new')? 'เพิ่ม' : 'แก้ไข'}
                    </button>
                    {if $mode == 'edit'}
                        <a href="{url('/editor/researches.php')}?id={$research->id}&action=remove" class="btn btn-xs btn-danger" onclick="return confirm('แน่ใจหรือไม่ว่าต้องการลบ');">
                            <i class="fa fa-trash-o"></i> ลบ
                        </a>
                    {/if}
                </div>
            </div>
            <input type="hidden" name="submit" value="1">
            <input type="hidden" name="id" value="{$research->id}">
        </form>
    </div>
</div>