#= require underscore-min.js

class Recipient
  constructor: (@target) ->
  display: (voters) ->
    target = @target

    target.empty()

    _.chain(voters)
      .map (voter) ->
        tr = $('<tr>')
        td = $('<td>')
        a = $('<a>').text voter.fullName
        a.attr 'href', '/voter/' + voter.id

        tr.append td
        td.append a
        tr
      .each (el) ->
        target.append el

$ ->
  $voter = $('#voter')
  $voters = $('#voters')

  recipient = new Recipient $voters

  $voter.keyup ->
    _.throttle( qualifiedfind($voter.val(), recipient), 500)
  
qualifiedfind = (criteria, recipient) ->

  voters = if criteria.length > 3 then find criteria else []

  recipient.display voters
  
find = (input) ->
  _.chain(all)
  .take(10)
  .value()

contains = (left, right) ->
  left.indexOf(right) != -1

all = [ {fullName: "Ryan Cromwell"}, {fullName: "John Doe"} ]
