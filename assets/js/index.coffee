#= require underscore-min.js

class Recipient
  constructor: (@target) ->
  display: (voters) ->
    target = @target

    target.empty()

    _.chain(voters)
      .map (voter) ->
        li = document.createElement('li')
        li.innerText = voter.fullName
        li
      .each (li) ->
        target.append li

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
