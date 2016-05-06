regexes =
  camelCase: /^\$?\$?_?_?[a-zA-Z][a-zA-Z\d]*$/
  allCaps: /^[A-Z][_A-Z\d]*$/

module.exports = class StillToDo
  rule:
    name: 'still_todo'
    level: 'warn'
    message: 'Still something ToDo?'
    description: """
      This rule checks for the existence of TODO comments. eg:
      <pre>
      <code>
      # todo
      # ToDo
      # TODO
      # TODO:
      </code>
      </pre>
      """

  tokens: ['IDENTIFIER']

  lintAST: (node, @astApi) ->
      @lintNode node
      undefined

  lintNode: (node) ->
    # It's common to reference a variable as an object property, e.g.
    # MyClass.myVarName, so loop through the next tokens until
    # we find the real identifier
    varName = null
    offset = 0
    while not varName?
      if tokenApi.peek(offset + 1)?[0] is '.'
        offset += 2
      else if tokenApi.peek(offset)?[0] is '@'
        offset += 1
      else
        varName = tokenApi.peek(offset)[1]

    # Now check for the error
    if not regexes.camelCase.test(varName) and not regexes.allCaps.test(varName) and
       varName != '_' and varName != '$'
      return {context: "var name: #{varName}"}
