"use strict"
module.exports = (sequelize, DataTypes) ->
  Katra = sequelize.define("Katra",
    active: DataTypes.BOOLEAN
    slug: DataTypes.STRING
    title: DataTypes.STRING
    description: DataTypes.STRING
    image: DataTypes.STRING
    url: DataTypes.STRING
  ,
    classMethods:
      associate: (models) ->
  )
  
  # associations can be defined here
  Katra