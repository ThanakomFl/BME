<div style="margin-top: 100px;" ng-app="angularApp">
    <div class="container-fluid" style="padding: 0 20px;">
        <h2>
            <i class="fa fa-files-o"></i>
            {if $mode == constant('DOCUMENT_MODE_DOCUMENT')}
                {str('documents')}
            {elseif $mode == constant('DOCUMENT_MODE_REPORT')}
                {str('reports')}
            {/if}
        </h2>
        <app-documents mode="{$mode}"></app-documents>
    </div>
</div>
