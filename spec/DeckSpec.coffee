assert = chai.assert
expect = chai.expect

describe 'deck', ->
  deck = null
  hand = null
  app = null
  spy = null
  testObj = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()
    app = new App()
    testObj = 
      test: -> alert("hi") 

    sinon.spy app, 'dealerPlay'
    # sinon.spy testObj, 'test'

  describe 'hit', ->
    it 'should give the last card from the deck', ->
      assert.strictEqual deck.length, 102
      assert.strictEqual deck.last(), hand.hit()
      assert.strictEqual deck.length, 101
  describe 'stand', ->
    it 'should invoke dealerPlay', ->
      # testObj.test()
      # console.log(expect(testObj.test).to.have.been.called)
    it 'should invoke dealerPlay', ->
      (app.get 'playerHand').stand()
      console.log(app.dealerPlay)
      console.log(expect(app.dealerPlay).to.have.been.called)
    it 'should have dealer hit if dealer has 16', ->
      newCardArr = []
      for num in [0..10]
        card = new Card
          rank: 8
          suit: 1
        newCardArr.push card 
      deck.reset newCardArr
      app.set 'deck', deck
      app.redeal()
      hand.stand()
      expect(app.dealerPlay).to.have.been.called
      expect((app.get 'dealerHand').at(0).get('revealed')).to.be.true


      



