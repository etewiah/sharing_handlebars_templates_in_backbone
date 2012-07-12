class Raffler.Views.Entry extends Backbone.View
  template: HandlebarsTemplates['entries/entry']
  tagName: 'li'
  
  events:
    'click': 'showEntry'

  initialize: ->
    @model.on('change', @render, this)
    @model.on('highlight', @highlightWinner, this)
    
  showEntry: ->
    Backbone.history.navigate("entries/#{@model.get('id')}", true)

  highlightWinner: ->
    $('.winner').removeClass('highlight')
    @$('.winner').addClass('highlight')

  render: ->
    $(@el).html(@template( @model.toJSON() ))
    #$(@el).html(@template({name: @model.get('name'), winner: @model.get('winner')}))
    this
