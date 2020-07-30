<div class="row" style="margin-top: 100px;">
    <div class="col-xs-8 col-xs-offset-2">
        <h3>{$course->name}</h3>
        <p>
            <strong>{str('course_code')}:</strong>
            ({$course->code}) {$course->code_lang}
        </p>
        <p>
            <strong>{str('course_name')}:</strong>
            {$course->name}
        </p>
        <p>
            <strong>{str('course_credit')}:</strong>
            {str('course_credit_info', [$course->credit])}
        </p>
        <p>
            <strong>{str('course_condition')}:</strong>
            {if $course->condition_department}
                <i style="padding: 0 5px;">
                    {str('course_condition_department')}
                </i>
            {/if}
            {if ($course->condition_instructor)}
                <i style="padding: 0 5px;">
                    {str('course_condition_instructor')}
                </i>
            {/if}
            {foreach $course->prerequisites as $prerequisiteCourse}
                <a href="{url('/course.php')}?id={$prerequisiteCourse->id}" style="padding: 0 5px;">
                    {$prerequisiteCourse->code}
                </a>
            {foreachelse}
                {if !$course->condition_department && !$course->condition_instructor}
                    {str('course_no_condition')}
                {/if}
            {/foreach}
        </p>
        <p>
            {$course->detail}
        </p>
    </div>
</div>