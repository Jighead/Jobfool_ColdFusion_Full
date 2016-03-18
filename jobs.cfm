<cfparam name="noreturn" default="false">
<cfparam name="url.kw" default="developer">
<cfset intStartTime = GetTickCount() />
<cfparam name="url.l" default="New York, NY">
<cfparam name="url.co" default="US">
<cfparam name="url.sb" default="">
<cfparam name="url.radius" default="50">
<cfparam name="request.grecords" default="0">
<cfparam name="url.qt" default="10"><!--- qty per page --->
<cfparam name="url.p" default="1"><!--- default page were on --->
<cfparam name="url.st" default="1"><!--- default start row were on --->
<cfparam name="url.from" default="90"><!--- default start row were on --->
<cfset url.fromage = url.from>
<cfparam name="request.intotalrecords" default="">
<cfset foo = randrange(1, 10)>
    
<cfif len(url.kw) GT 0>
    <cfinvoke component="components.ijson" method="getJobs" returnvariable="results"  argumentcollection="#url#">
        <cfset total = results.totalResults>

        <script>
            var results = {};
            results.total = <cfoutput>#total#</cfoutput>;
        </script>
</cfif>   



<!DOCTYPE html> 
<html lang="en"> 
    <head> 
        <meta charset="utf-8"> 
        <meta http-equiv="X-UA-Compatible" content="IE=edge"> 
        <meta name="viewport" content="width=device-width, initial-scale=1"> 
        <meta name="description" content=""> 
        <meta name="author" content=""> 
        <title>Jobs</title>         
        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->         
        <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->         
        <!-- Web Fonts -->         
        <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic|Abril Fatface|Oswald:700,400,300|Montserrat:400,700|Open+Sans:400,600,700,800,300italic,400italic,600italic,700italic,800italic|Rokkitt:400,700|Cantarell:400,700|<link Roboto+Slab:400,700,300|Open+Sans:400,800italic,800,700italic,600|Alfa+Slab+One|Play"> 
        <!-- CSS Global Compulsory -->         
        <link rel="stylesheet" href="/assets/plugins/bootstrap/css/bootstrap.min.css"> 
        <link href="bootstrap/css/offcanvas.css" rel="stylesheet"> 
        <link rel="stylesheet" href="/assets/plugins/animate.css"> 
        <link rel="stylesheet" href="/assets/plugins/line-icons/line-icons.css"> 
        <link rel="stylesheet" href="/assets/plugins/font-awesome/css/font-awesome.min.css"> 
        <link rel="stylesheet" href="/assets/css/app.css">
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
        <section class="x-searchbar-jobs x-gradient" data-pg-name="Search Bar">
            <div class="container"> 
                <div class="row" data-pg-name="Row-Searchbar"> 
                    <form method="get" action="jobs.cfm"> 
                        <div class="col-sm-5 x-reducepad-5"> 
                            <div class="input-group"> 
                                <span class="input-group-addon"><i class="fa fa-lg fa-tag x-blue"></i></span> 
                                <input type="text" name="kw" id="x-what" placeholder="what job you are looking for" class="form-control x-what"> 
                            </div>                             
                        </div>                         
                        <div class="col-sm-5 x-reducepad-5"> 
                            <div class="input-group"> 
                                <span class="input-group-addon"><i class="fa fa-lg fa-map-marker x-red"></i></span> 
                                <input type="text" name="l" id="x-where" placeholder="where would you like to work" class="form-control x-where"> 
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
        <section id="content-section" class="x-contentpattern"> 
            <div class="container x-result-bar"> 
                <div class="row" data-pg-name="Row-Result"> 
                    <div class="col-xs-12 text-left x-results"> 
                    <cfif results.totalResults GT 0 >
                    <cfoutput>
                        Showing 1 - 10 of #results.totalResults#
                        <h1 class="x-jobtitle">#results.query#</h1> jobs near #results.location#
                    </cfoutput>
                    </cfif>
                        <div class="col-xs-12 x-dashline"></div>                         
                    </div>                     
                </div>                 
            </div>
            <!-- //container -->             
        </section>
        <section>
            <div class="container x-content"> 
                <div class="row x-content row-offcanvas row-offcanvas-right" data-pg-name="Row:Content"> 
                    <div class="col-lg-8 col-md-8 col-sm-8 col-xs-12" data-pg-name="Col-Main Content"> 
                        <div id="job-well" class="x-job-well"> 
                            <cfoutput>
                            <cfloop array="#results.results#" index="item"> 
                            <div class="x-well"> 
                                <p class="x-serptitle"><a href="/jobs/view.cfm?do=1&amp;jobid=">#item.jobtitle#</a></p> 
                                <p class="x-serpsnip">#item.snippet#</p> 
                                <p class="x-serpcompany">#item.company#</p>
                                <p class="x-serplocation" itemtype="http://schema.org/Postaladdress">
                                    <a href="index.cfm/kw/#url.kw#/l/#item.formattedLocationFull#/">#item.formattedLocationFull#</a></p>
                                <p class="x-serppostee">#item.formattedRelativeTime#</p> 
                            </div>
                            </cfloop>
                            </cfoutput>                     
                        </div>
                        <div class=".x-pagination col-xs-12">
                            <div id='pagi' class="pagination-sm"></div>  
                        </div>
                    </div>                     
                    <!--                <div class="ads col-sm-3">
                <p>an ad</p>
                <p>an ad</p>
                <p>an ad</p>
                    <p>an ad</p>
                    <p>an ad</p>
                    <p>an ad</p>
                    <p>an ad</p>
                </div>-->                     
                    <div id="x_filters" class="sidebar-offcanvas col-xs-4" data-pg-name="Col-Filters"> 
                        <div class="x-emailform row" role="form"> 
                            <div class="col-xs-12">
                                <label for="email">Send me these jobs</label>
                            </div>                             
                            <div class="col-xs-12 col-sm-9">
                                <input type="text" id="email" class="form-control" placeholder="enter email address">
                            </div>
                            <div class="col-xs-12 col-sm-3 x-noPL-md x-noPL-lg">
                                <button id="addemail" class="btn btn-primary x-btn-addemail form-control">Send</button>
                            </div>                             
                        </div>                         
                        <h5>Nearby Cities</h5> 
                        <ul class="x-list-unstyled"> 
                            <li> 
                                <a href="#">Example 1 with a long city name</a> 
                            </li>                             
                            <li> 
                                <a href="#">Example 1</a> 
                            </li>                             
                            <li> 
                                <a href="#">Example 1</a> 
                            </li>                             
                            <li> 
                                <a href="#">Example 1</a> 
                            </li>                             
                        </ul>                         
                        <h5>Employers</h5> 
                        <ul class="x-list-unstyled"> 
                            <li> 
                                <a href="#">Example 1 with a long employer name</a> 
                            </li>                             
                            <li> 
                                <a href="#">Example 1</a> 
                            </li>                             
                            <li> 
                                <a href="#">Example 1</a> 
                            </li>                             
                            <li> 
                                <a href="#">Example 1</a> 
                            </li>                             
                        </ul>                         
                        <!--<h5>Salaries</h5>
                    <ul class="x-list-unstyled">
                        <li>
                            <a href="#">Example 1</a>
                        </li>
                        <li>
                            <a href="#">Example 1</a>
                        </li>
                        <li>
                            <a href="#">Example 1</a>
                        </li>
                        <li>
                            <a href="#">Example 1</a>
                        </li>                         
                    </ul>-->                         
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
                                <img src="assets/images/icons/ca.png" class="flag">
                                <a href="#">Canada</a>
                            </li>                             
                            <li>
                                <img src="assets/images/icons/fr.png" class="flag">
                                <a href="#">France</a>
                            </li>                             
                            <li>
                                <img src="assets/images/icons/de.png" class="flag">
                                <a href="#">Germany</a>
                            </li>                             
                            <li>
                                <img src="assets/images/icons/es.png" class="flag">
                                <a href="#">Spain</a>
                            </li>                             
                            <li>
                                <img src="assets/images/icons/uk.png" class="flag">
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
                        <!--<div class="col-md-4">
						<ul class="list-inline dark-social pull-right space-bottom-0">
							<li>
								<a data-placement="top" data-toggle="tooltip" class="tooltips" data-original-title="Facebook" href="#">
									<i class="fa fa-facebook"></i>
								</a>
							</li>
							<li>
								<a data-placement="top" data-toggle="tooltip" class="tooltips" data-original-title="Twitter" href="#">
									<i class="fa fa-twitter"></i>
								</a>
							</li>
							<li>
								<a data-placement="top" data-toggle="tooltip" class="tooltips" data-original-title="Vine" href="#">
									<i class="fa fa-vine"></i>
								</a>
							</li>
							<li>
								<a data-placement="top" data-toggle="tooltip" class="tooltips" data-original-title="Google plus" href="#">
									<i class="fa fa-google-plus"></i>
								</a>
							</li>
							<li>
								<a data-placement="top" data-toggle="tooltip" class="tooltips" data-original-title="Pinterest" href="#">
									<i class="fa fa-pinterest"></i>
								</a>
							</li>
							<li>
								<a data-placement="top" data-toggle="tooltip" class="tooltips" data-original-title="Instagram" href="#">
									<i class="fa fa-instagram"></i>
								</a>
							</li>
							<li>
								<a data-placement="top" data-toggle="tooltip" class="tooltips" data-original-title="Tumblr" href="#">
									<i class="fa fa-tumblr"></i>
								</a>
							</li>
							<li>
								<a data-placement="top" data-toggle="tooltip" class="tooltips" data-original-title="Youtube" href="#">
									<i class="fa fa-youtube"></i>
								</a>
							</li>
							<li>
								<a data-placement="top" data-toggle="tooltip" class="tooltips" data-original-title="Soundcloud" href="#">
									<i class="fa fa-soundcloud"></i>
								</a>
							</li>
						</ul>
					</div>-->                         
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
        <script type="text/javascript" src="/assets/js/jquery.twbsPagination.js"></script>
        <script type="text/javascript">
        jQuery(document).ready(function() {
            App.init();
            
            $('#pagi').twbsPagination({
              totalPages: 100,
              visiblePages: 5,
              href: '?p/{{number}}/kw/java/l/dallas/',
              onPageClick: function (event, page) {
                $('#page-content').text('Page ' + page);

              }
            }); 
        }); // end doc ready
            
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
