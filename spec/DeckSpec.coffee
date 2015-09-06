assert = chai.assert
expect = chai.expect

describe 'deck', ->
  deck = null
  hand = null
  app = null
  spy = null
  testObj = null
  sinon.spy App.prototype, 'dealerPlay'
  sinon.spy Hand.prototype, 'stand'

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()
    app = new App()

  describe 'hit', ->
    it 'should give the last card from the deck', ->
      assert.strictEqual deck.length, 102
      assert.strictEqual deck.last(), hand.hit()
      assert.strictEqual deck.length, 101
  describe 'stand', ->
    it 'should invoke dealerPlay', ->
      (app.get 'playerHand').stand()
      expect(app.dealerPlay).to.have.been.called
    it 'should have dealer hit if dealer has 16', ->
      newCardArr = []
      for num in [0..10]
        card = new Card
          rank: 8
          suit: 1
        newCardArr.push card 
      deck.reset newCardArr
      app.set 'deck', deck
      app.startGame()
      (app.get 'playerHand').stand()
      expect(app.dealerPlay).to.have.been.called
      expect((app.get 'dealerHand').at(0).get('revealed')).to.be.true
    it 'should have dealer stand if dealer has 18', ->
      newCardArr = []
      for num in [0..10]
        card = new Card
          rank: 9
          suit: 1
        newCardArr.push card 
      deck.reset newCardArr
      app.set 'deck', deck
      app.startGame()
      (app.get 'playerHand').stand()
      expect(app.dealerPlay).to.have.been.called
      expect((app.get 'dealerHand').length).to.equal(2)
    it 'should make player stand if player has blackjack', ->
      newCardArr = []
      for num in [0..10]
        card = if num % 2 == 0 
            new Card
              rank: 1
              suit: 1
          else
            new Card
              rank: 13
              suit: 1
        newCardArr.push card 
      deck.reset newCardArr
      app.set 'deck', deck
      app.startGame()
      
      expect((app.get 'playerHand').stand).to.have.been.called
      # expect((app.get 'dealerHand').length).to.equal(2)

      



