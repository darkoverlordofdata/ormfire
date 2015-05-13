###

     ___  ____   ____   __
    /  _]|    \ |    | /  ]
   /  [_ |  D  ) |  | /  /
  |    _]|    /  |  |/  /
  |   [_ |    \  |  /   \_
  |     ||  .  \ |  \     |
  |_____||__|\_||____\____|

  Eric, the Half a Orm

  Use sequelize interface and metadata
  to provide a half a orm for Firebase

  Intercept references to ./db/models/index.coffee
  Instead, we invoke ./db/models.coffee

###
fs = require('fs')
path = require('path')
Sequelize = require('./Sequelize')

module.exports = (dirname, token) ->
  init: (callback) ->
    env = process.env.NODE_ENV or "development"
    config = require(path.join(dirname, "config/config.json"))[env]
    @sequelize = new Sequelize(config.firebase, token, callback)
    @Sequelize = Sequelize
    #
    # Load models
    #
    fs.readdirSync(path.join(dirname, 'models')).filter((file) =>
      (file.indexOf(".") isnt 0) and (file isnt 'index.coffee') and (file isnt 'index.js')
    ).forEach (file) =>
      model = @sequelize.import(path.join(dirname, 'models', file))
      @[model.name] = model
      return
    return this

