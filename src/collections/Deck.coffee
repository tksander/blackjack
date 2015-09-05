class window.Deck extends Backbone.Collection
  model: Card

  initialize: ->
    @add _([0...104]).shuffle().map (card) ->
      card = card % 52
      new Card
        rank: card % 13 + 1
        suit: Math.floor(card / 13)

  dealPlayer: -> 
    new Hand [@pop(), @pop()], @, false

  dealDealer: -> new Hand [@pop().flip(), @pop()], @, true

  reshuffle: -> 
    @reset()
    @initialize()
