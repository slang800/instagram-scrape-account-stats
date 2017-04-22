should = require 'should'
{validate} = require('json-schema')

{getAccountStats} = require '../lib'
responseSchema = require '../lib/response.schema'

describe 'scrape account stats', ->
  it 'should return properly structured data', ->
    getAccountStats(username: 'slang800').then((account) ->
      validate(account, responseSchema).errors.should.eql([])
    )

describe 'scrape nonexistent account stats', ->
  it 'should return an error', ->
    getAccountStats(username: 'slang800nosuchuser')
      .then((account) ->
        should.fail()
    )
      .catch((err) ->
        should.equal(err.message, 'Username not found')
    )
