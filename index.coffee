regexes =
  lineHasComment: /^\s*[^\#]*\#/
  inlineToDo: /\bto\s?do\b/i
  blockToDo: /^(\s|\#)*to\s?do\b/i

module.exports = class StillToDo
  rule:
    name: 'still_todo'
    level: 'ignore'
    message: 'Still something to be done?'
    description: '''
      This rule checks for the existence of TODO comments. eg:
      <pre>
      <code>
      # todo
      # ToDo
      # TODO
      # TO DO:
      # etc. and also within code blocks
      </code>
      </pre>
      '''

  lintLine: (line, lineApi) ->
    # If we're in a block comment there won't be any tokens on this
    # line. Some previous line holds the token spanning multiple lines.
    tokens = lineApi.tokensByLine[lineApi.lineNumber]
    if not tokens
      if regexes.blockToDo.test(line)
      # assumption is that the TODO will be at the 'beginning' of the line
        return true
      return null

    # To avoid confusion when a string might contain a "#", every string
    # on this line will be removed. before checking for a comment
    _line = line
    for str in (token[1] for token in tokens when token[0] is 'STRING')
      _line = _line.replace(str, 'STRING')

    if regexes.lineHasComment.test(_line)
      line = line.slice(_line.indexOf('#'))
      if regexes.inlineToDo.test(line)
        return true

    null
