
Firebase = require('firebase')
Promise = require('promise')
inflection = require('inflection')

module.exports = class Model

  constructor: (@sequelize, @name, @attrs) ->
    @data = new Firebase(@sequelize.config.firebase+"data/"+@name)
    @data.authWithCustomToken @sequelize.token, (err, auth) =>
      console.log err if err

  # Sync
  # return a promise
  sync: () =>
    return new Promise((resolve, reject) ->
      resolve(null)
    )

  # Create an instance of the model
  # return a promise
  create: (attrs) =>
    return new Promise((resolve, reject) =>

      console.log 'create'
      if @sequelize.def[inflection.pluralize(@name)].id.autoIncrement
        # using push
        console.log 'push'
        @data.push(attrs)

      else
        # using update
        console.log 'update'
        rec = {}
        rec[attrs.id] = attrs
        @data.update(rec)


      resolve(null)
    )

  # Find a record
  # return a promise
  find: (options={}) =>

  # Find several records
  # return a promise
  findAll: (options={}) =>

  # update a record
  # return a promise
  update: (options={}) =>

  # delete a record
  # return a promise
  destroy: (options={}) =>

