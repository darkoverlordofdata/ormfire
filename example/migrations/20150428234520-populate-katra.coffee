"use strict"
module.exports =
  up: (queryInterface, Sequelize, done) ->

    Katras = queryInterface.sequelize.models.Katra

    Katras.sync().then ->
      Katras.create(
        active: 1,
        slug: 'sttr1',
        title: 'Katra . . .',
        description: 'Like, beam me up, dude.',
        image: 'assets/katra.png'
        url: 'https://darkoverlordofdata.com/katra/run/?basic=hp2k&program=STTR1'
      ).then ->
        Katras.create(
          active: 1,
          slug: 'wumpus',
          title: 'Hunt the Wumpus',
          description: 'What\'s a Wumpus?',
          image: 'assets/wumpus.png'
          url: 'https://darkoverlordofdata.com/katra/run/?basic=atari&program=WUMPUS'
        ).then ->
          Katras.create(
            active: 1,
            slug: 'eliza',
            title: 'Eliza',
            description: 'A shrink with a \'tude.',
            image: 'assets/wumpus.png'
            url: 'https://darkoverlordofdata.com/katra/run/?basic=gwbasic&program=eliza'
          ).then ->
            Katras.create(
              active: 1,
              slug: 'oregon',
              title: 'Oregon',
              description: 'Why do you put your wagons in a circle?<br>To get better Wi-Fi!',
              image: 'assets/oregon.png'
              url: 'https://darkoverlordofdata.com/katra/run/?basic=hp2k&program=OREGON'
            ).then ->
              done()




  down: (queryInterface, Sequelize, done) ->
