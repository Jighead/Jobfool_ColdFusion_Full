<html>
<head>
</head>
<body>
<article class="content">
    <header class="page-header">
    <h1 class="page-title">Search</h1>
    </header>

    <div id="job-search">
        <form action="" method="post">
            <div class="field">
                <label for="keywords">Keywords</label>
                <input type="text" id="keywords" name="keywords" value="" required autofocus/>
            </div>
            <div class="field">
                <label for="location">Location</label>
                <input type="text" id="location" name="location" value="" required autofocus/>
            </div>
            <div class="field">
                <input type="submit" value="Search">
            </div>
        </form>
        <div id="job-results">
            <div id="job-results-set"></div>
            <div id="job-results-pagination"></div>
        </div>
    </div>
</article>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
 <script src="http://ui.moorealive.com/scripts/jquery.tmpl_1400677949.njs" type="text/javascript"></script>
<script src="js/search.js" type="text/javascript"></script>

<script id="job-result" type="text/x-jquery-tmpl">
        <article class="job-search-result">
            <a href="${url}" target="_blank">
            <h2>${company}</h2>
            <div><strong>Position:</strong> ${jobtitle}</div>
            <div><strong>Location:</strong> ${formattedLocationFull}</div>
            <div><strong>Job Posted:</strong> ${formattedRelativeTime}</div>
            <div class="distance" data-lat="${latitude}" data-lon="${longitude}"><strong>Distance:</strong> </div>
            <div>
                <strong>Description:</strong> {{html snippet}}
            </div>
            </a>
        </article>
</script>
</body>
</html>
