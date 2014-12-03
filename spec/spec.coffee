should = require('chai').should()
Model  = require '../lib/ryggrad-model'

describe "Model", ->
  Asset = undefined
  
  beforeEach ->
    class Asset extends Model
      @properties 'name'

      validate: ->
        "Name required" unless @name

  afterEach ->
    Asset.removeAll()

  it "can create records", ->
    Asset.count().should.equal 0
    asset = Asset.create name: "test.pdf"

    Asset.all()[0].id.should.equal asset.id
    Asset.all()[0].name.should.equal asset.name

    Asset.count().should.equal 1

  it "can update records", ->
    asset = Asset.create name: "test.pdf"
    Asset.all()[0].name.should.equal "test.pdf"

    asset.name = "wem.pdf"
    Asset.all()[0].name.should.equal "wem.pdf"

  it "can destroy records", ->
    asset = Asset.create name: "test.pdf"
    Asset.all()[0].id.should.equal asset.id
    asset.destroy()
    should.not.exist(Asset.all()[0])

  it "can find records", ->
    asset = Asset.create name: "test.pdf", id: "asset2"
    Asset.findById(asset.id).should.be.instanceof Asset
    
    asset_id = asset.id
    asset.destroy()
    Asset.findById(asset_id).should.be.falsey
 
  it "can find records by attribute", ->
    asset = Asset.create name: "cats.pdf"
    asset_found = Asset.findWhere(name: "cats.pdf")
    asset_found.name.should.equal asset.name
 
  it "can return all records", ->
    asset1 = Asset.create(name: "test.pdf")
    asset2 = Asset.create(name: "foo.pdf")
    Asset.all()[0].name.should.equal asset1.name
    Asset.all()[1].name.should.equal asset2.name

  it "can destroy all records", ->
    Asset.create name: "foo1.pdf"
    Asset.create name: "foo2.pdf"
    Asset.count().should.equal 2
    Asset.destroyAll()
    Asset.count().should.equal 0

  it "can validate", ->
    badConstruct = ->
      Asset.create()
    
    badConstruct.should.throw(/Name required/)

  it "clones are dynamic", ->
    asset = Asset.create name: "hotel california"
    clone = Asset.findById(asset.id)
    asset.name = "checkout anytime"
    clone.name.should.equal "checkout anytime"
  
   it "should be able to change ID", ->
     asset = Asset.create name: "hotel california"
     asset.changeId "foo"
     asset.id.should.equal "foo"
     Asset.findById("foo").should.be.truthy
  
     asset.changeId "cat"
     asset.id.should.equal "cat"
     Asset.findById("cat").should.be.truthy
  
  it "should generate unique IDs", ->
    Asset.create
      name: "Bob"
  
    Asset.create
      name: "Bob"

    Asset.create
      name: "Bob"

    Asset.all()[0].id.should.not.equal Asset.all()[1].id
    Asset.all()[1].id.should.not.equal Asset.all()[2].id

  it "should not allow assets with same IDs", ->
    badConstruct = ->
      Asset.create name: "Bob", id: "same"
      Asset.create name: "Bob", id: "same"

    badConstruct.should.throw(/There is already a model with that id/)

   it "should create multiple assets", ->
     i = 0
     while i < 12
       Asset.create name: "Bob"
       i++
  
     Asset.count().should.equal 12
  
  it "should handle more than 10 IDs correctly", ->
    i = 0
  
    while i < 12
      Asset.create name: "Bob", id: i
      i++
  
    Asset.count().should.equal 12
  