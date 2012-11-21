#= require underscore-min.js

$ ->
  $voter = $('#voter');
  $voters = $('#voters');

  $voter.keyup _.throttle( ->
    search = $voter.val()
    return if search.length > 3
    voters = find search

    $voters.empty()

    _.chain(voters)
    .map (voter) ->
      li = document.createElement('li');
      li.innerText = voter.fullName
      li 
    .each (li) ->
      $voters.append li
  , 500) 

find = (input) ->
  _.chain(all)
  .filter (voter) ->
    contains voter.fullName, input
  .value()

contains = (left, right) ->
  left.indexOf(right) != -1
all = [ {fullName: "Ryan Cromwell"}, {fullName: "John Doe"} ]
