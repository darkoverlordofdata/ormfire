###
  Migrate

  expects the cwd to look like:
  ./config/config.json
  ./migrations/ ...
  ./mpdels/ ...

###
unless process.env.FIREBASE_AUTH?
  process.exit(console.log('Environment FIREBASE_AUTH not set'))

fs = require('fs')
path = require('path')
orm = require('../../lib')(process.cwd(), process.env.FIREBASE_AUTH)

module.exports =
  migrate: (direction='up') ->
    console.log 'ormfire v'+require('../../package.json').version
    console.log ''
    migrations = path.resolve(process.cwd(), './migrations')
    orm.init (queryInterface, Sequelize) ->

      console.log 'Environment: '+queryInterface.sequelize.options.env
      migrator = queryInterface.sequelize.getMigrator(path:migrations, filesFilter: /\.coffee$/)
      migrator.migrate method: direction

