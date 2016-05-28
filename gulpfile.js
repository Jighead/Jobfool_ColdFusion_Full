var gulp = require('gulp');
var sourcemaps = require('gulp-sourcemaps');
var uglify = require('gulp-uglify');
var obfuscate = require('gulp-obfuscate');
var concat = require('gulp-concat');
var uncss = require('gulp-uncss');
var csso = require('gulp-csso');
var cleanCSS = require('gulp-clean-css');
var imagemin = require('gulp-imagemin');
var cache = require('gulp-cache');

gulp.task('uncss', function() {
  var csssource = ['assets/css/app.css'];
  return gulp.src(csssource)
    .pipe(uncss({
            html: ['http://jf16/'
                   ,'http://jf16/jobs/'
                   ,'http://jf16/browse-jobs/'
                   ,'http://jf16/salaries/'
                   ,'http://jf16/privacy/'
                   ,'http://jf16/about/'
                  ]
        }))
  //.pipe(cleanCSS())
  .pipe(gulp.dest('dist/assets/css/'));
});

gulp.task('obfuscate', function() {
  return gulp.src('assets/js/unify-app.js')
    .pipe(obfuscate({ replaceMethod: obfuscate.ZALGO }))
    .pipe(gulp.dest('dist/assets/js/'));
});

gulp.task('uglifyJS', function() {
  return gulp.src('assets/js/unify-app.js')
    .pipe(uglify())
    .pipe(gulp.dest('dist/assets/js/'));
});

gulp.task('csso-app', function() {
  return gulp.src('assets/css/*.css')
    .pipe(sourcemaps.init())
    .pipe(csso())
    .pipe(sourcemaps.write('.'))
    .pipe(gulp.dest('dist/assets/css/'));
});


gulp.task('csso-plugins', function() {
  var files = ['assets/plugins/bootstrap/css/bootstrap.min.css'
               ,'bootstrap/css/offcanvas.css'
               ,'assets/css/grid-ms.css'
               ,'assets/plugins/owl-carousel/owl-carousel/owl.carousel.css'
               ,'assets/plugins/image-hover/css/img-hover.css'
               ,'assets/plugins/animate.css'
               ,'assets/plugins/line-icons/line-icons.css'
               ,'assets/plugins/font-awesome/css/font-awesome.min.css'
               ,'assets/plugins/animated-headline/css/animated-headline.css'
              ];
  return gulp.src(files)
    //.pipe(sourcemaps.init())
    .pipe(csso())
    //.pipe(sourcemaps.write('.'))
    .pipe(gulp.dest('dist/assets/plugins/css/'));
});

/* concat and minify plugins CSS */
gulp.task('buildCSS', function() {
    
    var files = ['assets/plugins/bootstrap/css/bootstrap.min.css'
               ,'bootstrap/css/offcanvas.css'
               ,'assets/css/grid-ms.css'
               ,'assets/plugins/owl-carousel/owl-carousel/owl.carousel.css'
               ,'assets/plugins/image-hover/css/img-hover.css'
               ,'assets/plugins/animate.css'
               ,'assets/plugins/animated-headline/css/animated-headline.css'
              ];
    
gulp.src(files)
    .pipe(concat('plugins.css'))
    .pipe(csso())
    .pipe(gulp.dest('assets/css/'));
    
    
gulp.src('assets/plugins/line-icons/line-icons.css')
    .pipe(concat('line-icons.css'))
    .pipe(csso())
    .pipe(gulp.dest('assets/plugins/line-icons/line-icons.min.css'));
    
});


/* concat and minify plugins JS */
gulp.task('buildJS', function() {
    
 var files = [//'assets/plugins/jquery/jquery223.min.js'
               //,'assets/plugins/jquery/jquery-migrate.min.js'  
               //,'assets/plugins/jquery/additional-methods.js'
              // ,'assets/plugins/jquery/jquery.validate.js'
              // ,'assets/plugins/bootstrap/js/bootstrap.min.js'
              
               ,'assets/plugins/back-to-top.js'
               ,'assets/plugins/smoothScroll.js'
              // ,'assets/plugins/jquery.parallax.js'
               //,'assets/plugins/owl-carousel/owl-carousel/owl.carousel.js'
              // ,'assets/plugins/counter/waypoints.min.js'
               //,'assets/plugins/counter/jquery.counterup.min.js'
              // ,'assets/plugins/wow-animations/js/wow.min.js'
               //,'assets/plugins/animated-headline/js/animated-headline.js'
               //,'assets/plugins/animated-headline/js/modernizr.js'
     
               //,'assets/js/unify-app.js'
              ];
    
        gulp.src(files)
            .pipe(concat('plugins.js'))
            //.pipe(uglify())
            .pipe(gulp.dest('assets/js/'));

});


/* compress images */
gulp.task('images', function(){
  return gulp.src('assets/images/**/*.+(png|jpg|gif|svg)')
  .pipe(cache (imagemin()) )
  .pipe(gulp.dest('dist/assets/images'))
});

/* compress images */            
gulp.task('img', function(){
  return gulp.src('assets/img/**/*.+(png|jpg|gif|svg)')
  .pipe(cache (imagemin()) )
  .pipe(gulp.dest('dist/assets/img'))
});

/* copy files */
gulp.task('copy', function() {
  // copy any html files in source/ to public/
    var rootfiles = ['addalert.cfm'
                    ,'appsettings.cfm'
                    ,'index.cfm'
                    ,'application.cfc'
                    ];
    
    gulp.src(rootfiles).pipe(gulp.dest('dist/'));
    gulp.src('system/config/*.*').pipe(gulp.dest('dist/system/config/'));
    gulp.src('system/udf/*.*').pipe(gulp.dest('dist/system/udf/'));
    gulp.src('system/customtags/*.*').pipe(gulp.dest('dist/system/customtags/'));
    gulp.src('model/*.*').pipe(gulp.dest('dist/model/'));
    gulp.src('meta/*.*').pipe(gulp.dest('dist/meta/'));
    gulp.src('controller/*.*').pipe(gulp.dest('dist/controller/'));
    gulp.src('partials/*.*').pipe(gulp.dest('dist/partials/'));
    gulp.src('jobs/*.*').pipe(gulp.dest('dist/jobs/'));
    gulp.src('browse-jobs/*.*').pipe(gulp.dest('dist/browse-jobs/'));
    gulp.src('salaries/*.*').pipe(gulp.dest('dist/salaries/'));
    gulp.src('about/*.*').pipe(gulp.dest('dist/about/'));
    gulp.src('privacy/*.*').pipe(gulp.dest('dist/privacy/'));
    
    
    //gulp.src('assets/css/app.css').pipe(gulp.dest('dist/assets/css/'));
    //gulp.src('assets/css/u-dark-blue.css').pipe(gulp.dest('dist/assets/css/'));
    gulp.src('assets/css/grid-ms.css').pipe(gulp.dest('dist/assets/css/'));
    //gulp.src('assets/img/**/*.*').pipe(gulp.dest('dist/assets/img/'));
    //gulp.src('assets/images/**/*.*').pipe(gulp.dest('dist/assets/images/'));
    
    
    gulp.src('assets/plugins/bootstrap/**/*.*').pipe(gulp.dest('dist/assets/plugins/bootstrap/'));
    gulp.src('assets/plugins/jquery/**/*.*').pipe(gulp.dest('dist/assets/plugins/jquery/'));
    gulp.src('assets/plugins/back-to-top.js').pipe(gulp.dest('dist/assets/plugins/'));
    gulp.src('assets/plugins/wow-animations/js/wow.min.js').pipe(gulp.dest('dist/assets/plugins/wow-animations/js/'));    
    gulp.src('assets/plugins/smoothScroll.js').pipe(gulp.dest('dist/assets/plugins/'));
    gulp.src('assets/plugins/jquery.parallax.js').pipe(gulp.dest('dist/assets/plugins/'));
    gulp.src('assets/plugins/image-hover/**/*.*').pipe(gulp.dest('dist/assets/plugins/image-hover'));
    gulp.src('assets/plugins/owl-carousel/**/*.*').pipe(gulp.dest('dist/assets/plugins/owl-carousel'));
    gulp.src('assets/plugins/font-awesome/**/*.*').pipe(gulp.dest('dist/assets/plugins/font-awesome/'));
    gulp.src('assets/plugins/counter/jquery.counterup.min.js').pipe(gulp.dest('dist/assets/plugins/counter/'));
    gulp.src('assets/plugins/stickytabs/stickytabs.js').pipe(gulp.dest('dist/assets/plugins/stickytabs/'));
    gulp.src('assets/plugins/respond.js').pipe(gulp.dest('dist/assets/plugins/'));
    gulp.src('assets/plugins/wow-animations/**/*.*').pipe(gulp.dest('dist/assets/plugins/wow-animations/'));
    gulp.src('assets/plugins/*.*').pipe(gulp.dest('dist/assets/plugins/'));   
    gulp.src('bootstrap/css/offcanvas.css').pipe(gulp.dest('dist/bootstrap/css/'));
    gulp.src('assets/plugins/line-icons/**/*').pipe(gulp.dest('dist/assets/plugins/line-icons/'));
    gulp.src('assets/plugins/animated-headline/css/animated-headline.css').pipe(gulp.dest('dist/assets/plugins/animated-headline/css/'));
    gulp.src('assets/plugins/animated-headline/js/animated-headline.js').pipe(gulp.dest('dist/assets/plugins/animated-headline/js/'));
    gulp.src('assets/plugins/animated-headline/js/modernizr.js').pipe(gulp.dest('dist/assets/plugins/animated-headline/js/'));
    gulp.src('assets/favicons/*.*').pipe(gulp.dest('dist/assets/favicons/'));
    

 return
});
           
gulp.task('default',[ 'copy', 'uglifyJS', 'csso-app', 'csso-plugins', 'images', 'img' ]);

