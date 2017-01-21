{getAccountStats} = require './'
packageInfo = require '../package'
ArgumentParser = require('argparse').ArgumentParser

argparser = new ArgumentParser(
  version: packageInfo.version
  addHelp: true
  description: packageInfo.description
)

group = argparser.addMutuallyExclusiveGroup(required: true)
group.addArgument(
  ['--username', '-u']
  type: 'string'
  help: 'Username of the account to scrape.'
)

argv = argparser.parseArgs()
getAccountStats(argv).then((res) ->
  console.log(JSON.stringify(res))
).catch((err) ->
  if err.message == 'Username not found'
    console.error(err.message)
  else
    console.error(err)
)
