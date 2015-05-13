fs = require('fs')
path = require('path')

module.exports =
  migrate: (direction='up') ->

    models = path.resolve(process.cwd(), './db/models')
    migrations = path.resolve(process.cwd(), './db/migrations')
    db = require(models)
    db.init (queryInterface, Sequelize) ->

      migrator = queryInterface.sequelize.getMigrator(path:migrations, filesFilter: /\.coffee$/)
      migrator.migrate method: direction

