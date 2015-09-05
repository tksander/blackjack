assert = chai.assert
expect = chai.expect

describe 'AppModel', ->
  sinon.spy Deck.prototype, 'reshuffle'
  # sinon.spy App.prototype, 'redeal'
  app = null
  deck = null

  beforeEach ->
    app = new App()
    deck = new Deck()

  describe 'reshuffle', ->
    it 'should reshuffle when card count less than/equal to 10', ->
      # set to deck of 10
      newCardArr = []
      for num in [0...10]
        card = new Card
          rank: 8
          suit: 1
        newCardArr.push card 
      deck.reset newCardArr
      app.set 'deck', deck
      app.redeal()
      # check if reshuffle is called
      expect(app.get('deck').reshuffle).to.have.been.called
      assert.strictEqual deck.length, 100

