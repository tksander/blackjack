class window.ScoreboardView extends Backbone.View
  tagName: 'table'
  template: _.template '
    <tr><th>Player Score</th><th>Dealer Score</th></tr>
    <td><%- playerScore %></td><td><%- dealerScore %></td>
  '


  initialize: ->
    @render()
    @listenTo(@model, "change:playerScore change:dealerScore", @render)

  render: ->
    @$el.html @template(@model.attributes)
    @el
