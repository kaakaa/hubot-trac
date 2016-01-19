# Description
#   hubot trac
#
# Configuration:
#   LIST_OF_ENV_VARS_TO_SET
#
# Commands:
#   hubot hello - <what the respond trigger does>
#   orly - <what the hear trigger does>
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   kaakaa[@<org>]
xmlrpc = require 'xmlrpc'

options =
  host: "localhost"
  port: 8080
  path: "/tra/SampleProject/login/xmlrpc"
  digest_auth:
    user: "admin"
    pass: "admin"

module.exports = (robot) ->
  robot.respond /trac info/, (msg) ->
    msg.reply JSON.stringify(options)

  robot.respond /ticket ([1|2|3|5|8|13|21]) (.+)$/i, (msg) ->
    client = xmlrpc.createClient(options)
    client.methodCall 'ticket.create', [msg.match[2], msg.match[1]], (err, ticket) ->
      msg.send err
      if `err == null`
        msg.send "http://" + options.host + ":" + options.port + "/trac/SampleProject/ticket/" + JSON.stringify(ticket)
      else
        msg.send err
    