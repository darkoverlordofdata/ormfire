#unless process.env.FIREBASE_AUTH?
#  process.exit(console.log('Environment FIREBASE_AUTH not set'))

console.log 'Example'

db = require('./db/models')
db.load (queryInterface, Sequelize) ->

  console.log 'migrating...'

  # update system/sequelizemeta key = basename so we only run once
  migration = require('./db/migrations/20150428222013-create-game')
  migration.up(queryInterface, Sequelize)

  migration = require('./db/migrations/20150428222023-create-katra')
  migration.up(queryInterface, Sequelize)

  migration = require('./db/migrations/20150428233702-populate-game')
  migration.up(queryInterface, Sequelize)

  migration = require('./db/migrations/20150428234520-populate-katra')
  migration.up(queryInterface, Sequelize)


