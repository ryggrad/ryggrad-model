Theorist   = require 'theorist'
Delegato   = require 'delegato'
Collection = require 'ryggrad-collection'

class Model extends Theorist.Model
  Delegato.includeInto(this)

  @records: ->
    @collection = new Collection() unless @hasOwnProperty('collection')
    @collection

  @delegatesMethods('each', 'map', 'reduce', 'reduceRight', 'find', 'filter', 'where', 'findWhere', 'reject',
                    'every', 'some', 'contains', 'invoke', 'pluck', 'max', 'min', 'sortBy', 'groupBy', 'indexBy',
                    'countBy', 'shuffle', 'sample', 'toArray', 'size', 'partition', 'first', 'last',
                    'remove', 'removeAll', 'findById', 'count', toObject: @records())

  @all:        -> @records()
  @destroy:    -> @remove(arguments...)
  @destroyAll: -> @removeAll(arguments...)

  @create: (atts = {}) ->
    obj = new @(atts)
    invalidMSG = obj.isValid()
    throw new Error(invalidMSG) if invalidMSG
    throw new Error("There is already a model with that id") if @records().ids.hasOwnProperty(obj.id) 
    @records().add(obj)
    obj

  isValid: ->
    @validate() if @validate

  destroy: ->
    @constructor.destroy(this, arguments)

  changeId: (id) ->
    oldid = @id
    @constructor.records().remove(this)
    @set(id: id)
    @constructor.records().add(this)

module.exports = Model
