###

      )              (
   ( /(              )\ )
   )\()) (      )   (()/( (  (     (
  ((_)\  )(    (     /(_)))\ )(   ))\
    ((_)(()\   )\  '(_))_((_|()\ /((_)
   / _ \ ((_)_((_)) | |_  (_)((_|_))
  | (_) | '_| '  \()| __| | | '_/ -_)
   \___/|_| |_|_|_| |_|   |_|_| \___|


  Use sequelize interface and metadata
  to provide a half a orm for Firebase

  Intercept references to ./db/models/index.coffee
  Instead, we invoke ./db/models.coffee

###
fs = require('fs')
path = require('path')
yaml = require('yamljs')
Sequelize = require('./Sequelize')

###
 * Initialize the ORM
 *
 * @param dirname   model folder
 * @param token     authorization token for Firebase access
 * @param schema    optional Blaze schema
 *
###
module.exports = (dirname, token, rules='rules.yaml') ->
  init: (callback=->) ->
    rules = path.join(dirname, rules)
    schema = if fs.existsSync(rules) then yaml.load(rules).schema else {}
    config_file = path.join(dirname, "config/config.json")
    env = process.env.NODE_ENV or "development"
    config = require(config_file)[env]
    options =
      env: env
      token: token
      schema: schema
      config_file: config_file

    @sequelize = new Sequelize(config.firebase, options, callback)
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

