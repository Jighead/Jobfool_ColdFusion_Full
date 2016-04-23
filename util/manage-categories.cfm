<cfif isDefined('form.category')>
    <cfdump var="#form#">         
    <cfquery name="dupcheck"  datasource="#request.dsn#">
        select category from categories where category = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.category)#" maxlength="100" />
    </cfquery>
   <cfif not dupcheck.recordcount>
    <cfquery name="insert"  datasource="#request.dsn#">
        insert into categories
                (category)
                values 
                (<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.category)#" maxlength="100" />)
    </cfquery>
    </cfif>
        <cflocation addtoken="no" url="manage-categories.cfm">
</cfif>
        
        
    <cfquery name="categories"  datasource="#request.dsn#">
        select category from categories order by id desc
    </cfquery>
    
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

    </head>
<body>
<section>
<div class="container">
    <div class="row">
        <div class="col-xs-12">
        <div id="browse">  
        <section>
            <div class="tab-v1">
                <ul class="nav nav-tabs">
                    <li class="active"><a href="#categories" data-toggle="tab" aria-expanded="true">Manage Categories</a></li>
                    <li class=""><a href="#byTitle" data-toggle="tab" aria-expanded="false">Jobs By Job Title</a></li>
                    <li class=""><a href="#bycategory" data-toggle="tab" aria-expanded="false">Jobs By Category</a></li>
                    <li class=""><a href="#settings" data-toggle="tab" aria-expanded="false">Settings</a></li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane fade active in" id="categories">
                        <div class="panel panel-blue">
                            <div class="panel-heading">
                                <h3 class="panel-title"><i class="fa fa-tasks"></i> Add Category</h3>
                            </div>
                            <div class="panel-body">
                                <form method="post" action="manage-categories.cfm" class="margin-bottom-40 AVAST_PAM_loginform" role="form">
                                    <div class="form-group">
                                        <label for="category">Category</label>
                                        <input type="text" required class="form-control" id="category" name="category" placeholder="Enter category">
                                    </div>
                                    <button type="submit" class="btn-u btn-u-blue">Add</button>
                                </form>
                                
                                <cfoutput query="categories">
                                <ul>
                                    <li>#category#</li>
                                </ul>
                                </cfoutput>
                            </div>
                        </div>
                    </div>

                    <div class="tab-pane fade" id="byTitle">
                        <h2>By Job Title:</h2>	


                    </div>

                    <div class="tab-pane fade" id="bycategory">
                    <h2>Jobs By Category:</h2>

                    </div>
            </div>
        </section>
    

    
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
        $("#x_filters a").each(function() {
            var text = $(this).attr('href')
            text = text.replace(/ /g, "+");
            $(this).prop('href',text);
        });
    });
</script>    
    <!--[if lt IE 9]>
	<script src="assets/plugins/respond.js"></script>
	<script src="assets/plugins/html5shiv.js"></script>
	<script src="assets/plugins/placeholder-IE-fixes.js"></script>
	<![endif]-->     
</body>
</html>