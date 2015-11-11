// rm temp file
require('fs').unlink('./.tmp/app.js', function () {
  // transpile coffeescript
  require('child_process').exec(`mkdir -p .tmp && coffee -c -o .tmp/ src/`, function (error, stdout, stderr) {
    // perform rollup
    require('util').puts(stdout);
    require( 'rollup' )
      .rollup({ entry: './.tmp/app.js'})
      .then( function ( bundle ) {
        ['amd', 'cjs', 'es6', 'iife', 'umd'].forEach(function (e) {
          bundle.write({ format: e, dest: 'dist/index.' + e + '.js' });    
      });
    });
  });
});