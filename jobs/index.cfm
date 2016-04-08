<cfheader name="Cache-Control" value="max-age=3600">

<cfsilent>      
<cfinclude template="../meta/newlogic.cfm">
<cfparam name="results.totalresults" default="0">
<cfparam name="results.total" default="0">
<cfparam name="results.query" default="">
<cfparam name="results.location" default="">
<cfparam name="url.qt" default="10">  
<cfif len(url.kw) GT 2 or len(url.l) GT 2>
    <cfinvoke component="components.ijson" method="getJobs" returnvariable="results"  argumentcollection="#url#">
        <cfset total = results.totalResults>
<!---   <script>
            var results = {};
            results.total = <cfoutput>#results.totalResults#</cfoutput>;
            results.kw = <cfoutput>"#url.kw#"</cfoutput>;
            results.l = <cfoutput>"#url.l#"</cfoutput>;
            var uri = {
                kw: '<cfoutput>#url.kw#</cfoutput>',
                l: '<cfoutput>#url.l#</cfoutput>',
                p: '<cfoutput>#url.p#</cfoutput>',
                st: '<cfoutput>#url.st#</cfoutput>'
            }
        </script> --->
  
</cfif> 
</cfsilent>

<!--- cfdump var="#url#">
<cfoutput>#cgi.query_string#</cfoutput><cfabort> --->
<!--- <cfdump var="#results#"> --->
    
<!--- ================================================================================================================ --->
<!DOCTYPE html> 
<html lang="en"> 
    <head>
        <meta charset="utf-8"> 
        <meta http-equiv="X-UA-Compatible" content="IE=edge"> 
        <meta name="viewport" content="width=device-width, initial-scale=1"> 
        
		<cfinclude template="../meta/head.cfm">      
        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->         
        <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->         
        <!-- Web Fonts -->         
        <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic|Abril Fatface|Oswald:700,400,300|Montserrat:400,700|Open+Sans:400,600,700,800,300italic,400italic,600italic,700italic,800italic|Rokkitt:400,700|Cantarell:400,700|<link Roboto+Slab:400,700,300|Open+Sans:400,800italic,800,700italic,600|Alfa+Slab+One|Play"> 
        <!-- CSS Global Compulsory -->         
        <link rel="stylesheet" href="/assets/plugins/bootstrap/css/bootstrap.min.css"> 
        <link href="/bootstrap/css/offcanvas.css" rel="stylesheet"> 
        <link rel="stylesheet" href="/assets/plugins/animate.css"> 
        <link rel="stylesheet" href="/assets/plugins/line-icons/line-icons.css"> 
        <link rel="stylesheet" href="/assets/plugins/font-awesome/css/font-awesome.min.css"> 
        <link rel="stylesheet" href="/assets/css/app.css">   
            
            <STYLE>
                #adcontainer3-16 {
                    overflow:hidden;
                }
                #adcontainer3-16 iframe {
                    position: relative;
                    left: -140px;
                    top: -20px;
                }
            </STYLE>
            
    <script type="text/javascript" charset="utf-8">
      (function(G,o,O,g,L,e){G[g]=G[g]||function(){(G[g]['q']=G[g]['q']||[]).push(
       arguments)},G[g]['t']=1*new Date;L=o.createElement(O),e=o.getElementsByTagName(
       O)[0];L.async=1;L.src='//www.google.com/adsense/search/async-ads.js';
      e.parentNode.insertBefore(L,e)})(window,document,'script','_googCsa');
    </script>
            
            
    </head>     
    <body class="header-fixed"> 
        <header> 
            <div class="header header-v6"> 
                <div class="container" data-pg-name="Container-Outer Main"> 
                    <div class="row x-logorow" data-pg-name="Row-Logo bar"> 
                        <div class="navbar-brand"> 
                            <div class="col-xs-12 homelogo"> 
                                <a class="x-homelink" href="/"> 
                                    <div class="x-text-logo">
                                        <h1><span class="x-job">JOB</span><span class="x-fool">FOOL</span></h1>
                                    </div>                                     
                                </a>                                 
                            </div>                             
                        </div>
                        <!-- Header Inner Right -->
                        <div class="header-inner-right">
                            <ul class="menu-icons-list visible-xs">
                                <li>
                                    <button type="button" class="btn x-siderbar-toggle" data-toggle="offcanvas">
                                        <i class="fa fa-lg fa-navicon"></i>
                                    </button>
                                </li>
                            </ul>
                        </div>
                        <!-- End Header Inner Right -->
                    </div>                     
                </div>                 
            </div>             
        </header>
        <section class="x-searchbar-jobs x-contentpattern" data-pg-name="Search Bar">
            <div class="container"> 
                <div class="row" data-pg-name="Row-Searchbar"> 
                    <form method="get" action="/jobs/">

                        <div class="col-sm-5 x-reducepad-5"> 
                            <div class="input-group"> 
                                <span class="input-group-addon"><i class="fa fa-lg fa-tag x-blue"></i></span> 
                                <input type="text" name="kw" value="<cfoutput>#url.kw#</cfoutput>" id="x-what" placeholder="what job you are looking for" class="form-control x-what"> 
                            </div>                             
                        </div>                         
                        <div class="col-sm-5 x-reducepad-5"> 
                            <div class="input-group"> 
                                <span class="input-group-addon"><i class="fa fa-lg fa-map-marker x-red"></i></span> 
                                <input type="text" name="l" value="<cfoutput>#url.l#</cfoutput>"id="x-where" placeholder="where would you like to work" class="form-control x-where"> 
                            </div>                             
                        </div>                         
                        <div class="col-sm-2 x-reducepad-5"> 
                            <button id="x_search-form" class="form-control inline-block btn-primary x-search-btn">Find a Job</button>
                        </div>                         
                    </form>                     
                </div>                 
            </div>           
            <!-- //container -->             
        </section>      
        <section id="content-section"> 
            <div class="container x-result-bar"> 
                <div class="row" data-pg-name="Row-Result"> 
                    <div class="col-xs-12 text-left x-results"> 
                    <cfif results.totalResults GT 0 >
                    <cfset showst = url.st> 
					<cfset showend = showst + request.perpage>
                        <cfif results.totalresults LT  showend><cfset showend = results.totalresults></cfif>
                    <cfoutput>
                        Showing #showst# - #showend# of #results.totalResults#
                        <cfif len(results.query) and results.query neq 'in'><h1 class="x-jobtitle">#results.query#</h1></cfif> jobs
                        <cfif len(results.location)> 
                            near #results.location# 
                        </cfif>
                    </cfoutput>
                    </cfif>
                        <div class="col-xs-12 x-dashline"></div>                         
                    </div>                     
                </div>                 
            </div>
            <!-- //container -->             
        </section>
        <section>
            <div class="container x-content" style="min-height:800px;"> 
                <div class="row x-content row-offcanvas row-offcanvas-right" data-pg-name="Row:Content"> 
                    <div class="col-xs-9 col-md-6" data-pg-name="Col-Main Content">
                        <div class="ads col-sm-2" id="adcontainer2-16">
                        <!--- above search results ads --->
                        </div>  
                        <div id="job-well" class="x-job-well"> 
                            <cfinclude template="../partials/jobs-jobwell.cfm">
                        </div> 
                        <div class="x-ads" id="adcontainer3-16">
                        <!--- below search results ads --->
                        </div>
                        <div class=".x-pagination col-xs-12 x-noPL">
                            <cfmodule template="/system/customtags/pagination.cfm" recordcount="#results.totalResults#" perpage="10" p="#url.p#">
                        </div>
                    </div>
                    <div class="ads col-xs-3 hidden-sm hidden-xs x-noPL x-noPR" id="adcontainer1-16">
                    <!--- right side Ad column ---> 
                    </div>          
                    <div id="x_filters" class="col-xs-3 sidebar-offcanvas" data-pg-name="Col-Filters"> 
                        <cfoutput>
                        <div class="x-emailform row" role="form"> 
                            <div class="col-xs-12">
                                <label for="email">Send me these jobs</label>
                            </div>                             
                            <div class="col-xs-12">
                                <input type="text" id="email" class="input form-control" placeholder="enter email address">
                                <button id="addemail" class="btn btn-primary x-btn-addemail form-control">Send</button>
                            </div>                             
                        </div>
                        <cfinclude template="../partials/jobs-cityfilter.cfm">
                        <cfinclude template="../partials/jobs-companyfilter.cfm">
                       </cfoutput>
                    </div>
                 
                </div>                 
            </div>
            <!-- //container -->             
        </section>         
        <!--
<footer class="x-gradient">
            <div class="container">
                <div class="row x-footer" data-pg-name="Row-Footer">
                    <div class="col-xs-12 text-center">
                        <a href="#">Browse Jobs By Employer</a> | <a href="#">Browse Jobs By Location</a> | <a href="#">Browse Jobs Catergory</a>
                    </div>
                </div>
                <div class="row x-subfooter" data-pg-name="Row-Footer">
                    <div class="col-xs-12 text-center">
                        <p>2016 © All Rights Reserved. JobFool Inc. | <a href="#">Privacy Policy</a> | <a href="#">Terms of Service</a></p>
                    </div>
                </div>
            </div> //container 
        </footer>
-->         
        <!--=== Footer v6 ===-->         
        <div id="footer-v6" class="footer-v6"> 
            <div class="footer"> 
                <div class="container"> 
                    <div class="row"> 
                        <div class="col-xs-12"> 
                            <ul class="list-inline browse-list"> 
                                <li>
                                    <a href="#">Job Search By Job Catergory</a>
                                </li>                                 
                                <li>
                                    <a href="#">Job Search By Location</a>
                                </li>                                 
                                <li class="silver">
                                    <a href="#">Job Search By Employer</a>
                                </li>                                 
                            </ul>                             
                        </div>                         
                    </div>                     
                    <div class="row"> 
                        <ul class="list-inline country-list"> 
                            <li>
                                <img src="/assets/images/icons/ca.png" class="flag">
                                <a href="#">Canada</a>
                            </li>                             
                            <li>
                                <img src="/assets/images/icons/fr.png" class="flag">
                                <a href="#">France</a>
                            </li>                             
                            <li>
                                <img src="/assets/images/icons/de.png" class="flag">
                                <a href="#">Germany</a>
                            </li>                             
                            <li>
                                <img src="/assets/images/icons/es.png" class="flag">
                                <a href="#">Spain</a>
                            </li>                             
                            <li>
                                <img src="/assets/images/icons/uk.png" class="flag">
                                <a href="#">United Kingdom</a>
                            </li>                             
                        </ul>                         
                    </div>                     
                </div>                 
            </div>             
            <div class="copyright"> 
                <div class="container"> 
                    <div class="row"> 
                        <div class="col-xs-12 sm-margin-bottom-10"> 
                            <ul class="list-inline terms-menu"> 
                                <li class="silver">Copyright © 2006-2016 | All Rights Reserved</li>                                 
                                <li>
                                    <a href="#">Terms of Use</a>
                                </li>                                 
                                <li>
                                    <a href="#">Privacy and Policy</a>
                                </li>                                 
                            </ul>                             
                        </div>                         
                         
                    </div>                     
                </div>                 
            </div>             
        </div>         
        <!--=== End Footer v6 ===-->         
        <!-- JS Global Compulsory -->         
        <script type="text/javascript" src="/assets/plugins/jquery/jquery.min.js"></script>         
        <script type="text/javascript" src="/assets/plugins/jquery/jquery-migrate.min.js"></script>         
        <script type="text/javascript" src="/assets/plugins/bootstrap/js/bootstrap.min.js"></script>         
        <!-- JS Implementing Plugins -->
        <script type="text/javascript" src="/bootstrap/js/offcanvas.js"></script>
        <script type="text/javascript" src="/assets/plugins/back-to-top.js"></script>         
        <script type="text/javascript" src="/assets/plugins/smoothScroll.js"></script>         
        <!-- JS Page Level -->         
        <script type="text/javascript" src="/assets/js/unify-app.js"></script>
        <script>
        $(document).ready(function($){
            App.init();
            
            $("#x_filters a").each(function() {
                var text = $(this).attr('href')
                text = text.replace(/ /g, "+");
                $(this).prop('href',text);
                });
            
            $(".sfblAd").css("display","none");

            
        });
        </script>    
        <!--[if lt IE 9]>
	<script src="assets/plugins/respond.js"></script>
	<script src="assets/plugins/html5shiv.js"></script>
	<script src="assets/plugins/placeholder-IE-fixes.js"></script>
	<![endif]-->     
                     
                     
<cfif len(url.kw) LT 3>
    <cfset adquery="work from home">
<cfelse>
    <cfset adquery = "#url.kw#">
</cfif>
<script type="text/javascript" charset="utf-8"> 
    
var pageOptions = { 
  'pubId': 'pub-2780853858393535',
  'query': '<cfoutput>#adquery#</cfoutput>',
  'hl': 'en',
  'adtest': 'on',
  'adPage': 1,
  'location': false,
  'plusOnes': false,
  'sellerRatings': false,
  'siteLinks': false
};

var adblock1 = { 
  'container': 'adcontainer1-16',
  'number': 6,
  //'width': 'auto',
  'fontFamily': 'Lato',
  'fontSizeTitle': 16,
  'fontSizeDescription': 14,
  'fontSizeDomainLink': 10,
  'colorTitleLink': '#337AB7',
  'colorText': '#555555',
  'colorDomainLink': '#337AB7',
  'noTitleUnderline': true
};

var adblock2 = { 
  'container': 'adcontainer2-16',
  'number': 1,
  'width': 'auto',
  'lines': 2,
  'fontFamily': 'Lato',
  'fontSizeTitle': 16,
  'fontSizeDescription': 14,
  'fontSizeDomainLink': 10,
  'colorTitleLink': '#337AB7',
  'colorText': '#555555',
  'colorDomainLink': '#337AB7',
  'noTitleUnderline': true,
  'longerHeadlines': true,
  'detailedAttribution': false
};

var adblock3 = { 
  'container': 'adcontainer3-16',
  'width': '700px',
  'lines': 2,
  'fontFamily': 'Lato',
  'fontSizeTitle': 16,
  'fontSizeDescription': 14,
  'fontSizeDomainLink': 10,
  'colorTitleLink': '#337AB7',
  'colorText': '#555555',
  'colorDomainLink': '#337AB7',
  'noTitleUnderline': true,
  'longerHeadlines': true,
  'detailedAttribution': false
};

_googCsa('ads', pageOptions, adblock1, adblock2, adblock3);

</script>



    </body>     
</html>
