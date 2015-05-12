
DataTypes = require('sequelize/lib/data-types')
Firebase = require('firebase')

QueryInterface = require('./QueryInterface')
Model = require('./Model')

module.exports = class Sequelize

  do => # mixin DataTypes
    @[key] = type for key, type of DataTypes
    return

  @models = {}

  queryInterface: null
  def: null
  importCache: null
  authToken: ''
  next: null

  constructor: (@config, @token, next) ->
    @importCache = {}
    @queryInterface = new QueryInterface(this)
    @ddic = null
    @ddic = new Firebase(@config.firebase+"system/ddic")
    @ddic.authWithCustomToken @token, (err, auth) ->
      console.log 'ddic connected'
    @ddic.on 'value', (data) =>
      @def = data.val()
      console.log 'ddic connected'
      next(@queryInterface, DataTypes)

  define: (name, attrs) =>
    Sequelize.models[name] = new Model(this, name, attrs)

  import: (path) =>
    if not @importCache[path]
      defineCall = require(path)
      @importCache[path] = defineCall(this, DataTypes)
    return @importCache[path];

