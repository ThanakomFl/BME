<h3>จัดการผู้ดูแล</h3>

{if $mode == 'new'}
    <ul>
        {foreach $accounts as $account}
            <li>
                {$account->display_name}
                <a href="{url('/editor/accounts.php?id=')}{$account->id}" class="btn btn-xs btn-default"><i class="fa fa-edit"></i> แก้ไข</a>
            </li>
        {/foreach}
    </ul>

    <hr>
{/if}

<form action="{url('/editor/accounts.php')}" method="post" enctype="application/x-www-form-urlencoded">
    <div class="panel {if $mode == 'new'}panel-success{else}panel-primary{/if}">
        <div class="panel-heading">
            {if $mode == 'new'}เพิ่มผู้ดูแลใหม่
            {else}แก้ไขผู้ดูแล {$currentAccount->display_name}{/if}
        </div>
        <div class="panel-body">
            {if $error}
                <div class="alert alert-danger">{$error}</div>
            {/if}
            <div class="input-group">
                <span class="input-group-addon">ชื่อเข้าสู่ระบบ</span>
                <input title="ชื่อเข้าสู่ระบบ" type="text" name="username" value="{$currentAccount->username}" class="form-control">
            </div>
            <div class="input-group">
                <span class="input-group-addon"><i class="fa fa-lock"></i> {if $mode == 'new'}รหัสผ่าน{else}เปลี่ยนรหัสผ่าน{/if}</span>
                <input title="รหัสผ่าน" type="password" name="password" class="form-control">
            </div>
            <div class="input-group">
                <span class="input-group-addon"><i class="fa fa-lock"></i> ยืนยันรหัสผ่าน</span>
                <input title="ยืนยันรหัสผ่าน" type="password" name="password_confirmation" class="form-control">
            </div>
            <div class="input-group">
                <span class="input-group-addon">ชื่อแสดง</span>
                <input title="ชื่อแสดง" type="text" name="display_name" value="{$currentAccount->display_name}" class="form-control">
            </div>
        </div>
        <div class="panel-footer">
            {if $mode == 'new'}
                <button type="submit" class="btn btn-success">เพิ่ม</button>
            {else}
                <button type="submit" class="btn btn-primary">แก้ไข</button>
                <a href="{url('/editor/accounts.php')}?action=remove&id={$currentAccount->id}" class="btn btn-xs btn-danger" onclick="return confirm('แน่ใจหรือไม่ว่าต้องการลบ');"><i class="fa fa-times"></i> ลบบัญชี</a>
                <a href="{url('/editor/accounts.php')}">ยกเลิก</a>
            {/if}
        </div>
    </div>
    <input type="hidden" name="submit" value="1">
    <input type="hidden" name="mode" value="{$mode}">
    <input type="hidden" name="id" value="{$currentAccount->id}">
</form>