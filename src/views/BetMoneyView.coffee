class window.BetMoneyView extends Backbone.View
  tagName: 'table'
  template: _.template '
    <tr><th>Bet Money</th><th>Wallet</th></tr>
    <td><%- betMoney %></td><td><%- playerMoney %></td>
  '


  initialize: ->
    @render()
    @listenTo(@model, "change:playerMoney change:betMoney", @render)

  render: ->
    @$el.html @template(@model.attributes)
    @el
