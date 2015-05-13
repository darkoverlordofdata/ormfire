"use strict"
module.exports =
  up: (queryInterface, Sequelize, done) ->
    queryInterface.createTable("Games",
      id:
        allowNull: false
        autoIncrement: true
        primaryKey: true
        type: Sequelize.INTEGER

      active:
        type: Sequelize.BOOLEAN

      name:
        type: Sequelize.STRING

      slug:
        type: Sequelize.STRING

      url:
        type: Sequelize.STRING

      leaderboard:
        type: Sequelize.BOOLEAN

      queue:
        type: Sequelize.STRING

      token:
        type: Sequelize.STRING

      scoring:
        type: Sequelize.STRING

      author:
        type: Sequelize.STRING

      description:
        type: Sequelize.STRING

      version:
        type: Sequelize.STRING

      icon:
        type: Sequelize.STRING

      main:
        type: Sequelize.STRING

      height:
        type: Sequelize.INTEGER

      width:
        type: Sequelize.INTEGER

      createdAt:
        allowNull: false
        type: Sequelize.DATE

      updatedAt:
        allowNull: false
        type: Sequelize.DATE
    ).then ->
      done()

  down: (queryInterface, Sequelize, done) ->
    queryInterface.dropTable "Games"