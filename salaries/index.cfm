<!--- TODO: Build out this page   / front end. Back end is complete 
            A bootstrap progress bar graph seems like a good idea.
--->
<cfparam name="url.qry" default="ux developer">
<cfparam name="url.loc" default="chicago">
<cfinvoke component="components.salarysearch" method="getSalary" argumentcollection="#url#" returnvariable="results">
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->
<!--[if !IE]><!--> 
<html lang="en"> 
    <!--<![endif]-->
    <head>
        <title>Job Search</title>
        <!-- Meta -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">
        <!-- Favicon -->
        <link rel="shortcut icon" href="favicon.ico">
        <!-- Web Fonts -->
        <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic|Abril Fatface|Oswald:700,400,300|Montserrat:400,700|Open+Sans:400,600,700,800,300italic,400italic,600italic,700italic,800italic|Rokkitt:400,700|Cantarell:400,700|<link Roboto+Slab:400,700,300|Open+Sans:400,800italic,800,700italic,600|Alfa+Slab+One|Play">
        <!-- CSS Global Compulsory -->
        <link rel="stylesheet" href="/assets/plugins/bootstrap/css/bootstrap.min.css">
        <link href="/bootstrap/css/offcanvas.css" rel="stylesheet">
        <link href="/assets/css/grid-ms.css" rel="stylesheet">
        <!--all Styles -->
        <link rel="stylesheet" href="/assets/css/app.css">
        <!-- CSS Implementing Plugins -->
        <link rel="stylesheet" href="/assets/plugins/owl-carousel/owl-carousel/owl.carousel.css">
        <link rel="stylesheet" href="/assets/plugins/animate.css">
        <link rel="stylesheet" href="/assets/plugins/line-icons/line-icons.css">
        <link rel="stylesheet" href="/assets/plugins/font-awesome/css/font-awesome.min.css">
        <link rel="stylesheet" href="/assets/plugins/animated-headline/css/animated-headline.css">
    </head>
	<body class="x-home header-fixed">
    <cfinclude template="/partials/header.cfm">

        <section class="x-searchbar-jobs x-contentpattern">
            <div class="container"> 
                <div class="row" data-pg-name="Row-Searchbar"> 
                    <form method="get" action=""> 
                        <div class="col-sm-5 x-reducepad-5"> 
                            <div class="input-group"> 
                                <span class="input-group-addon"><i class="fa fa-lg fa-tag x-blue"></i></span> 
                                <input type="text" name="qry" value="<cfoutput>#url.qry#</cfoutput>" id="x-what" placeholder="what" class="form-control x-what"> 
                            </div>                             
                        </div>                         
                        <div class="col-sm-5 x-reducepad-5"> 
                            <div class="input-group"> 
                                <span class="input-group-addon"><i class="fa fa-lg fa-map-marker x-red"></i></span> 
                                <input type="text" name="loc" value="<cfoutput>#url.loc#</cfoutput>"id="x-where" placeholder="where" class="form-control x-where"> 
                            </div>                             
                        </div>                         
                        <div class="col-sm-2 x-reducepad-5"> 
                            <button id="x_search-form" class="form-control inline-block btn-primary x-search-btn">Show Salaries</button>
                        </div>                         
                    </form>                     
                </div>                 
            </div> <!-- //container -->   
        </section>
        <section id="content-section"> 
            <div class="container x-result-bar"> 
                <div class="row" data-pg-name="Row-Result"> 
                    <div class="col-xs-12 text-left x-results"> 
                    <cfif arrayLen(results) GT 0 >
                    <cfoutput>
                        Showing Average Salaries in USD
                        <cfif len(url.qry)>for <h1 class="x-jobtitle">#url.qry#</h1></cfif>
                        <cfif len(url.loc)>near <strong>#url.loc#</strong></cfif>
                    </cfoutput>
                    </cfif>
                        <div class="col-xs-12 x-dashline"></div>                         
                    </div>                     
                </div>                 
            </div>
            <!-- //container -->             
        </section>
        <section id="content-section" class="x-salary-results x-PT20"> 
            <div class="container"> 
                <div class="row" data-pg-name="salary-results"> 
                    <div class="col-xs-6 text-left">
                        <cftry> 
                        <cfloop array="#results#" index="item">
                            <cfoutput><!--- #item.jobtitle_link_text# #item.salary_price_source# --->
                            <cfset percent = (item.salary_price / 1000) / 2 >
                            <cfif percent GT 100><cfset percent = 100 /></cfif>

                            <cfset string = replace(item.jobtitle_link_text, " in ", " | ", "all") />

                            <cfset url.kw = trim(listFirst(string, "|")) />
                            <cfif string contains "|">
                                <cfset url.l = trim(listLast(string, "|")) />
                            <cfelse>
                                <cfset url.l = ''>
                            </cfif>

                            <div><a href="/jobs/?kw=#url.kw#&l=#url.l#" title="Find #item.jobtitle_link_text#">#item.jobtitle_link_text#</a></div>
                            <div class="progress">
                              <div class="progress-bar progress-bar-info" role="progressbar"  aria-valuenow="#item.salary_price_source#" 
                              style="width:#percent#%">
                               #item.salary_price_source#
                              </div>
                            </div>
                            </cfoutput>
                        </cfloop>
                             <cfcatch><p>No Data Available</p></cfcatch>
                        </cftry> 
                    </div>                     
                </div>                 
            </div>
            <!-- //container -->             
        </section>
        <cfinclude template="/partials/footer.cfm">

        <script type="text/javascript" src="/assets/plugins/jquery/jquery.min.js"></script>
        <script type="text/javascript" src="/assets/plugins/jquery/jquery-migrate.min.js"></script>
        <script type="text/javascript" src="/assets/plugins/bootstrap/js/bootstrap.min.js"></script>
        <!-- JS Implementing Plugins -->
        <script type="text/javascript" src="/assets/plugins/back-to-top.js"></script>
        <script type="text/javascript" src="/assets/plugins/smoothScroll.js"></script>
        <script type="text/javascript" src="/assets/plugins/jquery.parallax.js"></script>
        <script type="text/javascript" src="/assets/plugins/owl-carousel/owl-carousel/owl.carousel.js"></script>
        <script type="text/javascript" src="/assets/plugins/counter/waypoints.min.js"></script>
        <script type="text/javascript" src="/assets/plugins/counter/jquery.counterup.min.js"></script>
        <script type="text/javascript" src="/assets/plugins/wow-animations/js/wow.min.js"></script>
        <script src="/assets/plugins/animated-headline/js/animated-headline.js"></script>         
        <script src="/assets/plugins/animated-headline/js/modernizr.js"></script>
        <!-- JS Page Level -->
        <script type="text/javascript" src="assets/js/unify-app.js"></script>
        <script type="text/javascript">
        jQuery(document).ready(function() {
            App.init();


        });
            
        $('#x_search-form').submit(function(e){
          e.preventDefault();
        });   
             
        </script>
        <!--[if lt IE 9]>
	<script src="assets/plugins/respond.js"></script>
	<script src="assets/plugins/html5shiv.js"></script>
	<script src="assets/plugins/placeholder-IE-fixes.js"></script>
	<![endif]-->
	</body>
</html>














