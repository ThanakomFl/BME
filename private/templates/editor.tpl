<div style="margin-top: 100px;">
    <div class="row">
        <div class="col-md-8 col-md-offset-2">
            <h2>เข้าสู่ระบบ</h2>
            <form action="{url('/editor.php')}" method="post" enctype="application/x-www-form-urlencoded">
                {if $incorrectLogIn}
                    <div class="alert alert-danger">
                        <i class="fa fa-times-circle"></i> ชื่อหรือรหัสผ่านผิด
                    </div>
                {/if}
                <div class="input-group" style="margin: 10px 0;">
                    <span class="input-group-addon"><i class="fa fa-user"></i> ชื่อผู้ดูแล:</span>
                    <input type="text" class="form-control" title="ชื่อผู้ดูแล" name="username">
                </div>
                <div class="input-group" style="margin: 10px 0;">
                    <span class="input-group-addon"><i class="fa fa-lock"></i> รหัสผ่าน:</span>
                    <input type="password" class="form-control" title="รหัสผ่าน" name="password">
                </div>
                <div class="text-left" style="margin: 10px 0;">
                    <button type="submit" class="btn btn-success"><i class="fa fa-check"></i> เข้าสู่ระบบ</button>
                </div>
                <input type="hidden" name="submit" value="1">
            </form>
        </div>
    </div>
</div>