'use strict'
gulp        = require 'gulp'
path        = require 'path'
coffee      = require 'gulp-coffee'
runSequence = require 'run-sequence'
coffeelint  = require 'gulp-coffeelint'
mocha       = require 'gulp-mocha'

# Compile 
gulp.task "coffee", ->
  gulp.src('src/coffee/**/*.coffee')
    .pipe coffee(bare: true)
    .pipe gulp.dest('./lib')

gulp.task "lint", ->
  gulp.src("./src/coffee/**/*.coffee")
  .pipe(coffeelint(optFile: "./coffeelint.json"))
  .pipe coffeelint.reporter()

# Testing
gulp.task "test", ->
  gulp.src("./spec/spec.coffee", read: false)
  .pipe(mocha(reporter: 'spec'))

# Register Tasks
gulp.task 'spec', -> runSequence(['lint'], 'coffee', 'test')

gulp.task 'default', ['spec']
