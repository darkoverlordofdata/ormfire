#unless process.env.FIREBASE_AUTH?
#  process.exit(console.log('Environment FIREBASE_AUTH not set'))
#
#orm = require('../lib')(__dirname, process.env.FIREBASE_AUTH)
orm = require('../lib')(__dirname, 'tWrPQUQv4zAtMzUHLTtZG97R2XOzBR4YiGNhEunX')

orm.init (queryInterface, Sequelize) ->

  orm.Game.findAll().then (data) ->
    console.log data