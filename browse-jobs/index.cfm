<cfsilent>
<cfparam name="url.kw" default="">
<cfparam name="url.l" default="">
<cfparam name="url.tl" default="A">
<cfparam name="thistitle" default="Find Jobs" />
    
<cfif isdefined('url.tl')>
	<cfquery name="getTitles" datasource="#request.dsn#" username="#request.dbuser#" password="#request.dbpass#">
	select jobtitle, id
	from jobtitles
	where jobtitle like <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim('#url.tl#%')#" />
	order by jobtitle
	</cfquery>	
	<cfset thistitle = "#gettitles.jobtitle# - Jobs by Title">
</cfif>
    
<cfparam name="qrydata.recordcount" default="0" >
</cfsilent>
    
    
    
<!--- <cfdump var="#getTitles#"> --->
    
<!--- ================================================================================================================ --->
<!DOCTYPE html> 
<html lang="en"> 
    <head>
        <title>Find jobs | TheJobFool.com</title>
        <meta name="description" content="Find jobs. TheJobFool.com One search thousands of jobs." />
        <meta name="keywords" content="Find jobs browse jobs find jobs by title by company by state by category job search tools job search engine jobs career employment search all jobs the job fool thejobfool thejobfool.com" />
        <meta charset="utf-8"> 
        <meta http-equiv="X-UA-Compatible" content="IE=edge"> 
        <meta name="viewport" content="width=device-width, initial-scale=1">            
        <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->               
        <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic|Abril Fatface|Oswald:700,400,300|Montserrat:400,700|Open+Sans:400,600,700,800,300italic,400italic,600italic,700italic,800italic|Rokkitt:400,700|Cantarell:400,700|<link Roboto+Slab:400,700,300|Open+Sans:400,800italic,800,700italic,600|Alfa+Slab+One|Play|Bevan"> 
        <!-- CSS Global Compulsory -->         
        <link rel="stylesheet" href="/assets/plugins/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="/assets/plugins/animate.css"> 
        <link rel="stylesheet" href="/assets/plugins/line-icons/line-icons.css"> 
        <link rel="stylesheet" href="/assets/plugins/font-awesome/css/font-awesome.min.css"> 
        <link rel="stylesheet" href="/assets/css/app.css">
        <link rel="stylesheet" href="/assets/css/u-dark-blue.css">
            
            <STYLE>
                #adcontainer2-16, #adcontainer3-16 {
                    /*overflow:hidden;*/
                }
                #adcontainer2-16 iframe {
                    position: relative;
                    left: -140px;
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
<cfinclude template="../partials/header.cfm" />
<cfinclude template="../partials/searchform.cfm" />
<section>
<div class="container">
    <div class="row">
        <div class="col-xs-12">

            <div class="tab-v1">
                <ul class="nav nav-tabs">
                    <li class="active"><a href="#home" data-toggle="tab" aria-expanded="true">Jobs By Location</a></li>
                    <li class=""><a href="#byTitle" data-toggle="tab" aria-expanded="false">Jobs By Job Title</a></li>
                    <li class=""><a href="#bycategory" data-toggle="tab" aria-expanded="false">Jobs By Category</a></li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane fade active in" id="home">
                        <div class="row">
                            <div class="col-xs-12">
                                <cfinclude template="../partials/browse-jobs-bylocation.cfm">
                            </div>
                        </div>
                    </div>


                    <div class="tab-pane fade" id="byTitle">
                        <div class="row">
                        <div class="col-xs-4 grid x-noPR"> 
                        <a href="job-title.cfm/tl/a"><button class="btn-primary">A</button></a> 
                        <a href="job-title.cfm/tl/a"><button class="btn-primary">B</button></a> 
                        <a href="job-title.cfm/tl/c"><button class="btn-primary">C</button></a> 
                        <a href="job-title.cfm/tl/d"><button class="btn-primary">D</button></a> 
                        <a href="job-title.cfm/tl/e"><button class="btn-primary">E</button></a>
                        <a href="job-title.cfm/tl/f"><button class="btn-primary">F</button></a> 
                        <a href="job-title.cfm/tl/g"><button class="btn-primary">G</button></a> 
                        <a href="job-title.cfm/tl/h"><button class="btn-primary">H</button></a> 
                        <a href="job-title.cfm/tl/i"><button class="btn-primary">I</button></a> 
                        </div>
                        <div class="col-xs-4 grid x-noPR"> 
                        <a href="job-title.cfm/tl/j"><button class="btn-primary">J</button></a> 
                        <a href="job-title.cfm/tl/k"><button class="btn-primary">K</button></a> 
                        <a href="job-title.cfm/tl/l"><button class="btn-primary">L</button></a> 
                        <a href="job-title.cfm/tl/m"><button class="btn-primary">M</button></a> 
                        <a href="job-title.cfm/tl/n"><button class="btn-primary">N</button></a> 
                        <a href="job-title.cfm/tl/o"><button class="btn-primary">O</button></a> 
                        <a href="job-title.cfm/tl/p"><button class="btn-primary">P</button></a> 
                        <a href="job-title.cfm/tl/q"><button class="btn-primary">Q</button></a> 
                        <a href="job-title.cfm/tl/r"><button class="btn-primary">R</button></a> 
                        </div>
                        <div class="col-xs-4 grid  x-noPR"> 
                        <a href="job-title.cfm/tl/s"><button class="btn-primary">S</button></a> 
                        <a href="job-title.cfm/tl/t"><button class="btn-primary">T</button></a> 
                        <a href="job-title.cfm/tl/u"><button class="btn-primary">U</button></a> 
                        <a href="job-title.cfm/tl/v"><button class="btn-primary">V</button></a> 
                        <a href="job-title.cfm/tl/w"><button class="btn-primary">W</button></a>
                        <a href="job-title.cfm/tl/x"><button class="btn-primary">X</button></a> 
                        <a href="job-title.cfm/tl/y"><button class="btn-primary">Y</button></a> 
                        <a href="jobtitle.cfm/tl/z"><button class="btn-primary">Z</button></a> 
                        </div>
                        </div>

                        <div class="row x-PT20">
                            <div class="col-xs-12 x-titles">
                                <cfoutput query="gettitles">
                                    <a class="x-title-item col-xs-6 col-sm-4 col-md-4 col-lg-3" href="/jobs/?kw=#jobtitle#">
                                        <button class="btn-u btn-u-default">#jobtitle#</button>
                                    </a>
                                </cfoutput>
                            </div>
                        </div>

                    </div>

                    <div class="tab-pane fade" id="bycategory">
                    
                    <cfquery name="categories"  datasource="#request.dsn#">
                        select category from categories order by category asc
                    </cfquery>
                    <cfoutput query="categories">
                        <div class ="col"><a href="../jobs/?kw=#category#">#category#</a></div>
                    </cfoutput>
                        
    
                    </div>
                </div>
                      
                    
            </div>
        </div>
    </div>  
</section>
<cfinclude template="../partials/footer.cfm" />
    
<script type="text/javascript" src="/assets/plugins/jquery/jquery.min.js"></script>         
<script type="text/javascript" src="/assets/plugins/jquery/jquery-migrate.min.js"></script>         
<script type="text/javascript" src="/assets/plugins/bootstrap/js/bootstrap.min.js"></script>         
<script type="text/javascript" src="/assets/plugins/back-to-top.js"></script>         
<script type="text/javascript" src="/assets/plugins/smoothScroll.js"></script>         
<!-- JS Page Level -->         
<script type="text/javascript" src="/assets/js/unify-app.js"></script>
<script>
    $(document).ready(function($){
        App.init();

        // replace spaces with +
        $(".tab-content a").each(function() {
            var text = $(this).attr('href')
            text = text.replace(/ /g, "+");
            $(this).prop('href',text);
        });
        
        var hash = window.location.hash;
        $('ul.nav a[href="' + hash + '"]').tab('show');
        
    });
</script>    
    <!--[if lt IE 9]>
	<script src="assets/plugins/respond.js"></script>
	<script src="assets/plugins/html5shiv.js"></script>
	<script src="assets/plugins/placeholder-IE-fixes.js"></script>
	<![endif]-->     
</body>
</html>