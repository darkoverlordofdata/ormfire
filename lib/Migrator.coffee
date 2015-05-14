###
 *
 * Migrator
 *
###

fs = require('fs')
path = require('path')
Sequelize = require('./Sequelize')
DataTypes = require('sequelize/lib/data-types')


module.exports = class Migrator

  constructor: (@sequelize, options={}) ->
    @path = options.path
    @filesFilter = options.filesFilter or /\.coffee$/

  migrate: (options={}, done) =>
    method = options.method or 'up'

    fs.readdirSync(@path).filter((file) =>
      @filesFilter.test(file)
    ).forEach (file) =>
      ext = path.extname(file)
      file = path.basename(file, ext)

      @sequelize.ref.child('system/sequelizemeta/'+file)
      .once 'value', (data) =>
        if not data.exists()
          #
          # do the migration
          #
          start = Date.now()
          migration = require(path.join(@path, file))
          migration[method] @sequelize.getQueryInterface(), DataTypes, =>


            console.log '== '+file+': migrated ('+(Date.now()-start)/1000+'s)'
            def = {}
            def[file] = method
            @sequelize.ref.child('system/sequelizemeta').update(def)








