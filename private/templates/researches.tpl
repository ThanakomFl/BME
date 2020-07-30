<style>
    #research h3 {
        margin: 0 0 10px 0;
    }

    #research ul.nav li.active a {
        background-color: #9d3dcb;
    }

    ul.pagination li {
        font-size: 18px;
    }

    ul.pagination li a, ul.pagination li a:hover {
        color: #9d3dcb;
    }

    ul.pagination li.active a {
        background-color: #9d3dcb;
        border-color: #9d3dcb;
    }

    ul.pagination li.active a:hover {
        background-color: #8f30b8;
        border-color: #9d3dcb;
    }
</style>

<section id="research" style="padding-top: 80px">
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-8 col-lg-offset-2">
                <h3 style="margin-top: 50px;">{str('menu_research')}</h3>

                <form action="{url('/researches.php')}" method="get">
                    <div class="row" style="margin-bottom: 20px;">
                        <div class="col-md-6">
                            {$HTMLCategoriesDropDown}
                        </div>
                        <div class="col-md-6">
                            <div class="input-group">
                                <div class="input-group-addon"><i class="fa fa-search"></i></div>
                                <input title="{str('research_title')}" type="text" name="keyword" value="{$keyword}" class="form-control" placeholder="{str('research_search')}">
                            </div>
                        </div>
                        <div class="container-fluid text-right" style="margin-top: 40px;">
                            <button type="submit" class="btn btn-success"><i class="fa fa-search"></i> {str('search')}</button>
                        </div>
                    </div>
                </form>

                {if count($researches) == 0}
                    <div class="alert alert-warning">
                        {str('research_result_not_found')}
                    </div>
                {else}{foreach $researches as $research}
                    <blockquote class="faq">
                        <h3><a href="{url('/research.php?id=')}{$research->id}">{$research->name}</a></h3>
                        <div>
                            <strong>{str('research_type')}</strong>{$research->category->name}
                        </div>
                        <div>
                            <strong>{str('research_author')}</strong>{$research->researcherName}
                        </div>
                        <div>
                            <strong>{str('research_organization')}</strong>{$research->organization->name}
                        </div>
                    </blockquote>
                {/foreach}{/if}
            </div>
        </div>
    </div>
</section>