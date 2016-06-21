vows = require 'vows'
assert = require 'assert'
coffeelint = require 'coffeelint'

RULE = 'still_todo'

vows.describe(RULE).addBatch({
    'Block Todo':
        topic:
            '''
            ###
                a normal line inside the block
                Todo: in a block comment

                todo something else

                to do with a space between

                #TODO with a leading hash
                when in a block comment a todo not at the start will not trigger an error
                ToDo like this should though
            ###
            '''

        'block todo': (source) ->
            config = {still_todo: {level: 'warn', module: './src/still_todo'}}
            errors = coffeelint.lint(source, config).filter((error) -> error.rule is RULE)
            assert.lengthOf(errors, 5)
            errors.forEach (error, index) ->
                assert.equal(error.lineNumber, (index + 1) * 2 + 1)

    'Inline Todo':
        topic:
            '''
            # a normal single line comment
            # todo: an inline todo comment

            # todo something else

            # #TODO with a leading hash
            a_var = "String #TODO" #this should not trigger
            callFunc() # the todo: here should though
            b_func = (args) ->
                return [] # return something relevant (should trigger) ToDo

            # to Do with a space between
            '''

        'inline todo': (source) ->
            config = {still_todo: {level: 'warn', module: './src/still_todo'}}
            errors = coffeelint.lint(source, config).filter((error) -> error.rule is RULE)
            assert.lengthOf(errors, 6)
            errors.forEach (error, index) ->
                assert.equal(error.lineNumber, (index + 1) * 2)

}).export(module)
