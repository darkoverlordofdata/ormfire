###
 *
 * QueryInterface
 *
###

Promise = require('promise')

module.exports = class QueryInterface

  ###
   * The interface that Sequelize uses to talk to all databases
   * @class QueryInterface
  ###
  constructor: (@sequelize) ->

  createTable: (name, attrs) =>
    return new Promise((resolve, reject) =>
      def = {}
      index = 0
      for key, field of attrs
        field.type = field.type.key
        field.index = index++
      def[name] = attrs
      @sequelize.ref.child('system/ddic').update(def)
      resolve(null)
    )

  dropTable: (name) =>
    return new Promise((resolve, reject) =>
      def = {}
      def[name] = {}
      @sequelize.ref.child('system/ddic').update(def)
      resolve(null)
    )

