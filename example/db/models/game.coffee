"use strict"
module.exports = (sequelize, DataTypes) ->
  Game = sequelize.define("Game",
    active: DataTypes.BOOLEAN
    name: DataTypes.STRING
    slug: DataTypes.STRING
    url: DataTypes.STRING
    leaderboard: DataTypes.BOOLEAN
    queue: DataTypes.STRING
    token: DataTypes.STRING
    scoring: DataTypes.STRING
    author: DataTypes.STRING
    description: DataTypes.STRING
    version: DataTypes.STRING
    icon: DataTypes.STRING
    main: DataTypes.STRING
    height: DataTypes.INTEGER
    width: DataTypes.INTEGER
  ,
    classMethods:
      associate: (models) ->
  )
  
  # associations can be defined here
  Game