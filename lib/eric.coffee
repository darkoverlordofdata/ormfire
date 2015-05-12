###
  Eric, the half a Orm

  Use sequelize interface and metadata to provide
  a half a orm for Firebase

  Intercept references to ./db/models/index.coffee
  Instead, we invoke ./db/models.coffee

###

FIREBASE_AUTH = ''

fs = require('fs')
path = require('path')
env = process.env.NODE_ENV or "development"
config = require(__dirname + "/config/config.json")[env]
DataTypes = require('sequelize/lib/data-types')
Firebase = require('firebase')
Promise = require('promise')
inflection = require('inflection')

class Model

  constructor: (@sequelize, @name, @attrs) ->

    @data = new Firebase(config.firebase+"data/"+@name)
    @data.authWithCustomToken FIREBASE_AUTH, (err, auth) =>
      console.log 'Model created: '+@name


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



class QueryInterface

  constructor: (@sequelize) ->

  # Create the model
  # doesn't do anything, you have to have data
  createTable: (name, attrs) =>
    return new Promise((resolve, reject) =>
      def = {}
      index = 0
      for key, field of attrs
        field.type = field.type.key
        field.index = index++
      def[name] = attrs
      @sequelize.ddic.update(def)
      resolve(null)
    )

  # Drop the model
  # return a promise
  dropTable: (name) =>
    return new Promise((resolve, reject) =>
      def = {}
      def[name] = {}
      @sequelize.ddic.update(def)
      resolve(null)
    )


class Sequelize

  do => # mixin DataTypes
    @[key] = type for key, type of DataTypes
    return

  queryInterface: null
  def: null
  importCache: null

  constructor: (url) ->
    @importCache = {}
    @queryInterface = new QueryInterface(this)
    @ddic = null
    @ddic = new Firebase(config.firebase+"system/ddic")
    @ddic.authWithCustomToken FIREBASE_AUTH, (err, auth) ->
      console.log 'ddic connected'
    @ddic.on 'value', (data) =>
      @def = data.val()
      console.log 'ddic connected'
      ready(@queryInterface, DataTypes)


  define: (name, attrs) =>
    models[name] = new Model(this, name, attrs)

  import: (path) =>
    if not @importCache[path]
      defineCall = require(path)
      @importCache[path] = defineCall(this, DataTypes)
    return @importCache[path];


sequelize = new Sequelize(config.firebase)

ready = null
models =
  sequelize: sequelize
  Sequelize: Sequelize
  load: (dirname, auth_token, callback) ->
    FIREBASE_AUTH = auth_token
    ready = callback

    #
    # Load models
    #
    fs.readdirSync(path.join(dirname, 'models')).filter((file) ->
      (file.indexOf(".") isnt 0) and (file isnt 'index.coffee') and (file isnt 'index.js')
    ).forEach (file) ->
      model = sequelize["import"](path.join(dirname, 'models', file))
      models[model.name] = model
      return


module.exports = models