<style>
    #research h3 {
        margin: 0 0 10px 0;
    }
</style>
<section id="research" style="padding-top: 80px;">
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-8 col-lg-offset-2">
                <blockquote class="faq">
                    <h3>{$research->title}</h3>
                    <div>
                        <div><strong>{str('research_type')}</strong>{$research->categoryName}</div>
                        <div><strong>{str('research_author')}</strong>{$research->author}</div>
                        <div><strong>{str('research_organization')}</strong>{$research->organizationName}</div>
                        <div><strong>{str('research_start_date')}</strong>{$research->startDate}</div>
                        <div><strong>{str('research_end_date')}</strong>{$research->endDate}</div>
                        <div><strong>{str('research_budget')}</strong>{$research->budgetName} {$research->budgetAmount}</div>
                    </div>
                </blockquote>
                <div class="panel panel-info">
                    <div class="panel-heading">{str('research_abstract')}</div>
                    <div class="panel-body" style="background-color: #ffffff; border: 1px solid #ededed;">
                        <p>{$research->abstract}</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>