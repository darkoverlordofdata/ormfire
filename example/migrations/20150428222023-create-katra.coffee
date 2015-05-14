"use strict"
module.exports =
  up: (queryInterface, Sequelize, done) ->
    queryInterface.createTable("Katras",
      id:
        allowNull: false
        autoIncrement: true
        primaryKey: true
        type: Sequelize.INTEGER

      active:
        type: Sequelize.BOOLEAN

      slug:
        type: Sequelize.STRING

      title:
        type: Sequelize.STRING

      description:
        type: Sequelize.STRING

      image:
        type: Sequelize.STRING

      url:
        type: Sequelize.STRING

      createdAt:
        allowNull: false
        type: Sequelize.DATE

      updatedAt:
        allowNull: false
        type: Sequelize.DATE
    ).then ->
      done()


  down: (queryInterface, Sequelize, down) ->
    queryInterface.dropTable "Katras"