unless process.env.FIREBASE_AUTH?
  process.exit(console.log('Environment FIREBASE_AUTH not set'))

orm = require('../lib')(__dirname, process.env.FIREBASE_AUTH)

orm.init (queryInterface, Sequelize) ->

  orm.Game.findAll().then (data) ->
    console.log data