"use strict"
module.exports =
  up: (queryInterface, Sequelize, done) ->

    Games = queryInterface.sequelize.models.Game

    Games.sync().then ->
      Games.create(
        active: 1
        name: 'Asteroid Simulator'
        slug: 'asteroids'
        url: 'https://darkoverlordofdata.com/asteroids'
        leaderboard: 0
        queue: 'https://asteroids-d16a.firebaseio.com/scores/'
        token: 'ASTEROIDS_D16A'
        scoring: 'highScore'
        author: 'darkoverlordofdata'
        description: 'Classic Space Rocks using modern physics'
        version: '0.0.1'
        icon: 'asteroids36.png'
        main: 'asteroids.html'
        height: 600
        width: 800
      ).then ->
        done()

  down: (queryInterface, Sequelize, done) ->
