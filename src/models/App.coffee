# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @redeal()

  redeal: -> 
    # debugger;
    console.log(@)
    @set 'playerHand', ((@get 'deck').dealPlayer())
    (@get 'playerHand').on 'gameOver', @gameOver, @
    @set 'dealerHand', ((@get 'deck').dealDealer())
    @trigger 'redeal', @
    (@get 'playerHand').on 'stand', @dealerPlay, @

  events: 
    'gameOver': -> alert('game over!')
   
  dealerPlay: ->
    (@get 'dealerHand').flipBottom()
    alert('called!')
    while((@get 'dealerHand').minScore() < 17) 
      (@get 'dealerHand').hit()
    @gameOver()

  gameOver: -> 
    playerScore = (@get 'playerHand').minScore()
    dealerScore = (@get 'dealerHand').minScore()

    if playerScore > 21 then alert 'Dealer wins!'
    else if dealerScore > 21 then alert 'Player wins!'
    else if playerScore > dealerScore then alert 'Player wins!'
    else if dealerScore > playerScore then alert 'Dealer wins!'
    else if dealerScore == playerScore then alert 'Tie!'
    @redeal




  