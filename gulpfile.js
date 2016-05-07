var gulp = require('gulp');
var concat = require('gulp-concat');
var uncss = require('gulp-uncss');
var cleanCSS = require('gulp-clean-css');

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

gulp.task('concatCSS', function() {
  return gulp.src('dist/assets/css/*.css')
    //.pipe(concat('app.css'))
    .pipe(gulp.dest('dist/assets/css/'));
});
        

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
    gulp.src('model/*.*').pipe(gulp.dest('dist/model/'));
    gulp.src('meta/*.*').pipe(gulp.dest('dist/meta/'));
    gulp.src('controller/*.*').pipe(gulp.dest('dist/controller/'));
    gulp.src('partials/*.*').pipe(gulp.dest('dist/partials/'));
    gulp.src('jobs/*.*').pipe(gulp.dest('dist/jobs/'));
    gulp.src('browse-jobs/*.*').pipe(gulp.dest('dist/browse-jobs/'));
    gulp.src('salaries/*.*').pipe(gulp.dest('dist/salaries/'));
    gulp.src('about/*.*').pipe(gulp.dest('dist/about/'));
    gulp.src('privacy/*.*').pipe(gulp.dest('dist/privacy/'));
    
    
    gulp.src('assets/css/app.css').pipe(gulp.dest('dist/assets/css/'));
    //gulp.src('assets/css/u-dark-blue.css').pipe(gulp.dest('dist/assets/css/'));
    gulp.src('assets/css/grid-ms.css').pipe(gulp.dest('dist/assets/css/'));
    gulp.src('assets/img/**/*.*').pipe(gulp.dest('dist/assets/img/'));
    gulp.src('assets/images/**/*.*').pipe(gulp.dest('dist/assets/images/'));
    
    
    gulp.src('assets/plugins/bootstrap/**/*.*').pipe(gulp.dest('dist/assets/plugins/bootstrap/'));
    gulp.src('assets/plugins/jquery/**/*.*').pipe(gulp.dest('dist/assets/plugins/jquery/'));
    gulp.src('assets/plugins/back-to-top.js').pipe(gulp.dest('dist/assets/plugins/'));
    gulp.src('assets/plugins/wow-animations/js/wow.min.js').pipe(gulp.dest('dist/assets/plugins/wow-animations/js/'));    
    gulp.src('assets/plugins/smoothScroll.js').pipe(gulp.dest('dist/assets/plugins/'));
    gulp.src('assets/plugins/jquery.parallax.js').pipe(gulp.dest('dist/assets/plugins/'));
    gulp.src('assets/plugins/image-hover/**/*.*').pipe(gulp.dest('dist/assets/plugins/image-hover'));
    gulp.src('assets/plugins/owl-carousel/**/*.*').pipe(gulp.dest('dist/assets/plugins/owl-carousel'));
    gulp.src('assets/plugins/font-awesome/**/*.*').pipe(gulp.dest('dist/assets/plugins/font-awesome/'));
    gulp.src('assets/plugins/animate.css').pipe(gulp.dest('dist/assets/plugins/'));   
    gulp.src('bootstrap/css/offcanvas.css').pipe(gulp.dest('dist/bootstrap/css/'));
    gulp.src('assets/plugins/line-icons/line-icons.css').pipe(gulp.dest('dist/assets/plugins/line-icons/'));
    gulp.src('assets/plugins/animated-headline/css/animated-headline.css').pipe(gulp.dest('dist/assets/plugins/animated-headline/css/'));
    gulp.src('assets/plugins/animated-headline/js/animated-headline.js').pipe(gulp.dest('dist/assets/plugins/animated-headline/js/'));
    gulp.src('assets/plugins/animated-headline/js/modernizr.js').pipe(gulp.dest('dist/assets/plugins/animated-headline/js/'));
    

 return
});
           
gulp.task('default',[ 'copy', 'uncss' ]);

