<div class="row" style="margin-top: 100px;">
    <div class="col-md-8 col-md-offset-2 col-xs-10 col-xs-offset-1">
        <h3>{str('menu_staff')}</h3>

        <ul class="nav nav-tabs" style="margin-bottom: 20px;">
            <li class="{($type == constant('STAFF_LECTURER')) ? 'active' : ''}"><a href="{url('/staffs.php')}?type={constant('STAFF_LECTURER')}">{str('staff_lecturer')}</a></li>
            <li class="{($type == constant('STAFF_RESEARCHER')) ? 'active' : ''}"><a href="{url('/staffs.php')}?type={constant('STAFF_RESEARCHER')}">{str('staff_researcher')}</a></li>
            <li class="{($type == constant('STAFF_OFFICER')) ? 'active' : ''}"><a href="{url('/staffs.php')}?type={constant('STAFF_OFFICER')}">{str('staff_officer')}</a></li>
        </ul>

        <div class="row" style="margin-bottom: 40px; display: flex; flex-wrap: wrap;">
            {foreach $staffs as $staff}
                <div class="col-md-3 col-sm-4 col-xs-6" style="display: flex !important; flex-direction: column !important;">
                    <div class="img-rounded" style="position: relative; overflow: hidden; padding-bottom: 100%;">
                        {if $staff->picture}
                            <img src="{file_url($staff->picture)}" alt="{$staff->name}" class="img-responsive img-rounded"
                                 style="position: absolute; width: 100%; height: 100%; object-fit: cover;">
                        {/if}
                    </div>
                    <div>
                        <p style="font-weight: bold;">{$staff->name}</p>
                        {if $staff->detail}
                            {$staff->detail}
                        {/if}
                    </div>
                </div>
                {foreachelse}
                <div class="container-fluid">
                    <div class="alert alert-warning">
                        {str('no_data')}
                    </div>
                </div>
            {/foreach}
        </div>
    </div>
</div>
