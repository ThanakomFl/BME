<div class="row" style="margin-top: 100px;">
    <div class="col-sm-8 col-sm-offset-2">
        <h2>{$degree->name}</h2>
        <p>
            <strong>{str('degree_name')}:</strong>
            {$degree->name}
        </p>
        <p>
            <strong>{str('degree_short_name')}:</strong>
            {$degree->short_name}
        </p>
        <p>
            {$degree->detail}
        </p>
        {if $degree->fileObj}
            <p>
                <strong>{str('news_attachments')}:</strong>
                <a href="{file_url($degree->fileObj->id)}" target="_blank">
                    <i class="fa fa-file"></i>
                    {$degree->fileObj->name} <small>({display_file_size($degree->fileObj->size)})</small>
                </a>
            </p>
        {/if}
        <h3>{str('degree_modules')}</h3>
        <ul>
            {foreach $degree->modules as $module}
                <li>
                    <strong>{$module->name} ({str('degree_module_minimum_credits', [$module->minimum_credits])})</strong>
                    <ul>
                        {foreach $module->moduleCourses as $moduleCourse}
                            {if !$moduleCourse->course}
                                {continue}
                            {/if}
                            <li>
                                <a href="{url('/course.php')}?id={$moduleCourse->course->id}" target="_blank">
                                    <strong>{$moduleCourse->course_code}</strong>
                                    -
                                    {$moduleCourse->course_name}
                                    <small>
                                        ({str('module_course_credit', [$moduleCourse->course->credit])})
                                    </small>
                                </a>
                            </li>
                        {/foreach}
                    </ul>
                </li>
            {/foreach}
        </ul>
    </div>
</div>