fs = require('fs')
path = require('path')

module.exports =
  migrate: (direction='up') ->


    models = path.resolve(process.cwd(), './db/models')
    migrations = path.resolve(process.cwd(), './db/migrations')
    db = require(models)
    db.init (queryInterface, Sequelize) ->
      console.log 'eric v'+require('../../package.json').version
      console.log ''
      console.log 'Environment: '+queryInterface.sequelize.options.env

      migrator = queryInterface.sequelize.getMigrator(path:migrations, filesFilter: /\.coffee$/)
      migrator.migrate method: direction

