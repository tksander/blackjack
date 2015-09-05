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
    @set 'playerHand', ((@get 'deck').dealPlayer())
    @set 'dealerHand', ((@get 'deck').dealDealer())
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
    playerScore = (@get 'playerHand').minScore()
    dealerScore = (@get 'dealerHand').minScore()

    if playerScore > 21 then @playerWon()
    else if dealerScore > 21 then @dealerWon()
    else if playerScore > dealerScore then @playerWon()
    else if dealerScore > playerScore then @dealerWon()
    else if dealerScore == playerScore  
      @playerWon()
      @dealerWon()
    @redeal

  playerWon: -> 
    @set 'playerScore', @get 'playerScore' + 1

  dealerWon: ->
    @set 'dealerScore', @get 'dealerScore' + 1

  checkForBlackjack: ->
    alert('blackjack!')
    playerScore = (@get 'playerHand').scores()[1]
    if playerScore == 21 then (@get 'playerHand').stand()



  