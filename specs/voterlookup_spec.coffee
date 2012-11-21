
describe 'voterlookup', ->
  lookup = require '../assets/js/voterlookup'
  wasreset = false

  lookup.onreset ->
    wasreset = true

  it 'will clear results when criteria is empty', ->
    lookup.find ''

    expect(wasreset).toBe true
  it 'will clear results when criteria less than minlength', ->
    lookup.find ''

    expect(wasreset).toBe true

  it 'will provide results when criteria is > minlength', ->
    results = false

    lookup.onresults ->
      results = true

    lookup.find ''

    expect(results).toBe true
