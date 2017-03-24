module.exports = function(grunt) {
  grunt.initConfig({
    clean: {
      dist: ['./dist/**/*']
    },

    copy: {
      main: {
        files: [
          {
            expand: true,
            cwd: 'src/js',
            src: '*', 
            dest: 'dist/'
          },
          {
            expand: true,
            cwd: 'src/html',
            src: '*', 
            dest: 'dist/'
          }
        ],
      },
    },

    sass: {
      dist: {
        files: [{
          expand: true,
          cwd: './src/sass/',
          src: ['*.scss'],
          dest: './dist/',
          ext: '.css'
        }],
        options: {
          style: 'compressed',
          sourcemap: 'none'
        }
      }
    },

    watch: {
      files: {
        files: ['src/**/*'],
        tasks: ['build']
      },
    },
  });

  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.loadNpmTasks('grunt-contrib-sass');
  grunt.loadNpmTasks('grunt-contrib-watch');

  grunt.registerTask('default', ['build']);
  grunt.registerTask('build', ['clean', 'sass', 'copy']);
  grunt.registerTask('dev', ['build', 'watch']);
};
