#= require underscore-min.js

class Recipient
  constructor: (@target) ->
  display: (voters) ->
    target = @target

    target.empty()

    _.chain(voters)
      .map (voter) ->
        tr = $('<tr>')

        # Name
        td = $('<td>')
        a = $('<a>').text (voter.lastName + ", " + voter.firstName)
        a.attr 'href', '/voter/' + voter.id

        tr.append td
        td.append a

        # city
        td = $('<td>')
        td.text voter.city

        tr.append td
        tr
      .each (el) ->
        target.append el

$ ->
  $voter = $('#q')
  $voters = $('#voters')

  recipient = new Recipient $voters

  $voter.keyup ->
    _.debounce( qualifiedfind($voter.val(), recipient), 1000)

qualifiedfind = (criteria, recipient) ->

  if criteria.length > 3
    find criteria, (voters) ->
      recipient.display voters 
  else []

  
find = (input, callback) ->
  $.get ('/voter?q='+input), (data) ->
    callback data

contains = (left, right) ->
  left.indexOf(right) != -1

