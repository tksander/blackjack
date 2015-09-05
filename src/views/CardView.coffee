class window.CardView extends Backbone.View
  className: 'card'

  template: _.template '<%= rankName %> of <%= suitName %>'

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    # debugger;
    @$el.html @template @model.attributes
    @$el.addClass 'covered' unless @model.get 'revealed'

