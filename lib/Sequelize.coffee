
DataTypes = require('sequelize/lib/data-types')
Firebase = require('firebase')

QueryInterface = require('./QueryInterface')
Migrator = require('./Migrator')
Model = require('./Model')

module.exports = class Sequelize

  do => # mixin DataTypes
    @[key] = type for key, type of DataTypes
    return

  @models = {}

  queryInterface  : null  # Instance of QueryInterface
  migrator        : null  # Instance of Migrator
  importCache     : null  # imported instance cache
  token           : ''    # custom auth token
  def             : null  # ddic data
  ddic            : null  # Firebase connection system/ddic
  first           : true


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
    @ddic = new Firebase(@uri+"system")
    @ddic.authWithCustomToken @token, (err, auth) ->
      console.log 'ddic connected'
    @ddic.on 'value', (data) =>
      @def = data.val()
      console.log 'ddic updated'
      return unless @first
      @first = false
      next(@getQueryInterface(), DataTypes)

  ###
   * Define a new model, representing a table in the DB.
  ###
  define: (name, attrs) =>
    Sequelize.models[name] = new Model(this, name, attrs)

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
    if force
      @migrator = new Migrator(this, options)
    else
      @migrator = @migrator ? new Migrator(this, options)

  ###
   * Returns an instance of QueryInterface.
  ###
  getQueryInterface: =>
    @queryInterface = @queryInterface ? new QueryInterface(this)
