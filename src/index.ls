class Position
  ->
    @index = 0
    @line  = 1
    @col   = 1

  advanceChar: !->
    @index += 1
    @col += 1

  advanceLine: !->
    @index += 1
    @line += 1

  toString: ->
    "#@{index}:{@line},#{@column}"

class Token
EOF = new Token
EOL = new Token

class Scanner
  (@input='')->
    @pos = new Position
    @ch = @peekChar!
    @indents = []
    @lineStart = true

  raiseError: !(desc)->
    throw Error "Scanner error on (#{@pos}): #desc"

  peekChar: (lookahead=0)->
      # Return EOF if index is past the end
      @input[@pos.index + lookahead] or EOF

  nextChar: !->
    if @ch == '\n'
      @pos.advanceLine!
    else
      @pos.advanceChar!
    ch = @peekChar!
    if ch == '\r'
      ch = @peekChar!
      if ch != '\n'
        @raiseError "Expected LF after CR, got: #ch"
    ch = EOL if ch == '\n'
    @ch = ch

  nextToken: !->
    if @lineStart
      @skipEmptyLines
    else
