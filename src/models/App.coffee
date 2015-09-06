# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @newRound()
    # @startGame()

  defaults: 
    playerScore: 0
    dealerScore: 0
    playerMoney: 25000
    betMoney: 0

  newRound: -> 
    deck = (@get 'deck')
    @set 'playerHand', new Hand [], deck, false
    @set 'dealerHand', new Hand [], deck, true
    (@get 'playerHand').on 'stand', @dealerPlay, @
    (@get 'playerHand').on 'gameOver', @gameOver, @
    (@get 'playerHand').on 'bet', @bet, @
    @trigger 'newRound', @

  startGame: ->
    if (@get 'betMoney') > 0 
      deck = (@get 'deck')
      if deck.length <= 10
        deck.reshuffle()
      @set 'playerHand', (deck.dealPlayer())
      @set 'dealerHand', (deck.dealDealer())
      (@get 'playerHand').on 'stand', @dealerPlay, @
      (@get 'playerHand').on 'gameOver', @gameOver, @
      (@get 'playerHand').on 'bet', @bet, @

      @trigger 'startGame', @
      @checkForBlackjack()
      @set 'gameInProgress', true
    else
      alert('Cannot start game, no money has been bet.')        

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
      null
      # @playerWon()
      # @dealerWon()
    # alert "player score :   #{@get 'playerScore' }"
    # alert "dealer score : #{@get 'dealerScore' }"
    @startGame

  playerWon: -> 
    @set 'playerScore', (@get 'playerScore') + 1
    @set 'playerMoney', (@get 'playerMoney') + (@get 'betMoney') * 2
    @set 'betMoney', 0
    @set 'gameInProgress', false

  dealerWon: ->
    @set 'dealerScore', (@get 'dealerScore') + 1
    @set 'betMoney', 0
    @set 'gameInProgress', false

  checkForBlackjack: ->
    playerScore = (@get 'playerHand').scores()[1]
    if playerScore == 21 then (@get 'playerHand').stand()

  playerHit: ->
    if not @get 'gameInProgress'
      alert('Cannot hit, game has not started!')
    else 
      (@get 'playerHand').hit()

  playerStand: ->
    if not @get 'gameInProgress'
      alert('Cannot stand, game has not started!')
    else
      (@get 'playerHand').stand()

  bet: (money)->
    if @get 'gameInProgress' 
      alert('Game in progress, you cannot bet.')
    else if (@get 'playerMoney') is 0
      alert('You have no more money.')
    else
      @set 'betMoney', (@get 'playerMoney') + (@get 'betMoney')
      @set 'playerMoney', 0
      
      