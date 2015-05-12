#unless process.env.FIREBASE_AUTH?
#  process.exit(console.log('Environment FIREBASE_AUTH not set'))

FIREBASE_AUTH = process.env.FIREBASE_AUTH ? 'tWrPQUQv4zAtMzUHLTtZG97R2XOzBR4YiGNhEunX'

eric = require('./eric')
eric.load __dirname, FIREBASE_AUTH, (queryInterface, Sequelize) ->

  console.log 'migrating...'

  migration = require('./migrations/20150428222013-create-game')
  migration.up(queryInterface, Sequelize)

  migration = require('./migrations/20150428222023-create-katra')
  migration.up(queryInterface, Sequelize)

  migration = require('./migrations/20150428233702-populate-game')
  migration.up(queryInterface, Sequelize)

  migration = require('./migrations/20150428234520-populate-katra')
  migration.up(queryInterface, Sequelize)


module.exports = eric
