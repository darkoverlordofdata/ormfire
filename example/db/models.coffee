#unless process.env.FIREBASE_AUTH?
#  process.exit(console.log('Environment FIREBASE_AUTH not set'))

FIREBASE_AUTH = process.env.FIREBASE_AUTH ? 'tWrPQUQv4zAtMzUHLTtZG97R2XOzBR4YiGNhEunX'

module.exports = require('../../lib/eric')(__dirname, FIREBASE_AUTH)


