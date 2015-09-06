class window.AppView extends Backbone.View
  template: _.template '
  <div class="buttons">
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <button class="startGame-button">Deal</button><button class="bet-button">Bet!</button>
    <button class="startGame-button">Start Game</button>  
    <button class="allIn-button">All in!</button> 
  </div>
  <div class="player-hand-container"></div>
  <div class="dealer-hand-container"></div>

  '

  events:
    'click .hit-button': -> @model.playerHit()
    'click .stand-button': -> @model.playerStand()
    'click .startGame-button': -> @model.startGame()
    'click .bet-button': -> (@model.get 'playerHand').betMoney(1000)
    'click .allIn-button': -> (@model.get 'playerHand').betMoney()

  initialize: ->
    @render()
    @model.on 'startGame', => @render()
    @model.on 'newRound', => @render()

  render: ->
    # debugger
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$el.append(new ScoreboardView({model: @model}).$el)
    @$el.append(new BetMoneyView({model: @model}).$el)


