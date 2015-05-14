###
 *
 * Model
 *
###

Firebase = require('firebase')
Promise = require('promise')
inflection = require('inflection')

module.exports = class Model

  txn   : false # Transactional or Master data?
  db    : null

  ###
   * A Model represents a table in the database.
   *
  ###
  constructor: (@sequelize, @name, @attrs) ->
    @db = @sequelize.ref.child('data/'+@name)


  getTableName: => @name

  drop: (options) =>
    return new Promise((resolve, reject) =>
      @sequelize.ref.child('system/ddic/'+inflection.pluralize(@name)).remove((err) =>
        if (err) then reject(err) else resolve(null)
      )
    )

  ###
   * Sync this Model to the DB.
  ###
  sync: () =>
    return new Promise((resolve, reject) =>
      @sequelize.ref.child('system/ddic/'+inflection.pluralize(@name)+'/id/autoIncrement')
      .once 'value', (snapshot) =>
        @txn = snapshot.val()
        resolve(null)
    )

  ###
   * Builds a new model instance and calls save on it.
  ###
  create: (attrs) =>
    return new Promise((resolve, reject) =>

      if @txn or not attrs.id?
        # Firebase will assign a unique, sequential, key
        @db.push(attrs)

      else
        # Use the id as the key
        rec = {}
        rec[attrs.id] = attrs
        @db.update(rec)

      resolve(null)
    )

  ###
   * Search for a single instance. This applies LIMIT 1, so the listener will
   * always be called with a single instance.
  ###
  find: (options={}, unbox) =>
    # decode options

    if options is true
      options = {}
      unbox = true

    where = options.where
    if where?
      field = Object.keys(where)[0]
      value = where[field]

    return new Promise((resolve, reject) =>
      exec = if where? then @db.orderByChild(field).equalTo(value).limitToFirst(1) else @db.limitToFirst(1)
      exec.once 'value', (snapshot) =>
        if unbox and @txn
          data = snapshot.val()
          resolve(data[Object.keys(data)[0]])
        else
          resolve(snapshot.val())
    )

  ###
   * Search for multiple instances.
  ###
  findAll: (options={}, unbox) =>

    if options is true
      options = {}
      unbox = true

    where = options.where
    if where?
      field = Object.keys(where)[0]
      value = where[field]

    return new Promise((resolve, reject) =>
      exec = if where? then @db.orderByChild(field).equalTo(value) else @db
      exec = if options.limit? then exec.limitToFirst(options.limit) else exec
      exec.once 'value', (snapshot) =>
        if unbox and @txn
          resolve((val for key, val of snapshot.val()))
        else
          resolve(snapshot.val())
    )

  ###
   * Update instance that match the where options.
  ###
  update: (value, options={}) =>
    where = options.where
    if where?
      field = Object.keys(where)[0]
      value = where[field]

    return new Promise((resolve, reject) =>
      exec = if where? then @db.orderByChild(field).equalTo(value).limitToFirst(1) else @db.limitToFirst(1)
      exec.once 'value', (snapshot) ->
        snapshot.ref().update(value)
        resolve(null)
    )

  ###
   * Delete multiple instances,
  ###
  destroy: (options={}) =>

    where = options.where
    if where?
      field = Object.keys(where)[0]
      value = where[field]

    return new Promise((resolve, reject) =>
      exec = if where? then @db.orderByChild(field).equalTo(value).limitToFirst(1) else @db.limitToFirst(1)
      exec.once 'value', (snapshot) ->
        snapshot.ref().remove()
        resolve(null)
    )

