# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @redeal()

  defaults: 
    playerScore: 0
    dealerScore: 0

  redeal: ->
    deck = (@get 'deck')
    if deck.length <= 10
      deck.reshuffle()
    @set 'playerHand', (deck.dealPlayer())
    @set 'dealerHand', (deck.dealDealer())
    (@get 'playerHand').on 'stand', @dealerPlay, @
    (@get 'playerHand').on 'gameOver', @gameOver, @
    @trigger 'redeal', @
    @checkForBlackjack()

  events: 
    'gameOver': -> alert('game over!')
   
  dealerPlay: ->
    (@get 'dealerHand').flipBottom()
    while((@get 'dealerHand').minScore() < 17) 
      (@get 'dealerHand').hit()
    @gameOver()

  gameOver: -> 
    playerHighScore = (@get 'playerHand').scores()[1]
    dealerHighScore = (@get 'dealerHand').scores()[1]
    playerMinScore = (@get 'playerHand').minScore()
    dealerMinScore = (@get 'dealerHand').minScore()
    playerScore = if playerHighScore > 21 then playerMinScore else playerHighScore
    dealerScore = if dealerHighScore > 21 then dealerMinScore else dealerHighScore
    if playerScore > 21 then @dealerWon()
    else if dealerScore > 21 then @playerWon()
    else if playerScore > dealerScore then @playerWon()
    else if dealerScore > playerScore then @dealerWon()
    else if dealerScore == playerScore  
      @playerWon()
      @dealerWon()
    # alert "player score :   #{@get 'playerScore' }"
    # alert "dealer score : #{@get 'dealerScore' }"
    @redeal

  playerWon: -> 
    @set 'playerScore', (@get 'playerScore') + 1

  dealerWon: ->
    @set 'dealerScore', (@get 'dealerScore') + 1

  checkForBlackjack: ->
    playerScore = (@get 'playerHand').scores()[1]
    if playerScore == 21 then (@get 'playerHand').stand()



  