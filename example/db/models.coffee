unless process.env.FIREBASE_AUTH?
  process.exit(console.log('Environment FIREBASE_AUTH not set'))

module.exports = require('../../lib')(__dirname, process.env.FIREBASE_AUTH)


