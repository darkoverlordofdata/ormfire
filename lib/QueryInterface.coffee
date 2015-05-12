Promise = require('promise')

module.exports = class QueryInterface

  constructor: (@sequelize) ->

  # Create the model
  # doesn't do anything, you have to have data
  createTable: (name, attrs) =>
    return new Promise((resolve, reject) =>
      def = {}
      index = 0
      for key, field of attrs
        field.type = field.type.key
        field.index = index++
      def[name] = attrs
      @sequelize.ddic.update(def)
      resolve(null)
    )

  # Drop the model
  # return a promise
  dropTable: (name) =>
    return new Promise((resolve, reject) =>
      def = {}
      def[name] = {}
      @sequelize.ddic.update(def)
      resolve(null)
    )

