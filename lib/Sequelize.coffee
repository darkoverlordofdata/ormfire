###
 *
 * Sequelize
 *
###

Firebase = require('firebase')
DataTypes = require('sequelize/lib/data-types')
QueryInterface = require('./QueryInterface')
Migrator = require('./Migrator')
Model = require('./Model')

module.exports = class Sequelize

  do => # mixin DataTypes
    @[key] = type for key, type of DataTypes
    return

  models          : null
  queryInterface  : null  # Instance of QueryInterface
  migrator        : null  # Instance of Migrator
  importCache     : null  # imported instance cache
  token           : ''    # custom auth token
  system          : null  # system data
  ref             : null  # reference to firebase root


  ###
   * Instantiate sequelize with an URI
   * @name Sequelize
   * @constructor
   *
   * @param {String} uri A full database URI
   * @param {String} auth token
   * @paran {Function} next async
   ###
  constructor: (@uri, @token, next) ->
    @importCache = {}
    @models = {}
    @ref = new Firebase(@uri)
    @ref.authWithCustomToken @token, (err, auth) =>
      if err
        throw err
      else
        next(@getQueryInterface(), DataTypes)

    @ref.child('system').on 'value', (snapshot) =>
      # keep the system data refreshed
      @system = snapshot.val()
      return

  getDialiect: => 'firebase'

  model: (name) => @models[name]

  isDefined: (name) => @models[name]?

  drop: (options) =>
    for name, model of @models
      model.drop(options)

  ###
   * Define a new model, representing a table in the DB.
  ###
  define: (name, attrs) =>
    @models[name] = new Model(this, name, attrs)

  ###
   * Imports a model defined in another file, a model file
   * that wraps a call to sequelize.define
  ###
  import: (path) =>
    if not @importCache[path]
      defineCall = require(path)
      @importCache[path] = defineCall(this, DataTypes)
    return @importCache[path];

  ###
   * Returns an instance (singleton) of Migrator.
  ###
  getMigrator: (options, force) =>
    @migrator = if force then new Migrator(this, options) else @migrator ? new Migrator(this, options)

  ###
   * Returns an instance of QueryInterface.
  ###
  getQueryInterface: =>
    @queryInterface = @queryInterface ? new QueryInterface(this)
