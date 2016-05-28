                        <cfif len(url.l) GTE 4 and not isNumeric(url.l)>
                            <div class="row x-PT20">
                                <div class="col-xs-12 x-titles">
                                    <cfoutput query="cities">
                                    <div class="grid col-lg-3 col-md-3 col-sm-4 col-xs-6 x-noP">
                                        <a href="../jobs/?l=#city#, #url.l#">#city#</a>
                                    </div>
                                    </cfoutput>
                                </div>
                            </div>
                        <cfelse>
                            <div class="row x-PT20">
                                <div class="col-xs-12 x-titles">
                                    <cfoutput query="states">
                                    <div class="grid col-lg-3 col-md-3 col-sm-4 col-xs-6 x-noP">
                                        <a href="../browse-jobs/?l=#state###by-job-location">#state#</a>
                                    </div>
                                    </cfoutput>
                                </div>
                            </div>
                        </cfif>  