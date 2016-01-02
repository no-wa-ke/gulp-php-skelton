#! bin/bash
dir=$(PWD)

cd $dir

mkdir www
cat > www/index.php << EOF
<!DOCTYPE html>
<html>
<head>
<title></title>
</head>
<body>
<?php 
echo "hello world!!!";
?> 
</body>
</html>
EOF

npm init
npm install --save-dev gulp
npm install --save-dev gulp-connect-php
npm install --save-dev browser-sync

cat > gulpfile.js << EOF
var gulp = require('gulp'),
connect = require('gulp-connect-php'),
browserSync = require('browser-sync').create();

gulp.task('connect-sync', function() {
  connect.server({
    port:8999,
    base:'www',
  },function(){
    browserSync.init({

      proxy: '127.0.0.1:8999',
      port:8000,
      open:true
    });
  });
  
  gulp.watch('**/*.php').on('change', function () {
    browserSync.reload();
  });
});
gulp.task('reload', function(){ 
  browserSync.reload();
});

gulp.task("default",['connect-sync'],browserSync.reload);

EOF
