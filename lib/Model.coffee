
Firebase = require('firebase')
Promise = require('promise')
inflection = require('inflection')

module.exports = class Model

  ###
   * A Model represents a table in the database.
   *
  ###
  constructor: (@sequelize, @name, @attrs) ->
    @data = new Firebase(@sequelize.uri+"data/"+@name)
    @data.authWithCustomToken @sequelize.token, (err, auth) =>
      console.log err if err

  ###
   * Sync this Model to the DB.
  ###
  sync: () =>
    return new Promise((resolve, reject) ->
      resolve(null)
    )

  ###
   * Builds a new model instance and calls save on it.
  ###
  create: (attrs) =>
    return new Promise((resolve, reject) =>

      console.log 'create'
      if @sequelize.def.ddic[inflection.pluralize(@name)].id.autoIncrement
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

  ###
   * Search for a single instance. This applies LIMIT 1, so the listener will
   * always be called with a single instance.
  ###
  find: (options={}) =>
    return new Promise((resolve, reject) =>
      resolve(null)
    )

  ###
   * Search for multiple instances.
  ###
  findAll: (options={}) =>
    return new Promise((resolve, reject) =>
      resolve(null)
    )

  ###
   * Update multiple instances that match the where options.
  ###
  update: (options={}) =>
    return new Promise((resolve, reject) =>
      resolve(null)
    )

  ###
   * Delete multiple instances,
  ###
  destroy: (options={}) =>
    return new Promise((resolve, reject) =>
      resolve(null)
    )

