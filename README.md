# ryggrad-model [![Build Status](https://travis-ci.org/ryggrad/ryggrad-model.svg?branch=master)](https://travis-ci.org/ryggrad/ryggrad-model)

A model class with an activerecordy api. Has properties, validations, find methods, where methods etc.

## Installation and Usage

It is designed to be used through node or browserify; so npm is the only way to get it:

    $ npm install ryggrad-model --save

Declare a class with some properties:

~~~~coffeescript
class Cat extends Model
  @properties 'name', 'fur_level'

  validate: ->
    "Name required" unless @name
~~~~

Then add some cats:

~~~~coffeescript
cat  = Cat.create(name: "Oliver")
cat2 = Cat.create(name: "Revilo, Clone")
~~~~

Find a cat by name:

~~~~coffeescript
cat = Cat.findWhere(name: "Oliver")
console.log cat # => {name: "Oliver"}
~~~~

See spec/spec.coffee for further usage examples.
