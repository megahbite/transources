module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    favicons: {
      options: {
        trueColor: true,
        precomposed: true,
        windowsTile: true,
        tileBlackWhite: false,
        tileColor: "#001A71",
        appleTouchBackgroundColor: "#001A71",
        html: "app/assets/images/icons/tags.html",
        HTMLPrefix: "image_url(icons/"
      },
      icons: {
        src: 'app/assets/images/logo.256x256.png',
        dest: 'app/assets/images/icons/'
      },
    }
  });

  // Load the plugin that provides the "uglify" task.
  //grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-favicons');

  // Default task(s).
  //grunt.registerTask('default', ['uglify']);
  grunt.registerTask('default', ['favicons']);

};
