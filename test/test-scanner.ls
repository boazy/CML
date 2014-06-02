{ Scanner, EOF, EOL } = require \../lib

consumeAll = (scanner)->
  result = ''
  while scanner.peekChar! != EOF
    result += scanner.peekChar!
    scanner.nextChar!

describe \Scanner !->
  it 'should return EOF when created without input' !->
    scanner = new Scanner
    scanner.peekChar! .should.equal EOF

  it 'should return EOF when created with empty input' !->
    scanner = new Scanner ''
    scanner.peekChar! .should.equal EOF

  it 'should handle end-of-lines properly' !->
    scanner = new Scanner 'Hello World\r\n'
    consumeAll(scanner) .should.be.equal 'Hello World\n'
