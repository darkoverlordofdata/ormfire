"use strict"
fs = require("fs")
path = require("path")
Sequelize = require("sequelize")
basename = path.basename(module.filename)
env = process.env.NODE_ENV or "development"
config = require(__dirname + "/../config/config.json")[env]
sequelize = new Sequelize(config.database, config.username, config.password, config)
db = {}
fs.readdirSync(__dirname).filter((file) ->
  (file.indexOf(".") isnt 0) and (file isnt basename)
).forEach (file) ->
  model = sequelize["import"](path.join(__dirname, file))
  db[model.name] = model
  return

Object.keys(db).forEach (modelName) ->
  db[modelName].associate db  if "associate" of db[modelName]
  return

db.sequelize = sequelize
db.Sequelize = Sequelize
module.exports = db