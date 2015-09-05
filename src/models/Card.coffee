class window.Card extends Backbone.Model
  initialize: (params) ->
    @set
      revealed: true
      value: if !params.rank or 10 < params.rank then 10 else params.rank
      suitName: ['Spades', 'Diamonds', 'Clubs', 'Hearts'][params.suit]
      rankName: switch params.rank
        when 1 then 'Ace'
        when 11 then 'Jack'
        when 12 then 'Queen'
        when 13 then 'King'
        else params.rank

  flip: ->
    @set 'revealed', !@get 'revealed'
    @
