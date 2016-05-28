
    <div class="row x-PT20">
        <div class="col-xs-12 x-titles">
            <div class="grid col-lg-3 col-md-3 col-sm-4 col-xs-6 x-noP">
                <a href="../browse-jobs/?l=England##by-job-location" title="England">England</a></td>
            </div>
            <div class="grid col-lg-3 col-md-3 col-sm-4 col-xs-6 x-noP">
                <a href="../browse-jobs/?l=Northern+Ireland##by-job-location" title="Jobs in Northern Ireland">Northern Ireland</a>
            </div>
            <div class="grid col-lg-3 col-md-3 col-sm-4 col-xs-6 x-noP">
                <a href="../browse-jobs/?l=Scotland##by-job-location" title=" Jobs in Northern Ireland">Scotland</a>
            </div>
            <div class="grid col-lg-3 col-md-3 col-sm-4 col-xs-6 x-noP">
                <a href="../browse-jobs/?l=Wales##by-job-location" title="Jobs in Wales">Wales</a>
            </div>
        </div>
    </div>

    <div class="row x-PT20">
        <div class="col-xs-12 x-titles">
            <cfoutput query="cities">
            <div class="grid col-lg-3 col-md-3 col-sm-4 col-xs-6 x-noP">
                <a href="../jobs/?l=#city#, #url.l#">#city#</a>
            </div>
            </cfoutput>
        </div>
    </div>
